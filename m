Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UJsPDo018161
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 14:54:25 -0500 (EST)
Received: from web51504.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2UJrDo4022579
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 19:53:13 GMT
Message-ID: <20050330195313.44516.qmail@web51504.mail.yahoo.com>
Date: Wed, 30 Mar 2005 11:53:13 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Getting the real task name in avc messages
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-779289395-1112212393=:43288"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-779289395-1112212393=:43288
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

Attached is a patch to the kernel that puts the program's name into the avc
message. This lets you know the script that caused the problem instead of
/bin/bash. Feedback would be appreciated.

-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-779289395-1112212393=:43288
Content-Type: application/octet-stream; name="linux-2.6.11-selinux-procname.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.6.11-selinux-procname.patch
Content-Disposition: attachment; filename="linux-2.6.11-selinux-procname.patch"

ZGlmZiAtdXIgbGludXgtMi42LjExLm9yaWcvaW5jbHVkZS9saW51eC9hdWRp
dC5oIGxpbnV4LTIuNi4xMS9pbmNsdWRlL2xpbnV4L2F1ZGl0LmgKLS0tIGxp
bnV4LTIuNi4xMS5vcmlnL2luY2x1ZGUvbGludXgvYXVkaXQuaAkyMDA1LTAz
LTA3IDEzOjQ1OjMzLjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgtMi42LjEx
L2luY2x1ZGUvbGludXgvYXVkaXQuaAkyMDA1LTAzLTA4IDE3OjI2OjQ3LjAw
MDAwMDAwMCAtMDUwMApAQCAtMTg0LDYgKzE4NCw3IEBACiAJCQkJCSAgICAg
Y29uc3QgY2hhciAqcHJlZml4LAogCQkJCQkgICAgIHN0cnVjdCBkZW50cnkg
KmRlbnRyeSwKIAkJCQkJICAgICBzdHJ1Y3QgdmZzbW91bnQgKnZmc21udCk7
CitleHRlcm4gdm9pZAkJICAgIGF1ZGl0X2xvZ190YXNrX2luZm8oc3RydWN0
IGF1ZGl0X2J1ZmZlciAqYWIpOwogZXh0ZXJuIGludAkJICAgIGF1ZGl0X3Nl
dF9yYXRlX2xpbWl0KGludCBsaW1pdCwgdWlkX3QgbG9naW51aWQpOwogZXh0
ZXJuIGludAkJICAgIGF1ZGl0X3NldF9iYWNrbG9nX2xpbWl0KGludCBsaW1p
dCwgdWlkX3QgbG9naW51aWQpOwogZXh0ZXJuIGludAkJICAgIGF1ZGl0X3Nl
dF9lbmFibGVkKGludCBzdGF0ZSwgdWlkX3QgbG9naW51aWQpOwpkaWZmIC11
ciBsaW51eC0yLjYuMTEub3JpZy9rZXJuZWwvYXVkaXRzYy5jIGxpbnV4LTIu
Ni4xMS9rZXJuZWwvYXVkaXRzYy5jCi0tLSBsaW51eC0yLjYuMTEub3JpZy9r
ZXJuZWwvYXVkaXRzYy5jCTIwMDUtMDMtMDcgMTM6NDU6MzkuMDAwMDAwMDAw
IC0wNTAwCisrKyBsaW51eC0yLjYuMTEva2VybmVsL2F1ZGl0c2MuYwkyMDA1
LTAzLTA4IDE3OjMwOjA2LjA2NTIzNzQyNCAtMDUwMApAQCAtNTg0LDYgKzU4
NCwxNyBAQAogCQlwcmludGsoS0VSTl9FUlIgImF1ZGl0OiBmcmVlZCAlZCBj
b250ZXh0c1xuIiwgY291bnQpOwogfQogCit2b2lkIGF1ZGl0X2xvZ190YXNr
X2luZm8oc3RydWN0IGF1ZGl0X2J1ZmZlciAqYWIpCit7CisgICAgICAgIGNo
YXIgbmFtZVtzaXplb2YoY3VycmVudC0+Y29tbSldOworCisgICAgICAgIGdl
dF90YXNrX2NvbW0obmFtZSwgY3VycmVudCk7CisgICAgICAgIGF1ZGl0X2xv
Z19mb3JtYXQoYWIsICIgcHJvY25hbWU9JXMiLCBuYW1lKTsKKyAgICAgICAg
YXVkaXRfbG9nX2Zvcm1hdChhYiwgIiBzeXNjYWxsPSVkIHBlcj0lbHgiLCAK
KwkJY3VycmVudC0+YXVkaXRfY29udGV4dC0+bWFqb3IsCisJCWN1cnJlbnQt
PmF1ZGl0X2NvbnRleHQtPnBlcnNvbmFsaXR5KTsKK30KKwogc3RhdGljIHZv
aWQgYXVkaXRfbG9nX2V4aXQoc3RydWN0IGF1ZGl0X2NvbnRleHQgKmNvbnRl
eHQpCiB7CiAJaW50IGk7CmRpZmYgLXVyIGxpbnV4LTIuNi4xMS5vcmlnL3Nl
Y3VyaXR5L3NlbGludXgvYXZjLmMgbGludXgtMi42LjExL3NlY3VyaXR5L3Nl
bGludXgvYXZjLmMKLS0tIGxpbnV4LTIuNi4xMS5vcmlnL3NlY3VyaXR5L3Nl
bGludXgvYXZjLmMJMjAwNS0wMy0wNyAxMzo0NTo0Ni4wMDAwMDAwMDAgLTA1
MDAKKysrIGxpbnV4LTIuNi4xMS9zZWN1cml0eS9zZWxpbnV4L2F2Yy5jCTIw
MDUtMDMtMDggMTc6MjY6NDcuMDAwMDAwMDAwIC0wNTAwCkBAIC01NzUsNiAr
NTc1LDcgQEAKIAkJCQkJCWF1ZGl0X2xvZ19kX3BhdGgoYWIsICJleGU9IiwK
IAkJCQkJCQl2bWEtPnZtX2ZpbGUtPmZfZGVudHJ5LAogCQkJCQkJCXZtYS0+
dm1fZmlsZS0+Zl92ZnNtbnQpOworCQkJCQkJYXVkaXRfbG9nX3Rhc2tfaW5m
byhhYik7CiAJCQkJCQlicmVhazsKIAkJCQkJfQogCQkJCQl2bWEgPSB2bWEt
PnZtX25leHQ7Cg==

--0-779289395-1112212393=:43288--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
