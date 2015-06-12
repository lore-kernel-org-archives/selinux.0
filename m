Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CHwiIT010141
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 13:58:44 -0400
Received: by qkx62 with SMTP id 62so20474135qkx.3
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 10:58:41 -0700 (PDT)
MIME-Version: 1.0
From: Dan Albert <danalbert@google.com>
Date: Fri, 12 Jun 2015 10:58:21 -0700
Message-ID: <CAFVaGhtLUUiYMkWy2PUZZ0q+s1s=ZSdXh5vTNygVM2JtGDP7NQ@mail.gmail.com>
Subject: [PATCH] Remove uses of -Wno-return-type.
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=001a11c119e2c1d8c7051855db80
Cc: Elliott Hughes <enh@google.com>, sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c119e2c1d8c7051855db80
Content-Type: multipart/alternative; boundary=001a11c119e2c1d8bf051855db7e

--001a11c119e2c1d8bf051855db7e
Content-Type: text/plain; charset=UTF-8

These warnings were fixed in 93b2e5f.

--001a11c119e2c1d8bf051855db7e
Content-Type: text/html; charset=UTF-8

<div dir="ltr">These warnings were fixed in 93b2e5f.<br></div>

--001a11c119e2c1d8bf051855db7e--

--001a11c119e2c1d8c7051855db80
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Remove-uses-of-Wno-return-type.patch"
Content-Disposition: attachment;
	filename="0001-Remove-uses-of-Wno-return-type.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iatx3pvq0

RnJvbSA1NDcyNDE2Zjc4MjJjNTFiYjMwOWJmNTRkMWM5ZTllMzNmMTA0YmNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW4gQWxiZXJ0IDxkYW5hbGJlcnRAZ29vZ2xlLmNvbT4KRGF0
ZTogV2VkLCAxMCBKdW4gMjAxNSAxNjo1MTowNSAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIFJlbW92
ZSB1c2VzIG9mIC1Xbm8tcmV0dXJuLXR5cGUuCgpUaGVzZSB3YXJuaW5ncyB3ZXJlIGZpeGVkIGlu
IDkzYjJlNWYuCi0tLQogY2hlY2twb2xpY3kvQW5kcm9pZC5tayB8IDEgLQogc2VjaWxjL0FuZHJv
aWQubWsgICAgICB8IDEgLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2NoZWNrcG9saWN5L0FuZHJvaWQubWsgYi9jaGVja3BvbGljeS9BbmRyb2lkLm1rCmlu
ZGV4IGYzZjNiOGYuLjk4ZjUxNjggMTAwNjQ0Ci0tLSBhL2NoZWNrcG9saWN5L0FuZHJvaWQubWsK
KysrIGIvY2hlY2twb2xpY3kvQW5kcm9pZC5tawpAQCAtMTEsNyArMTEsNiBAQCBjb21tb25fc3Jj
X2ZpbGVzIDo9IFwKIGNvbW1vbl9jZmxhZ3MgOj0gXAogCS1XYWxsIC1Xc2hhZG93IC1PMiBcCiAJ
LXBpcGUgLWZuby1zdHJpY3QtYWxpYXNpbmcgXAotCS1Xbm8tcmV0dXJuLXR5cGUKIAogaWZlcSAo
JChIT1NUX09TKSxkYXJ3aW4pCiBjb21tb25fY2ZsYWdzICs9IC1EREFSV0lOCmRpZmYgLS1naXQg
YS9zZWNpbGMvQW5kcm9pZC5tayBiL3NlY2lsYy9BbmRyb2lkLm1rCmluZGV4IGVmNTg0ZTcuLjNk
ZDkwMjMgMTAwNjQ0Ci0tLSBhL3NlY2lsYy9BbmRyb2lkLm1rCisrKyBiL3NlY2lsYy9BbmRyb2lk
Lm1rCkBAIC01LDcgKzUsNiBAQCBjb21tb25fc3JjX2ZpbGVzIDo9IHNlY2lsYy5jCiBjb21tb25f
Y2ZsYWdzIDo9IFwKIAktV2FsbCAtV3NoYWRvdyAtTzIgXAogCS1waXBlIC1mbm8tc3RyaWN0LWFs
aWFzaW5nIFwKLQktV25vLXJldHVybi10eXBlCiAKIGlmZXEgKCQoSE9TVF9PUyksIGRhcndpbikK
IGNvbW1vbl9jZmxhZ3MgKz0gLUREQVJXSU4KLS0gCjIuMi4wLnJjMC4yMDcuZ2EzYTYxNmMKCg==
--001a11c119e2c1d8c7051855db80--
