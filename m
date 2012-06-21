MIME-Version: 1.0
Date: Thu, 21 Jun 2012 14:19:26 -0700
Message-ID: <CAFftDdognt2TCbSjuc2PNmjzhYH4wGYWO+DjaWCcSOCc3Ast8g@mail.gmail.com>
Subject: [PATCH] SE Android local manifest patch dalvik and lobcore
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: seandroid@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=e89a8ff244cf04a41104c302127b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff244cf04a41104c302127b
Content-Type: multipart/alternative; boundary=e89a8ff244cf04a40c04c3021279

--e89a8ff244cf04a40c04c3021279
Content-Type: text/plain; charset=ISO-8859-1

If your getting errors on sync that are about dalvik and libcore not being
found, this patch may help.

AOSP updated their references for dalvik and libcore to snapshots and named
them dalvik2 and libcore2.

remove project was failing in local_manifest for master. Not sure about
other branches.

This patch resolves this, not sure if this is the best approach, but this
patch will help in the interim.

make sure you get your local_manifest's from git:
git clone git://git.selinuxproject.org/~seandroid/manifests

-- 
Respectfully,

William C Roberts

--e89a8ff244cf04a40c04c3021279
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>If your getting errors on sync that are about dalvik and libcore not b=
eing found, this patch may help.</div><div><br></div>AOSP updated their ref=
erences for dalvik and libcore to snapshots and named them dalvik2 and libc=
ore2.<div>
<br></div><div>remove project was failing in local_manifest for master. Not=
 sure about other branches.<br clear=3D"all"><div><br></div><div>This patch=
 resolves this, not sure if this is the best approach, but this patch will =
help in the interim.=A0</div>
<div><br></div><div>make sure you get your local_manifest&#39;s from git:</=
div><div><div>git clone git://<a href=3D"http://git.selinuxproject.org/~sea=
ndroid/manifests">git.selinuxproject.org/~seandroid/manifests</a></div></di=
v>
<div><br></div><div>--=A0</div>Respectfully,<br><br>William C Roberts<br><b=
r><br>
</div>

--e89a8ff244cf04a40c04c3021279--

--e89a8ff244cf04a41104c302127b
Content-Type: application/octet-stream; name="manifest.patch"
Content-Disposition: attachment; filename="manifest.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3qc0u0g0

