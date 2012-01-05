Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0538L9w031961
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2012 22:08:21 -0500
Received: from mail-we0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0538J63012321
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2012 03:08:20 GMT
Received: by werm12 with SMTP id m12so74704wer.12
        for <selinux@tycho.nsa.gov>; Wed, 04 Jan 2012 19:08:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F047391.202@redhat.com>
References: <CANvtKVYZsPZwzmXjwTv672Usd7zQKiY_dfvht7mp3Rkcn7Gi2g@mail.gmail.com>
	<4F047391.202@redhat.com>
Date: Thu, 5 Jan 2012 11:08:19 +0800
Message-ID: <CANvtKVY3sWvfn1Kwa1GDCaYEYemdAJ35V5jytCgRJedMfKXv7w@mail.gmail.com>
Subject: Re: Use specified semanage.conf for cross compiling
From: Xin Ouyang <xinpascal@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=0016e6d7ea90888c3e04b5bf3e61
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d7ea90888c3e04b5bf3e61
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks.

I think it is better to retain the access function .
If there is no semanage.conf in the target, we will use the one in the
host instead.

+const char *semanage_conf_path(void)
+{
+       if (private_semanage_conf_path
+               && access(private_semanage_conf_path, R_OK) =3D=3D 0)
+               return private_semanage_conf_path;
+
+       return SEMANAGE_CONF_PATH;
+}
+

:)
- Pascal

