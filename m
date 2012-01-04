Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q048va5s014850
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2012 03:57:36 -0500
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q048vZCs026577
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2012 08:57:35 GMT
Received: by wgbdt11 with SMTP id dt11so22220837wgb.30
        for <selinux@tycho.nsa.gov>; Wed, 04 Jan 2012 00:57:34 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Jan 2012 16:57:34 +0800
Message-ID: <CANvtKVYZsPZwzmXjwTv672Usd7zQKiY_dfvht7mp3Rkcn7Gi2g@mail.gmail.com>
Subject: Use specified semanage.conf for cross compiling
From: Xin Ouyang <xinpascal@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=000e0cd5b81cbc405504b5b001e0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd5b81cbc405504b5b001e0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

For some cross compiling cases, I need to use semodule to create the
policy store at build time.
It is,
=A0 =A0 =A0 =A0semodule -n -b base.pp -i some.pp .. -p $TARGET_ROOT

With this, semodule will use /etc/selinux/semanage.conf by calling
semanage_handle_create():

// libsemanage/src/handle.c
semanage_handle_t *semanage_handle_create(void)
{
=A0 =A0 =A0 =A0 semanage_handle_t *sh =3D NULL;
=A0 =A0 =A0 =A0 const char *conf_name =3D NULL;

=A0 =A0 =A0 =A0 /* Allocate handle */
=A0 =A0 =A0 =A0 if ((sh =3D calloc(1, sizeof(semanage_handle_t))) =3D=3D NU=
LL)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

=A0 =A0 =A0 =A0 if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

=A0 =A0 =A0 =A0 if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NU=
LL)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

While there may be some different options in =A0semanage.conf for the
target, I am trying to specify a special semanage.conf path instead of
/etc/selinux/semanage.conf in the build host.

Commit=A09cd587f5533456e7b26601e27e65744272e2e783=A0introduced
semanage_set_root() as=A0an alternate root for policy stores. So I make
a patch to use the semanage.conf in the=A0alternate root.
After the patch, semodule -p /target will use
/target/etc/selinux/semanage.conf as the config file.

Anyone who has better solutions, please


diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 7adc1cc..ef36152 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -41,6 +41,7 @@
=A0#include <string.h>
=A0#include <selinux/selinux.h>
=A0static char *private_selinux_path =3D NULL;
+static char *private_semanage_conf_path =3D NULL;
=A0static char *private_file_context_path =3D NULL;
=A0static char *private_file_context_local_path =3D NULL;
=A0static char *private_file_context_homedir_path =3D NULL;
@@ -52,6 +53,7 @@ static char *private_policy_root =3D NULL;

=A0void semanage_free_root() {
=A0 =A0 =A0 =A0 free(private_selinux_path); private_selinux_path =3D NULL;
+ =A0 =A0 =A0 free(private_semanage_conf_path); private_semanage_conf_path =
=3D NULL;
=A0 =A0 =A0 =A0 free(private_file_context_path); private_file_context_path =
=3D NULL;
=A0 =A0 =A0 =A0 free(private_file_context_local_path);
private_file_context_local_path =3D NULL;
=A0 =A0 =A0 =A0 free(private_file_context_homedir_path);
private_file_context_homedir_path =3D NULL;
@@ -68,6 +70,10 @@ int semanage_set_root(const char *path) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
=A0 =A0 =A0 =A0 }

+ =A0 =A0 =A0 if ( asprintf(&private_semanage_conf_path, "%s/%s", path,
semanage_conf_path()) < 0 ) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
+ =A0 =A0 =A0 }
+
=A0 =A0 =A0 =A0 if ( asprintf(&private_file_context_path, "%s/%s", path,
selinux_file_context_path()) < 0 ) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
=A0 =A0 =A0 =A0 }
@@ -171,6 +177,13 @@ const char *semanage_selinux_path(void) {
=A0 =A0 =A0 =A0 return selinux_path();
=A0}

