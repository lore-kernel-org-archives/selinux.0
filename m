Date: Mon, 17 Feb 2003 14:38:14 +0100 (MET)
From: Carsten Lehr <carstengrohmann@gmx.de>
To: <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary311981045489094"
Subject: patch libsecure and tar
Message-ID: <31198.1045489094@www1.gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary311981045489094
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,     
     
the attached patches corrects a little mistake in
tar-1.13.25/src/Makefile.am and  
tar-1.13.25-2003011510.patch. The subdirectory lib/ is missing in the path
to libsecure.a. 
 
greetings 
 
Carsten 

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!
--========GMXBoundary311981045489094
Content-Type: text/x-diff; name="tar_makefile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tar_makefile.diff"

ZGlmZiAtdSAtciB0YXItMS4xMy4yNS1vcmlnL3NyYy9NYWtlZmlsZS5hbSB0YXItMS4xMy4yNS9z
cmMvTWFrZWZpbGUuYW0KLS0tIHRhci0xLjEzLjI1LW9yaWcvc3JjL01ha2VmaWxlLmFtCTIwMDIt
MTAtMDMgMjE6MTA6MDEuMDAwMDAwMDAwICswMjAwCisrKyB0YXItMS4xMy4yNS9zcmMvTWFrZWZp
bGUuYW0JMjAwMy0wMi0xNyAxNDoyNzowOC4wMDAwMDAwMDAgKzAxMDAKQEAgLTM5LDYgKzM5LDYg
QEAKICMgTGluayBsaWJ0YXIuYSBhZnRlciBASU5UTExJQlNALCBzaW5jZSBASU5UTExJQlNAIG1p
Z2h0IGludm9rZSBycGxfcmVhbGxvYy4KICMgQWxzbywgbGluayBpdCBiZWZvcmUgQElOVFRMSUJT
QCwgc2luY2UgdW5pY29kZWlvLmMgbWlnaHQgaW52b2tlCiAjIGxvY2FsZV9jaGFyc2V0LiAgU2ln
aC4KLUxEQUREID0gLi4vbGliL2xpYnRhci5hIEBJTlRMTElCU0AgLi4vbGliL2xpYnRhci5hIC91
c3IvbG9jYWwvc2VsaW51eC9saWJzZWN1cmUuYQorTERBREQgPSAuLi9saWIvbGlidGFyLmEgQElO
VExMSUJTQCAuLi9saWIvbGlidGFyLmEgL3Vzci9sb2NhbC9zZWxpbnV4L2xpYi9saWJzZWN1cmUu
YQogcm10X0xEQUREID0gJChMREFERCkgQHJtdF9MREFEREAKIHRhcl9MREFERCA9ICQoTERBREQp
IEB0YXJfTERBRERACg==

--========GMXBoundary311981045489094
Content-Type: text/x-diff; name="tar_patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tar_patch.diff"

LS0tIHRhci0xLjEzLjI1LTIwMDMwMTE1MTAucGF0Y2gub3JpZwkyMDAzLTAxLTE1IDE3OjIyOjM0
LjAwMDAwMDAwMCArMDEwMAorKysgdGFyLTEuMTMuMjUtMjAwMzAxMTUxMC5wYXRjaAkyMDAzLTAy
LTE3IDE0OjI5OjI4LjAwMDAwMDAwMCArMDEwMApAQCAtNDQsNyArNDQsNyBAQAogICMgQWxzbywg
bGluayBpdCBiZWZvcmUgQElOVFRMSUJTQCwgc2luY2UgdW5pY29kZWlvLmMgbWlnaHQgaW52b2tl
CiAgIyBsb2NhbGVfY2hhcnNldC4gIFNpZ2guCiAtTERBREQgPSAuLi9saWIvbGlidGFyLmEgQElO
VExMSUJTQCAuLi9saWIvbGlidGFyLmEKLStMREFERCA9IC4uL2xpYi9saWJ0YXIuYSBASU5UTExJ
QlNAIC4uL2xpYi9saWJ0YXIuYSAvdXNyL2xvY2FsL3NlbGludXgvbGlic2VjdXJlLmEKKytMREFE
RCA9IC4uL2xpYi9saWJ0YXIuYSBASU5UTExJQlNAIC4uL2xpYi9saWJ0YXIuYSAvdXNyL2xvY2Fs
L3NlbGludXgvbGliL2xpYnNlY3VyZS5hCiAgcm10X0xEQUREID0gJChMREFERCkgQHJtdF9MREFE
REAKICB0YXJfTERBREQgPSAkKExEQUREKSBAdGFyX0xEQUREQAogSW5kZXg6IHNlbGludXgvdXRp
bHMvdGFyLTEuMTMuMjUvc3JjL01ha2VmaWxlLmluCg==

--========GMXBoundary311981045489094--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
