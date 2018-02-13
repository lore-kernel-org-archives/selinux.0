Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1D1wnRt030072
 for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2018 20:58:49 -0500
Received: by mail-io0-f181.google.com with SMTP id z6so19549157iob.11
 for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2018 17:58:42 -0800 (PST)
MIME-Version: 1.0
From: Lee Stubbs <lee.stubbs@gmail.com>
Date: Mon, 12 Feb 2018 20:58:41 -0500
Message-ID: <CAHRXBzo6Oo1hxo-r5KORfGeUsHihQ3t4KURgScfJG2-24qhf8A@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="001a1140f0f88082c805650e5553"
Subject: Minor bash completion update for semanage ports
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140f0f88082c805650e5553
Content-Type: multipart/alternative; boundary="001a1140f0f88082c405650e5551"

--001a1140f0f88082c405650e5551
Content-Type: text/plain; charset="UTF-8"

Based on the semanage-port documentation, I believe the semanage ports type
bash autocompletion may be missing a '-'. Please see the attached patch
file for a possible update.

-Lee

--001a1140f0f88082c405650e5551
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Based on the semanage-port documentation, I believe t=
he semanage ports type bash autocompletion may be missing a &#39;-&#39;. Pl=
ease see the attached patch file for a possible update.=C2=A0</div><div><br=
></div><div>-Lee</div></div>

--001a1140f0f88082c405650e5551--

--001a1140f0f88082c805650e5553
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jdkzyvm10

RnJvbSAwNjQ0MDljMjE2YzhmNjRjMzBmNDBmNTA3Y2FjZjE1ZjE2NjcyZTUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWUgU3R1YmJzIDxsZWUuc3R1YmJzQGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAxMiBGZWIgMjAxOCAyMDo0OTowMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIE1pbm9y
IHVwZGF0ZSBmb3IgYmFzaCBjb21wbGV0aW9uLiBCYXNoIGNvbXBsZXRpb24gZm9yIHBvcnRzCiBp
cyBtaXNzaW5nICctJyBmb3IgdHlwZS4gQmFzZWQgb24gZG9jdW1lbnRhdGlvbiwgaXQgc2hvdWxk
IGJlIC0tdHlwZSwgbm90CiAtdHlwZS4KCi0tLQogcHl0aG9uL3NlbWFuYWdlL3NlbWFuYWdlLWJh
c2gtY29tcGxldGlvbi5zaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3B5dGhvbi9zZW1hbmFnZS9zZW1hbmFnZS1iYXNo
LWNvbXBsZXRpb24uc2ggYi9weXRob24vc2VtYW5hZ2Uvc2VtYW5hZ2UtYmFzaC1jb21wbGV0aW9u
LnNoCmluZGV4IDZiNTMyOTIuLjJkODExYzkgMTAwNjQ0Ci0tLSBhL3B5dGhvbi9zZW1hbmFnZS9z
ZW1hbmFnZS1iYXNoLWNvbXBsZXRpb24uc2gKKysrIGIvcHl0aG9uL3NlbWFuYWdlL3NlbWFuYWdl
LWJhc2gtY29tcGxldGlvbi5zaApAQCAtNTksNyArNTksNyBAQCBfX2dldF9leHBvcnRfb3B0cyAo
KSB7IGVjaG8gJyRBTExfT1BUUyAtLWYgLS1vdXRwdXRfZmlsZScgOyB9CiBfX2dldF9ib29sZWFu
X29wdHMgKCkgeyBlY2hvICckQUxMX09QVFMgLS1vbiAtb2ZmIC0xIC0wJyA7IH0KIF9fZ2V0X3Vz
ZXJfb3B0cyAoKSB7IGVjaG8gJyRBTExfT1BUUyAkTUFOQUdFRF9PUFRTIC1MIC0tbGV2ZWwgLXIg
LS1yYW5nZSAtUiAtLXJvbGUgJzsgfQogX19nZXRfbG9naW5fb3B0cyAoKSB7IGVjaG8gJyRBTExf
T1BUUyAkTUFOQUdFRF9PUFRTIC1zIC0tc2V1c2VyIC1yIC0tcmFuZ2UnOyB9Ci1fX2dldF9wb3J0
X29wdHMgKCkgeyBlY2hvICckQUxMX09QVFMgJE1BTkFHRURfT1BUUyAtdCAtdHlwZSAtciAtLXJh
bmdlIC1wIC0tcHJvdG8nOyB9CitfX2dldF9wb3J0X29wdHMgKCkgeyBlY2hvICckQUxMX09QVFMg
JE1BTkFHRURfT1BUUyAtdCAtLXR5cGUgLXIgLS1yYW5nZSAtcCAtLXByb3RvJzsgfQogX19nZXRf
aW50ZXJmYWNlX29wdHMgKCkgeyBlY2hvICckQUxMX09QVFMgJE1BTkFHRURfT1BUUyAtdCAtLXR5
cGUgJzsgfQogX19nZXRfbm9kZV9vcHRzICgpIHsgZWNobyAnJEFMTF9PUFRTICRNQU5BR0VEX09Q
VFMgLXQgLS10eXBlIC1NIC0tbWFzayAtcCAtLXByb3RvJzsgfQogX19nZXRfZmNvbnRleHRfb3B0
cyAoKSB7IGVjaG8gJyRBTExfT1BUUyAkTUFOQUdFRF9PUFRTIC10IC0tdHlwZSAtZSAtLWVxdWFs
IC1mIC0tZnR5cGUgJzsgfQotLSAKMi4yLjEKCg==
--001a1140f0f88082c805650e5553--
