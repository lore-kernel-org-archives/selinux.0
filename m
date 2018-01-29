Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0THS8NT019363
 for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2018 12:28:08 -0500
Received: by mail-io0-f179.google.com with SMTP id p188so8420705ioe.12
 for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2018 09:27:51 -0800 (PST)
MIME-Version: 1.0
From: Ben Kane <bbk1524@gmail.com>
Date: Mon, 29 Jan 2018 11:27:50 -0600
Message-ID: <CAC7z9xBeQ7B5D-VG_RruwxAwWyChCghrvBuOaGc-YNsyrx4b_g@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="001a1140f952ce6d610563ed905f"
Subject: Update setenforce, getenforce,
 sestatus man pages with references to each other.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140f952ce6d610563ed905f
Content-Type: multipart/alternative; boundary="001a1140f952ce6d5d0563ed905d"

--001a1140f952ce6d5d0563ed905d
Content-Type: text/plain; charset="UTF-8"

Hello,

Last week I was studying for the RHCSE certification, and I couldn't find
how
to change SELinux's status from enforcing to permissive in the man pages.
This
patch updates the relevant man pages.

- Switching emails

I emailed Daniel Walsh, the man page author, and he connected me to Petr
Lautrbach, who sent me to this mailing list (via my work email). The
maintainer, Stephen Smalley, said I should remove my company's legal blurb
at
the end of the email, and the email folks at my work (Acxiom Corp), said it
would be better to use my personal email anyway.

- Patch format

I hope the patch is formatted correctly. I tried to follow the notes on the
wiki (
https://github.com/SELinuxProject/selinux/wiki/Contributing#contributing-code
)
and I used a StackOverflow link (
https://stackoverflow.com/a/3418499/2958070 )
to generate the patchfile.

Thanks,

Benjamin Kane

--001a1140f952ce6d5d0563ed905d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>Last week I was studying for the RHCSE certi=
fication, and I couldn&#39;t find how<br>to change SELinux&#39;s status fro=
m enforcing to permissive in the man pages. This<br>patch updates the relev=
ant man pages.<br><br>- Switching emails<br><br>I emailed Daniel Walsh, the=
 man page author, and he connected me to Petr<br>Lautrbach, who sent me to =
this mailing list (via my work email). The<br>maintainer, Stephen Smalley, =
said I should remove my company&#39;s legal blurb at<br>the end of the emai=
l, and the email folks at my work (Acxiom Corp), said it<br>would be better=
 to use my personal email anyway.<br><br>- Patch format<br><br>I hope the p=
atch is formatted correctly. I tried to follow the notes on the<br>wiki (<b=
r><a href=3D"https://github.com/SELinuxProject/selinux/wiki/Contributing#co=
ntributing-code">https://github.com/SELinuxProject/selinux/wiki/Contributin=
g#contributing-code</a> )<br>and I used a StackOverflow link ( <a href=3D"h=
ttps://stackoverflow.com/a/3418499/2958070">https://stackoverflow.com/a/341=
8499/2958070</a> )<br>to generate the patchfile.<br><br>Thanks,<br><br>Benj=
amin Kane<br><br><div></div><div><div>
</div></div></div>

--001a1140f952ce6d5d0563ed905d--

--001a1140f952ce6d610563ed905f
Content-Type: text/plain; charset="US-ASCII";
	name="add_setenforce_getenforce_sestatus_see_also_man.diff"
Content-Disposition: attachment;
	filename="add_setenforce_getenforce_sestatus_see_also_man.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd0h9it10

ZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvbWFuL21hbjgvZ2V0ZW5mb3JjZS44IGIvbGlic2VsaW51
eC9tYW4vbWFuOC9nZXRlbmZvcmNlLjgKaW5kZXggNzBiOTkyMS4uODNiZjEzMiAxMDA2NDQKLS0t
IGEvbGlic2VsaW51eC9tYW4vbWFuOC9nZXRlbmZvcmNlLjgKKysrIGIvbGlic2VsaW51eC9tYW4v
bWFuOC9nZXRlbmZvcmNlLjgKQEAgLTE1LDQgKzE1LDUgQEAgRGFuIFdhbHNoLCA8ZHdhbHNoQHJl
ZGhhdC5jb20+CiAuU0ggIlNFRSBBTFNPIgogLkJSIHNlbGludXggKDgpLAogLkJSIHNldGVuZm9y
Y2UgKDgpLAotLkJSIHNlbGludXhlbmFibGVkICg4KQorLkJSIHNlbGludXhlbmFibGVkICg4KSwK
Ky5CUiBzZXN0YXR1cyAoOCkKZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvbWFuL21hbjgvc2V0ZW5m
b3JjZS44IGIvbGlic2VsaW51eC9tYW4vbWFuOC9zZXRlbmZvcmNlLjgKaW5kZXggNzAyMDQxZC4u
YjZkMmMxMyAxMDA2NDQKLS0tIGEvbGlic2VsaW51eC9tYW4vbWFuOC9zZXRlbmZvcmNlLjgKKysr
IGIvbGlic2VsaW51eC9tYW4vbWFuOC9zZXRlbmZvcmNlLjgKQEAgLTI5LDMgKzI5LDQgQEAgRGFu
IFdhbHNoLCA8ZHdhbHNoQHJlZGhhdC5jb20+CiAuQlIgc2VsaW51eCAoOCksCiAuQlIgZ2V0ZW5m
b3JjZSAoOCksCiAuQlIgc2VsaW51eGVuYWJsZWQgKDgpCisuQlIgc2VzdGF0dXMgKDgpCmRpZmYg
LS1naXQgYS9wb2xpY3ljb3JldXRpbHMvc2VzdGF0dXMvc2VzdGF0dXMuOCBiL3BvbGljeWNvcmV1
dGlscy9zZXN0YXR1cy9zZXN0YXR1cy44CmluZGV4IGE4OWM1M2YuLmZlYTE2NjkgMTAwNjQ0Ci0t
LSBhL3BvbGljeWNvcmV1dGlscy9zZXN0YXR1cy9zZXN0YXR1cy44CisrKyBiL3BvbGljeWNvcmV1
dGlscy9zZXN0YXR1cy9zZXN0YXR1cy44CkBAIC03Myw3ICs3Myw5IEBAIERpc3BsYXkgdGhlIGN1
cnJlbnQgc3RhdGUgb2YgYm9vbGVhbnMuCiBUaGlzIG1hbiBwYWdlIHdhcyB3cml0dGVuIGJ5IERh
bmllbCBXYWxzaCA8ZHdhbHNoQHJlZGhhdC5jb20+LgogLmJyCiBUaGUgcHJvZ3JhbSB3YXMgd3Jp
dHRlbiBieSBDaHJpcyBQZUJlbml0byA8cGViZW5pdG9AZ2VudG9vLm9yZz4KLQorLgogLlNIICJT
RUUgQUxTTyIKLS5CUiBzZWxpbnV4ICIoOCksICIgc2VzdGF0dXMuY29uZiAiKDUpCi0KKy5CUiBz
ZWxpbnV4ICg4KSwKKy5CUiBzZXN0YXR1cy5jb25mICg1KSwKKy5CUiBzZXRlbmZvcmNlICg4KSwK
Ky5CUiBnZXRlbmZvcmNlICg4KQo=
--001a1140f952ce6d610563ed905f--