ZGlmZiAtLWdpdCBhL2xvY2FsX21hbmlmZXN0LnhtbCBiL2xvY2FsX21hbmlmZXN0LnhtbAppbmRl
eCA5ODRjZTIyLi42MDQxY2Q0IDEwMDY0NAotLS0gYS9sb2NhbF9tYW5pZmVzdC54bWwKKysrIGIv
bG9jYWxfbWFuaWZlc3QueG1sCkBAIC0yMiwxMCArMjIsMTAgQEAKICAgICA8Y29weWZpbGUgc3Jj
PSJjb3JlL3Jvb3QubWsiIGRlc3Q9Ik1ha2VmaWxlIiAvPgogICA8L3Byb2plY3Q+CiAKLSAgPHJl
bW92ZS1wcm9qZWN0IG5hbWU9InBsYXRmb3JtL2RhbHZpayIvPgorICA8cmVtb3ZlLXByb2plY3Qg
bmFtZT0icGxhdGZvcm0vZGFsdmlrMiIvPgogICA8cHJvamVjdCBwYXRoPSJkYWx2aWsiIHJlbW90
ZT0ic2VsaW51eHByb2plY3QiIG5hbWU9InBsYXRmb3JtL2RhbHZpayIgcmV2aXNpb249InNlYW5k
cm9pZCIgLz4KIAotICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vbGliY29yZSIvPgor
ICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vbGliY29yZTIiLz4KICAgPHByb2plY3Qg
cGF0aD0ibGliY29yZSIgcmVtb3RlPSJzZWxpbnV4cHJvamVjdCIgbmFtZT0icGxhdGZvcm0vbGli
Y29yZSIgcmV2aXNpb249InNlYW5kcm9pZCIgLz4KIAogICA8cmVtb3ZlLXByb2plY3QgbmFtZT0i
cGxhdGZvcm0vZnJhbWV3b3Jrcy9iYXNlIi8+CmRpZmYgLS1naXQgYS9sb2NhbF9tYW5pZmVzdF9o
dHRwLnhtbCBiL2xvY2FsX21hbmlmZXN0X2h0dHAueG1sCmluZGV4IDE2M2ZjYWQuLmFlNjYzN2Mg
MTAwNjQ0Ci0tLSBhL2xvY2FsX21hbmlmZXN0X2h0dHAueG1sCisrKyBiL2xvY2FsX21hbmlmZXN0
X2h0dHAueG1sCkBAIC0yMiwxMCArMjIsMTAgQEAKICAgICA8Y29weWZpbGUgc3JjPSJjb3JlL3Jv
b3QubWsiIGRlc3Q9Ik1ha2VmaWxlIiAvPgogICA8L3Byb2plY3Q+CiAKLSAgPHJlbW92ZS1wcm9q
ZWN0IG5hbWU9InBsYXRmb3JtL2RhbHZpayIvPgorICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxh
dGZvcm0vZGFsdmlrMiIvPgogICA8cHJvamVjdCBwYXRoPSJkYWx2aWsiIHJlbW90ZT0ic2VsaW51
eHByb2plY3QiIG5hbWU9InBsYXRmb3JtL2RhbHZpayIgcmV2aXNpb249InNlYW5kcm9pZCIgLz4K
IAotICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vbGliY29yZSIvPgorICA8cmVtb3Zl
LXByb2plY3QgbmFtZT0icGxhdGZvcm0vbGliY29yZTIiLz4KICAgPHByb2plY3QgcGF0aD0ibGli
Y29yZSIgcmVtb3RlPSJzZWxpbnV4cHJvamVjdCIgbmFtZT0icGxhdGZvcm0vbGliY29yZSIgcmV2
aXNpb249InNlYW5kcm9pZCIgLz4KIAogICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0v
ZnJhbWV3b3Jrcy9iYXNlIi8+CmRpZmYgLS1naXQgYS9sb2NhbF9tYW5pZmVzdF9tbWFjLnhtbCBi
L2xvY2FsX21hbmlmZXN0X21tYWMueG1sCmluZGV4IDJhODE1NGUuLjkxNjhkODkgMTAwNjQ0Ci0t
LSBhL2xvY2FsX21hbmlmZXN0X21tYWMueG1sCisrKyBiL2xvY2FsX21hbmlmZXN0X21tYWMueG1s
CkBAIC0yMywxMCArMjMsMTAgQEAKICAgICA8Y29weWZpbGUgc3JjPSJjb3JlL3Jvb3QubWsiIGRl
c3Q9Ik1ha2VmaWxlIiAvPgogICA8L3Byb2plY3Q+CiAKLSAgPHJlbW92ZS1wcm9qZWN0IG5hbWU9
InBsYXRmb3JtL2RhbHZpayIvPgorICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vZGFs
dmlrMiIvPgogICA8cHJvamVjdCBwYXRoPSJkYWx2aWsiIHJlbW90ZT0ic2VsaW51eHByb2plY3Qi
IG5hbWU9InBsYXRmb3JtL2RhbHZpayIgcmV2aXNpb249InNlYW5kcm9pZCIgLz4KIAotICA8cmVt
b3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vbGliY29yZSIvPgorICA8cmVtb3ZlLXByb2plY3Qg
bmFtZT0icGxhdGZvcm0vbGliY29yZTIiLz4KICAgPHByb2plY3QgcGF0aD0ibGliY29yZSIgcmVt
b3RlPSJzZWxpbnV4cHJvamVjdCIgbmFtZT0icGxhdGZvcm0vbGliY29yZSIgcmV2aXNpb249InNl
YW5kcm9pZCIgLz4KIAogICA8cmVtb3ZlLXByb2plY3QgbmFtZT0icGxhdGZvcm0vZnJhbWV3b3Jr
cy9iYXNlIi8+Cg==
--e89a8ff244cf04a41104c302127b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
