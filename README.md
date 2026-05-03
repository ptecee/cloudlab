# Cloud Lab

Данный код создает виртуальную машину c внешним ip в облаке Yandex Cloud.


## Файл `terraform.tfvars`
Перед созданием VM, необходимо создать файл `terrafrom.tfvars` с след. переменными:
```tf
yandex_token        = <yc iam create-token>
yandex_cloud_id     = <yc config get cloud-id>
yandex_folder_id    = <yc config get folder-id>
```

## Создание и удаление VM

Применить когнфигурацию Terraform
```shell
terrafrom init
terrafrom plan
terrafrom apply
```

Уничтожить ресурсы:
```shell
terraform destroy
```

## Проблемы которые могут возникнуть

При возникновении ошибки в `/var/log/cloud-init-output.log`:
```
2025-11-08 10:01:59,480 - __init__.py[WARNING]: Unhandled non-multipart (text/x-not-multipart) userdata: 'b'# cloud-config\\r'...'
```

`# cloud-config\\r` - это значит что в файле используются Windows-style переносы строк (CRLF вместо LF).

Исправляется командой (данную команду следует выполнять до создания VM):
```shell
sed -i 's/\r$//' scripts/cloud-init.yaml
```
