Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t88AGnEQ022711
 for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2015 06:16:49 -0400
Received: by ykcf206 with SMTP id f206so110941737ykc.3
 for <selinux@tycho.nsa.gov>; Tue, 08 Sep 2015 03:16:48 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Tue, 8 Sep 2015 15:46:28 +0530
Message-ID: <CA+=dQ--oYEnzndkEFRWWxuX4t3n3sardYeLL5TWVJbzm=eLZPA@mail.gmail.com>
Subject: Not able to enter root after enabling selinux
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c075eceec922b051f39a991
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c075eceec922b051f39a991
Content-Type: text/plain; charset=UTF-8

Hi,

After I enabled selinux with default policy , I am not able to enter root
neither ssh it.

semanage login -l

Login Name                SELinux User

__default__               user_u
root                      root
system_u                  system_u

Which user I should login?

conifg file is :

SELINUX=enforcing
# SELINUXTYPE= can take one of these two values:
#     standard - Standard Security protection.
#     mls - Multi Level Security protection.
SELINUXTYPE=mls

--94eb2c075eceec922b051f39a991
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGksPGJyPjxicj48L2Rpdj5BZnRlciBJIGVu
YWJsZWQgc2VsaW51eCB3aXRoIGRlZmF1bHQgcG9saWN5ICwgSSBhbSBub3QgYWJsZSB0byBlbnRl
ciByb290IG5laXRoZXIgc3NoIGl0LiA8YnI+PGJyPnNlbWFuYWdlIGxvZ2luIC1sIDxicj48YnI+
TG9naW4gTmFtZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTRUxpbnV4IFVzZXLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgPGJyPjxicj5fX2RlZmF1bHRfX8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdXNlcl91wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxi
cj5yb290wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJvb3TCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxicj5zeXN0ZW1fdcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzdGVtX3UgPGJyPjxicj48L2Rpdj5XaGljaCB1
c2VyIEkgc2hvdWxkIGxvZ2luPyA8YnI+PGJyPjwvZGl2PmNvbmlmZyBmaWxlIGlzIDo8YnI+PGJy
PlNFTElOVVg9ZW5mb3JjaW5nPGJyPiMgU0VMSU5VWFRZUEU9IGNhbiB0YWtlIG9uZSBvZiB0aGVz
ZSB0d28gdmFsdWVzOjxicj4jwqDCoMKgwqAgc3RhbmRhcmQgLSBTdGFuZGFyZCBTZWN1cml0eSBw
cm90ZWN0aW9uLjxicj4jwqDCoMKgwqAgbWxzIC0gTXVsdGkgTGV2ZWwgU2VjdXJpdHkgcHJvdGVj
dGlvbi48YnI+U0VMSU5VWFRZUEU9bWxzwqDCoMKgIDxicj48YnI+PGJyPjwvZGl2Pg0K
--94eb2c075eceec922b051f39a991--
