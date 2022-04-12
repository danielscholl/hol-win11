```json
        {
          "name": "Disk Encryption",
          "type": "extensions",
          "location": "[parameters('location')]",
          "apiVersion": "2020-06-01",
          "properties": {
            "publisher": "Microsoft.Azure.Security",
            "type": "AzureDiskEncryption",
            "typeHandlerVersion": "2.2",
            "autoUpgradeMinorVersion": true,
            "forceUpdateTag": "1.0",
            "settings": {
              "EncryptionOperation": "EnableEncryption",
              "KeyVaultURL": "[reference(variables('kvId'), '2021-10-01').vaultUri]",
              "KeyVaultResourceId": "[variables('kvId')]",
              "KeyEncryptionKeyURL": "[parameters('keyEncryptionKeyURL')]",
              "KekVaultResourceId": "[variables('keyVaultResourceID')]",
              "KeyEncryptionAlgorithm": "RSA-OAEP",
              "VolumeType": "All",
              "ResizeOSDisk": "false"
            }
          }
        }
```

```json
   {
      "type": "Microsoft.Compute/diskEncryptionSets",
      "apiVersion": "2021-12-01",
      "name": "[variables('diskencsetName')]",
      "location": "[parameters('location')]",
      "dependsOn": [
        "[resourceId('Microsoft.KeyVault/vaults/keys', variables('kvName'), variables('keyName'))]"
      ],
      "identity": {
        "type": "SystemAssigned"
      },
      "properties": {
        "activeKey": {
          "sourceVault": {
            "id": "[resourceId('Microsoft.KeyVault/vaults', variables('kvName'))]"
          },
          "keyUrl": "[reference(resourceId('Microsoft.KeyVault/vaults/keys', variables('kvName'), variables('keyName')), '2021-10-01', 'Full').properties.keyUriWithVersion]"
        }
      }
    },
    {
      "type": "Microsoft.KeyVault/vaults/accessPolicies",
      "apiVersion": "2021-10-01",
      "name": "[concat(variables('kvName'), '/add')]",
      "dependsOn": [
        "[resourceId('Microsoft.Compute/diskEncryptionSets', variables('diskencsetName'))]"
      ],
      "properties": {
        "accessPolicies": [
          {
            "tenantId": "[subscription().tenantId]",
            "objectId": "[reference(resourceId('Microsoft.Compute/diskEncryptionSets', variables('diskencsetName')), '2021-12-01', 'Full').identity.PrincipalId]",
            "permissions": {
              "keys": [
                "Get",
                "WrapKey",
                "UnwrapKey"
              ],
              "secrets": [],
              "certificates": []
            }
          }
        ]
      }
    }
```
