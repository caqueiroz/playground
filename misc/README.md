# BASH

**1) ssh rsa key finger print**
```
cqueiroz@cqueiroz:~/.ssh$ ssh-keygen -lf id_rsa -E md5
2048 MD5:0e:a9:0e:79:84:2e:46:99:d7:c4:37:3c:6c:25:88:2f no comment (RSA)
```

**2) extract make args**
```
# Extract tag arguments
ifeq (tag,$(firstword $(MAKECMDGOALS)))
  TAG_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  ifeq ($(TAG_ARGS),)
    $(error You must specify a tag)
  endif
  $(eval $(TAG_ARGS):;@:)
endif
```
> Consuming the args
```
@ $(foreach tag,$(TAG_ARGS), echo $tag);)
```
**3) Getting the CA and server certificate (pub) using openssl***
```
openssl s_client -connect citrix.blablabla.com:443 --showcerts | sed -n '/BEGIN/,/END/p'
```
> automatic way to separate each cert dumped into its respective file```

```
openssl s_client -showcerts -verify 5 -connect citrix.blablabla.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".pem"; print >out}'

```