+const char *semanage_semanage_conf_path(void) {
+ =A0 =A0 =A0 if (private_semanage_conf_path
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 && access(private_semanage_conf_path, R_OK) =
=3D=3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return private_semanage_conf_path;
+ =A0 =A0 =A0 return semanage_conf_path();
+}
+
=A0semanage_handle_t *semanage_handle_create(void)
=A0{
=A0 =A0 =A0 =A0 semanage_handle_t *sh =3D NULL;
@@ -180,7 +193,7 @@ semanage_handle_t *semanage_handle_create(void)
=A0 =A0 =A0 =A0 if ((sh =3D calloc(1, sizeof(semanage_handle_t))) =3D=3D NU=
LL)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

- =A0 =A0 =A0 if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
+ =A0 =A0 =A0 if ((conf_name =3D semanage_semanage_conf_path()) =3D=3D NULL=
)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

=A0 =A0 =A0 =A0 if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NU=
LL)

--000e0cd5b81cbc405504b5b001e0
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-libsemanage-semanage.conf-with-semanage_set_root.patch"
Content-Disposition: attachment;
	filename="0001-libsemanage-semanage.conf-with-semanage_set_root.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gx045ygh0

RnJvbSA4MTFlMTEzYzFlNmZkZGNjY2E3MjlmOGUxMzMzMjFjNDZkYjk1YzgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaW4gT3V5YW5nIDx4aW5wYXNjYWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDQgSmFuIDIwMTIgMTQ6Mzg6MzYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBsaWJzZW1h
bmFnZTogc2VtYW5hZ2UuY29uZiB3aXRoIHNlbWFuYWdlX3NldF9yb290LgoKQWxsb3cgYXBwbGlj
YXRpb25zIHRvIHVzZSBzZW1hbmFnZS5jb25mIGluIHRoZSBhbHRlcm5hdGUgcm9vdCwgaWYKc2Vt
YW5hZ2Vfc2V0X3Jvb3QgY2FsbGVkLgotLS0KIGxpYnNlbWFuYWdlL3NyYy9oYW5kbGUuYyB8ICAg
MTUgKysrKysrKysrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL2hhbmRsZS5jIGIvbGli
c2VtYW5hZ2Uvc3JjL2hhbmRsZS5jCmluZGV4IDdhZGMxY2MuLmVmMzYxNTIgMTAwNjQ0Ci0tLSBh
L2xpYnNlbWFuYWdlL3NyYy9oYW5kbGUuYworKysgYi9saWJzZW1hbmFnZS9zcmMvaGFuZGxlLmMK
QEAgLTQxLDYgKzQxLDcgQEAKICNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxzZWxpbnV4
L3NlbGludXguaD4KIHN0YXRpYyBjaGFyICpwcml2YXRlX3NlbGludXhfcGF0aCA9IE5VTEw7Citz
dGF0aWMgY2hhciAqcHJpdmF0ZV9zZW1hbmFnZV9jb25mX3BhdGggPSBOVUxMOwogc3RhdGljIGNo
YXIgKnByaXZhdGVfZmlsZV9jb250ZXh0X3BhdGggPSBOVUxMOwogc3RhdGljIGNoYXIgKnByaXZh
dGVfZmlsZV9jb250ZXh0X2xvY2FsX3BhdGggPSBOVUxMOwogc3RhdGljIGNoYXIgKnByaXZhdGVf
ZmlsZV9jb250ZXh0X2hvbWVkaXJfcGF0aCA9IE5VTEw7CkBAIC01Miw2ICs1Myw3IEBAIHN0YXRp
YyBjaGFyICpwcml2YXRlX3BvbGljeV9yb290ID0gTlVMTDsKIAogdm9pZCBzZW1hbmFnZV9mcmVl
X3Jvb3QoKSB7CiAJZnJlZShwcml2YXRlX3NlbGludXhfcGF0aCk7IHByaXZhdGVfc2VsaW51eF9w
YXRoID0gTlVMTDsKKwlmcmVlKHByaXZhdGVfc2VtYW5hZ2VfY29uZl9wYXRoKTsgcHJpdmF0ZV9z
ZW1hbmFnZV9jb25mX3BhdGggPSBOVUxMOwogCWZyZWUocHJpdmF0ZV9maWxlX2NvbnRleHRfcGF0
aCk7IHByaXZhdGVfZmlsZV9jb250ZXh0X3BhdGggPSBOVUxMOwogCWZyZWUocHJpdmF0ZV9maWxl
X2NvbnRleHRfbG9jYWxfcGF0aCk7IHByaXZhdGVfZmlsZV9jb250ZXh0X2xvY2FsX3BhdGggPSBO
VUxMOwogCWZyZWUocHJpdmF0ZV9maWxlX2NvbnRleHRfaG9tZWRpcl9wYXRoKTsgcHJpdmF0ZV9m
aWxlX2NvbnRleHRfaG9tZWRpcl9wYXRoID0gTlVMTDsKQEAgLTY4LDYgKzcwLDEwIEBAIGludCBz
ZW1hbmFnZV9zZXRfcm9vdChjb25zdCBjaGFyICpwYXRoKSB7CiAJCWdvdG8gZXJyb3I7CiAJfQog
CisJaWYgKCBhc3ByaW50ZigmcHJpdmF0ZV9zZW1hbmFnZV9jb25mX3BhdGgsICIlcy8lcyIsIHBh
dGgsIHNlbWFuYWdlX2NvbmZfcGF0aCgpKSA8IDAgKSB7CisJCWdvdG8gZXJyb3I7CisJfQorCiAJ
aWYgKCBhc3ByaW50ZigmcHJpdmF0ZV9maWxlX2NvbnRleHRfcGF0aCwgIiVzLyVzIiwgcGF0aCwg
c2VsaW51eF9maWxlX2NvbnRleHRfcGF0aCgpKSA8IDAgKSB7CiAJCWdvdG8gZXJyb3I7CiAJfQpA
QCAtMTcxLDYgKzE3NywxMyBAQCBjb25zdCBjaGFyICpzZW1hbmFnZV9zZWxpbnV4X3BhdGgodm9p
ZCkgewogCXJldHVybiBzZWxpbnV4X3BhdGgoKTsKIH0KIAorY29uc3QgY2hhciAqc2VtYW5hZ2Vf
c2VtYW5hZ2VfY29uZl9wYXRoKHZvaWQpIHsKKwlpZiAocHJpdmF0ZV9zZW1hbmFnZV9jb25mX3Bh
dGgKKwkJJiYgYWNjZXNzKHByaXZhdGVfc2VtYW5hZ2VfY29uZl9wYXRoLCBSX09LKSA9PSAwKQor
CQlyZXR1cm4gcHJpdmF0ZV9zZW1hbmFnZV9jb25mX3BhdGg7CisJcmV0dXJuIHNlbWFuYWdlX2Nv
bmZfcGF0aCgpOworfQorCiBzZW1hbmFnZV9oYW5kbGVfdCAqc2VtYW5hZ2VfaGFuZGxlX2NyZWF0
ZSh2b2lkKQogewogCXNlbWFuYWdlX2hhbmRsZV90ICpzaCA9IE5VTEw7CkBAIC0xODAsNyArMTkz
LDcgQEAgc2VtYW5hZ2VfaGFuZGxlX3QgKnNlbWFuYWdlX2hhbmRsZV9jcmVhdGUodm9pZCkKIAlp
ZiAoKHNoID0gY2FsbG9jKDEsIHNpemVvZihzZW1hbmFnZV9oYW5kbGVfdCkpKSA9PSBOVUxMKQog
CQlnb3RvIGVycjsKIAotCWlmICgoY29uZl9uYW1lID0gc2VtYW5hZ2VfY29uZl9wYXRoKCkpID09
IE5VTEwpCisJaWYgKChjb25mX25hbWUgPSBzZW1hbmFnZV9zZW1hbmFnZV9jb25mX3BhdGgoKSkg
PT0gTlVMTCkKIAkJZ290byBlcnI7CiAKIAlpZiAoKHNoLT5jb25mID0gc2VtYW5hZ2VfY29uZl9w
YXJzZShjb25mX25hbWUpKSA9PSBOVUxMKQotLSAKMS43LjUuNAoK
--000e0cd5b81cbc405504b5b001e0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