2012/1/4 Daniel J Walsh <dwalsh@redhat.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/04/2012 03:57 AM, Xin Ouyang wrote:
>> Hi all,
>>
>> For some cross compiling cases, I need to use semodule to create
>> the policy store at build time. It is, semodule -n -b base.pp -i
>> some.pp .. -p $TARGET_ROOT
>>
>> With this, semodule will use /etc/selinux/semanage.conf by calling
>> semanage_handle_create():
>>
>> // libsemanage/src/handle.c semanage_handle_t
>> *semanage_handle_create(void) { semanage_handle_t *sh =3D NULL; const
>> char *conf_name =3D NULL;
>>
>> /* Allocate handle */ if ((sh =3D calloc(1,
>> sizeof(semanage_handle_t))) =3D=3D NULL) goto err;
>>
>> if ((conf_name =3D semanage_conf_path()) =3D=3D NULL) goto err;
>>
>> if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NULL) goto err;
>>
>> While there may be some different options in =A0semanage.conf for
>> the target, I am trying to specify a special semanage.conf path
>> instead of /etc/selinux/semanage.conf in the build host.
>>
>> Commit 9cd587f5533456e7b26601e27e65744272e2e783 introduced
>> semanage_set_root() as an alternate root for policy stores. So I
>> make a patch to use the semanage.conf in the alternate root. After
>> the patch, semodule -p /target will use
>> /target/etc/selinux/semanage.conf as the config file.
>>
>> Anyone who has better solutions, please
>>
>>
>> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
>> index 7adc1cc..ef36152 100644 --- a/libsemanage/src/handle.c +++
>> b/libsemanage/src/handle.c @@ -41,6 +41,7 @@ #include <string.h>
>> #include <selinux/selinux.h> static char *private_selinux_path =3D
>> NULL; +static char *private_semanage_conf_path =3D NULL; static char
>> *private_file_context_path =3D NULL; static char
>> *private_file_context_local_path =3D NULL; static char
>> *private_file_context_homedir_path =3D NULL; @@ -52,6 +53,7 @@ static
>> char *private_policy_root =3D NULL;
>>
>> void semanage_free_root() { free(private_selinux_path);
>> private_selinux_path =3D NULL; +
>> free(private_semanage_conf_path); private_semanage_conf_path =3D
>> NULL; free(private_file_context_path); private_file_context_path =3D
>> NULL; free(private_file_context_local_path);
>> private_file_context_local_path =3D NULL;
>> free(private_file_context_homedir_path);
>> private_file_context_homedir_path =3D NULL; @@ -68,6 +70,10 @@ int
>> semanage_set_root(const char *path) { goto error; }
>>
>> + =A0 =A0 =A0 if ( asprintf(&private_semanage_conf_path, "%s/%s", path,
>> semanage_conf_path()) < 0 ) { + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error; =
+
>> } + if ( asprintf(&private_file_context_path, "%s/%s", path,
>> selinux_file_context_path()) < 0 ) { goto error; } @@ -171,6
>> +177,13 @@ const char *semanage_selinux_path(void) { return
>> selinux_path(); }
>>
>> +const char *semanage_semanage_conf_path(void) { + =A0 =A0 =A0 if
>> (private_semanage_conf_path + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &&
>> access(private_semanage_conf_path, R_OK) =3D=3D 0) +
>> return private_semanage_conf_path; + =A0 =A0 =A0 return
>> semanage_conf_path(); +} + semanage_handle_t
>> *semanage_handle_create(void) { semanage_handle_t *sh =3D NULL; @@
>> -180,7 +193,7 @@ semanage_handle_t *semanage_handle_create(void) if
>> ((sh =3D calloc(1, sizeof(semanage_handle_t))) =3D=3D NULL) goto err;
>>
>> - =A0 =A0 =A0 if ((conf_name =3D semanage_conf_path()) =3D=3D NULL) + =
=A0 =A0 =A0 if
>> ((conf_name =3D semanage_semanage_conf_path()) =3D=3D NULL) goto err;
>>
>> if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NULL)
>
>
> How about this patch instead.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk8Ec5EACgkQrlYvE4MpobMGUgCfS4IXRl6CslxjlmM1HHpTlwbl
> lMwAoNQBVA6F9mv7spdOE64IsxAx67dx
> =3DBWGP
> -----END PGP SIGNATURE-----

--0016e6d7ea90888c3e04b5bf3e61
Content-Type: text/x-patch; charset=US-ASCII; name="libsemanage_conf_path_for_cross.patch"
Content-Disposition: attachment;
	filename="libsemanage_conf_path_for_cross.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gx171c6w1

RnJvbSA5NTVmNTdiOTc4Nzg0NWNhNjE4NmM0NmUyNmRiM2UyMjg4ZjFlMDQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaW4gT3V5YW5nIDx4aW5wYXNjYWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDUgSmFuIDIwMTIgMTE6MDE6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBsaWJzZW1h
bmFnZTogc2VtYW5hZ2UuY29uZiB3aXRoIHNlbWFuYWdlX3NldF9yb290LgoKQWxsb3cgYXBwbGlj
YXRpb25zIHRvIHVzZSBzZW1hbmFnZS5jb25mIGluIHRoZSBhbHRlcm5hdGUgcm9vdCwgaWYKc2Vt
YW5hZ2Vfc2V0X3Jvb3QgY2FsbGVkLgotLS0KIGxpYnNlbWFuYWdlL3NyYy9oYW5kbGUuYyAgICAg
ICAgIHwgICAyMiArKysrKysrKysrKysrKysrKysrKysrCiBsaWJzZW1hbmFnZS9zcmMvaGFuZGxl
LmggICAgICAgICB8ICAgIDIgKysKIGxpYnNlbWFuYWdlL3NyYy9zZW1hbmFnZV9zdG9yZS5jIHwg
ICAxMiAtLS0tLS0tLS0tLS0KIGxpYnNlbWFuYWdlL3NyYy9zZW1hbmFnZV9zdG9yZS5oIHwgICAg
MSAtCiA0IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2xpYnNlbWFuYWdlL3NyYy9oYW5kbGUuYyBiL2xpYnNlbWFuYWdlL3NyYy9o
YW5kbGUuYwppbmRleCA3YWRjMWNjLi43NWRlNmRiIDEwMDY0NAotLS0gYS9saWJzZW1hbmFnZS9z
cmMvaGFuZGxlLmMKKysrIGIvbGlic2VtYW5hZ2Uvc3JjL2hhbmRsZS5jCkBAIC0zNywxMCArMzcs
MTIgQEAKICNpbmNsdWRlICJzZW1hbmFnZV9zdG9yZS5oIgogCiAjZGVmaW5lIFNFTUFOQUdFX0NP
TU1JVF9SRUFEX1dBSVQgNQorI2RlZmluZSBTRU1BTkFHRV9DT05GX1BBVEggIi9ldGMvc2VsaW51
eC9zZW1hbmFnZS5jb25mIgogCiAjaW5jbHVkZSA8c3RyaW5nLmg+CiAjaW5jbHVkZSA8c2VsaW51
eC9zZWxpbnV4Lmg+CiBzdGF0aWMgY2hhciAqcHJpdmF0ZV9zZWxpbnV4X3BhdGggPSBOVUxMOwor
c3RhdGljIGNoYXIgKnByaXZhdGVfc2VtYW5hZ2VfY29uZl9wYXRoID0gTlVMTDsKIHN0YXRpYyBj
aGFyICpwcml2YXRlX2ZpbGVfY29udGV4dF9wYXRoID0gTlVMTDsKIHN0YXRpYyBjaGFyICpwcml2
YXRlX2ZpbGVfY29udGV4dF9sb2NhbF9wYXRoID0gTlVMTDsKIHN0YXRpYyBjaGFyICpwcml2YXRl
X2ZpbGVfY29udGV4dF9ob21lZGlyX3BhdGggPSBOVUxMOwpAQCAtNTIsNiArNTQsNyBAQCBzdGF0
aWMgY2hhciAqcHJpdmF0ZV9wb2xpY3lfcm9vdCA9IE5VTEw7CiAKIHZvaWQgc2VtYW5hZ2VfZnJl
ZV9yb290KCkgewogCWZyZWUocHJpdmF0ZV9zZWxpbnV4X3BhdGgpOyBwcml2YXRlX3NlbGludXhf
cGF0aCA9IE5VTEw7CisJZnJlZShwcml2YXRlX3NlbWFuYWdlX2NvbmZfcGF0aCk7IHByaXZhdGVf
c2VtYW5hZ2VfY29uZl9wYXRoID0gTlVMTDsKIAlmcmVlKHByaXZhdGVfZmlsZV9jb250ZXh0X3Bh
dGgpOyBwcml2YXRlX2ZpbGVfY29udGV4dF9wYXRoID0gTlVMTDsKIAlmcmVlKHByaXZhdGVfZmls
ZV9jb250ZXh0X2xvY2FsX3BhdGgpOyBwcml2YXRlX2ZpbGVfY29udGV4dF9sb2NhbF9wYXRoID0g
TlVMTDsKIAlmcmVlKHByaXZhdGVfZmlsZV9jb250ZXh0X2hvbWVkaXJfcGF0aCk7IHByaXZhdGVf
ZmlsZV9jb250ZXh0X2hvbWVkaXJfcGF0aCA9IE5VTEw7CkBAIC02OCw2ICs3MSwxMCBAQCBpbnQg
c2VtYW5hZ2Vfc2V0X3Jvb3QoY29uc3QgY2hhciAqcGF0aCkgewogCQlnb3RvIGVycm9yOwogCX0K
IAorCWlmICggYXNwcmludGYoJnByaXZhdGVfc2VtYW5hZ2VfY29uZl9wYXRoLCAiJXMvJXMiLCBw
YXRoLCBTRU1BTkFHRV9DT05GX1BBVEgpIDwgMCApIHsKKwkJZ290byBlcnJvcjsKKwl9CisKIAlp
ZiAoIGFzcHJpbnRmKCZwcml2YXRlX2ZpbGVfY29udGV4dF9wYXRoLCAiJXMvJXMiLCBwYXRoLCBz
ZWxpbnV4X2ZpbGVfY29udGV4dF9wYXRoKCkpIDwgMCApIHsKIAkJZ290byBlcnJvcjsKIAl9CkBA
IC0xNzEsNiArMTc4LDIxIEBAIGNvbnN0IGNoYXIgKnNlbWFuYWdlX3NlbGludXhfcGF0aCh2b2lk
KSB7CiAJcmV0dXJuIHNlbGludXhfcGF0aCgpOwogfQogCisvKiBSZXR1cm4gYSBmdWxseS1xdWFs
aWZpZWQgcGF0aCArIGZpbGVuYW1lIHRvIHRoZSBzZW1hbmFnZQorICogY29uZmlndXJhdGlvbiBm
aWxlLiAgVGhlIGNhbGxlciBtdXN0IG5vdCBhbHRlciB0aGUgc3RyaW5nIHJldHVybmVkCisgKiAo
YW5kIGhlbmNlIHdoeSB0aGlzIGZ1bmN0aW9uIHJldHVybiB0eXBlIGlzIGNvbnN0KS4KKyAqCisg
Ki8KKworY29uc3QgY2hhciAqc2VtYW5hZ2VfY29uZl9wYXRoKHZvaWQpCit7CisJaWYgKHByaXZh
dGVfc2VtYW5hZ2VfY29uZl9wYXRoCisJCSYmIGFjY2Vzcyhwcml2YXRlX3NlbWFuYWdlX2NvbmZf
cGF0aCwgUl9PSykgPT0gMCkKKwkJcmV0dXJuIHByaXZhdGVfc2VtYW5hZ2VfY29uZl9wYXRoOwor
CisJcmV0dXJuIFNFTUFOQUdFX0NPTkZfUEFUSDsKK30KKwogc2VtYW5hZ2VfaGFuZGxlX3QgKnNl
bWFuYWdlX2hhbmRsZV9jcmVhdGUodm9pZCkKIHsKIAlzZW1hbmFnZV9oYW5kbGVfdCAqc2ggPSBO
VUxMOwpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL2hhbmRsZS5oIGIvbGlic2VtYW5hZ2Uv
c3JjL2hhbmRsZS5oCmluZGV4IDcyM2Q4MTEuLmJiMTI1OTQgMTAwNjQ0Ci0tLSBhL2xpYnNlbWFu
YWdlL3NyYy9oYW5kbGUuaAorKysgYi9saWJzZW1hbmFnZS9zcmMvaGFuZGxlLmgKQEAgLTEwNSw2
ICsxMDUsOCBAQCBzdHJ1Y3Qgc2VtYW5hZ2VfaGFuZGxlIHsKIAlkYmFzZV9jb25maWdfdCBkYmFz
ZVtEQkFTRV9DT1VOVF07CiB9OwogCitjb25zdCBjaGFyICpzZW1hbmFnZV9jb25mX3BhdGgodm9p
ZCk7CisKIC8qID09PSBMb2NhbCBtb2RpZmljYXRpb25zID09PSAqLwogc3RhdGljIGlubGluZQog
ICAgIGRiYXNlX2NvbmZpZ190ICogc2VtYW5hZ2VfdXNlcl9iYXNlX2RiYXNlX2xvY2FsKHNlbWFu
YWdlX2hhbmRsZV90ICogaGFuZGxlKQpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL3NlbWFu
YWdlX3N0b3JlLmMgYi9saWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYwppbmRleCBhMjIz
YWE3Li4wZTdiNzFhIDEwMDY0NAotLS0gYS9saWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUu
YworKysgYi9saWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYwpAQCAtMjYyLDE4ICsyNjIs
NiBAQCBjb25zdCBjaGFyICpzZW1hbmFnZV9wYXRoKGVudW0gc2VtYW5hZ2Vfc3RvcmVfZGVmcyBz
dG9yZSwKIAlyZXR1cm4gc2VtYW5hZ2VfcGF0aHNbc3RvcmVdW3BhdGhfbmFtZV07CiB9CiAKLS8q
IFJldHVybiBhIGZ1bGx5LXF1YWxpZmllZCBwYXRoICsgZmlsZW5hbWUgdG8gdGhlIHNlbWFuYWdl
Ci0gKiBjb25maWd1cmF0aW9uIGZpbGUuICBUaGUgY2FsbGVyIG11c3Qgbm90IGFsdGVyIHRoZSBz
dHJpbmcgcmV0dXJuZWQKLSAqIChhbmQgaGVuY2Ugd2h5IHRoaXMgZnVuY3Rpb24gcmV0dXJuIHR5
cGUgaXMgY29uc3QpLgotICoKLSAqIFRoaXMgaXMgZ29pbmcgdG8gYmUgaGFyZCBjb2RlZCB0byAv
ZXRjL3NlbGludXgvc2VtYW5hZ2UuY29uZiBmb3IKLSAqIHRoZSB0aW1lIGJlaW5nLiBGSVhNRQot
ICovCi1jb25zdCBjaGFyICpzZW1hbmFnZV9jb25mX3BhdGgodm9pZCkKLXsKLQlyZXR1cm4gIi9l
dGMvc2VsaW51eC9zZW1hbmFnZS5jb25mIjsKLX0KLQogLyoqKioqKioqKioqKioqKiogZnVuY3Rp
b25zIHRoYXQgY3JlYXRlIG1vZHVsZSBzdG9yZSAqKioqKioqKioqKioqKiovCiAKIC8qIENoZWNr
IHRoYXQgdGhlIHNlbWFuYWdlIHN0b3JlIGV4aXN0cy4gIElmICdjcmVhdGUnIGlzIG5vbi16ZXJv
IHRoZW4KZGlmZiAtLWdpdCBhL2xpYnNlbWFuYWdlL3NyYy9zZW1hbmFnZV9zdG9yZS5oIGIvbGli
c2VtYW5hZ2Uvc3JjL3NlbWFuYWdlX3N0b3JlLmgKaW5kZXggYjQ1MTMwOC4uOThlMDExZCAxMDA2
NDQKLS0tIGEvbGlic2VtYW5hZ2Uvc3JjL3NlbWFuYWdlX3N0b3JlLmgKKysrIGIvbGlic2VtYW5h
Z2Uvc3JjL3NlbWFuYWdlX3N0b3JlLmgKQEAgLTY2LDcgKzY2LDYgQEAgZW51bSBzZW1hbmFnZV9z
YW5kYm94X2RlZnMgewogLyogRklYTUU6IHRoaXMgbmVlZHMgdG8gYmUgbWFkZSBhIG1vZHVsZSBz
dG9yZSBzcGVjaWZpYyBpbml0IGFuZCB0aGUKICAqIGdsb2JhbCBjb25maWd1cmF0aW9uIG1vdmVk
IHRvIGFub3RoZXIgZmlsZS4KICAqLwotY29uc3QgY2hhciAqc2VtYW5hZ2VfY29uZl9wYXRoKHZv
aWQpOwogaW50IHNlbWFuYWdlX2NoZWNrX2luaXQoY29uc3QgY2hhciAqcm9vdCk7CiAKIGV4dGVy
biBjb25zdCBjaGFyICpzZW1hbmFnZV9mbmFtZShlbnVtIHNlbWFuYWdlX3NhbmRib3hfZGVmcyBm
aWxlX2VudW0pOwotLSAKMS43LjUuNAoK
--0016e6d7ea90888c3e04b5bf3e61--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
