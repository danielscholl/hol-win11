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
