Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAO5I1HV028471
 for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2017 00:18:01 -0500
Received: by mail-it0-f53.google.com with SMTP id o130so13848099itg.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Nov 2017 21:17:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Fri, 24 Nov 2017 10:47:56 +0530
Message-ID: <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="94eb2c04e950f31b0a055eb3acfa"
Subject: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c04e950f31b0a055eb3acfa
Content-Type: text/plain; charset="UTF-8"

Hi All,

Currently Working on Cent OS 7.3 and login as a root User and my Id command
output is :

*id*
*uid=0(root) gid=0(root) groups=0(root)
context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*

I want to change *System_u:system_r:unconfined_t to sysadm_u:sysadm_r or *
*unconfined_u:**unconfined_r**. *

*Also showing the output of following command :*

*semanage user -l*

*                Labeling   MLS/       MLS/                          *
*SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles*

*admin_u         user       s0         s0-s0:c0.c1023
 sysadm_r system_r*
*guest_u         user       s0         s0
 guest_r*
*root            user       s0         s0-s0:c0.c1023
 staff_r sysadm_r*
*specialuser_u   user       s0         s0
 sysadm_r system_r*
*staff_u         user       s0         s0-s0:c0.c1023
 staff_r sysadm_r system_r*
*sysadm_u        user       s0         s0-s0:c0.c1023
 sysadm_r*
*system_u        user       s0         s0-s0:c0.c1023
 system_r*
*unconfined_u    user       s0         s0-s0:c0.c1023
 system_r unconfined_r*
*user_u          user       s0         s0
 user_r*
*xguest_u        user       s0         s0
 xguest_r*


* semanage login -l*

*Login Name           SELinux User         MLS/MCS Range        Service*

*__default__          sysadm_u             s0-s0:c0.c1023       **
*ccmservice           specialuser_u        s0                   **
*cucm                 admin_u              s0-s0:c0.c1023       **
*drfkeys              specialuser_u        s0                   **
*drfuser              specialuser_u        s0                   **
*informix             specialuser_u        s0                   **
*pwrecovery           specialuser_u        s0                   **
*root                 sysadm_u             s0-s0:c0.c1023       **
*sftpuser             specialuser_u        s0                   **
*system_u             sysadm_u             s0-s0:c0.c1023       **


*Can anybody Please help me.*

-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--94eb2c04e950f31b0a055eb3acfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxicj48ZGl2IGNsYXNzPSJI
T0VuWmIiPjxkaXYgY2xhc3M9Img1Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGJyPjxkaXYgZGlyPSJsdHIiPkhpIEFsbCw8ZGl2Pjxicj48L2Rpdj48ZGl2PkN1cnJl
bnRseSBXb3JraW5nIG9uIENlbnQgT1MgNy4zIGFuZCBsb2dpbiBhcyBhIHJvb3QgVXNlciBhbmQg
bXkgSWQgY29tbWFuZCBvdXRwdXQgaXMgOjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2
PjxkaXY+PGI+aWQ8L2I+PC9kaXY+PGRpdj48Yj51aWQ9MChyb290KSBnaWQ9MChyb290KSBncm91
cHM9MChyb290KSBjb250ZXh0PXN5c3RlbV91OnN5c3RlbV9yOnVuY288d2JyPm5maW5lZF90OnMw
LXMwOmMwLmMxMDIzPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2Pkkgd2FudCB0
byBjaGFuZ2UgPGI+U3lzdGVtX3U6c3lzdGVtX3I6dW5jb25maW5lZF90IHRvIHN5c2FkbV91OnN5
c2FkbV9yIG9ywqA8L2I+PGI+dW5jb25maW5lZF91OjwvYj48Yj51bmNvbmZpbmVkX3I8L2I+PGI+
LsKgPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PjxiPkFsc28gc2hvd2luZyB0
aGUgb3V0cHV0IG9mIGZvbGxvd2luZyBjb21tYW5kIDo8L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9i
PjwvZGl2PjxkaXY+PGRpdj48Yj5zZW1hbmFnZSB1c2VyIC1sPC9iPjwvZGl2PjxkaXY+PGI+PGJy
PjwvYj48L2Rpdj48ZGl2PjxiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExhYmVsaW5nwqAgwqBN
TFMvwqAgwqAgwqAgwqBNTFMvwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDC
oDwvYj48L2Rpdj48ZGl2PjxiPlNFTGludXggVXNlcsKgIMKgIFByZWZpeMKgIMKgIMKgTUNTIExl
dmVswqAgTUNTIFJhbmdlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0VMaW51eCBS
b2xlczwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5hZG1pbl91wqAgwqAg
wqAgwqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV9yIHN5c3RlbV9yPC9iPjwvZGl2PjxkaXY+PGI+
Z3Vlc3RfdcKgIMKgIMKgIMKgIMKgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBndWVzdF9yPC9iPjwvZGl2
PjxkaXY+PGI+cm9vdMKgIMKgIMKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAg
wqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhZmZfciBzeXNh
ZG1fcjwvYj48L2Rpdj48ZGl2PjxiPnNwZWNpYWx1c2VyX3XCoCDCoHVzZXLCoCDCoCDCoCDCoHMw
wqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3lzYWRtX3Igc3lzdGVtX3I8L2I+PC9kaXY+PGRpdj48Yj5zdGFmZl91wqAgwqAgwqAgwqAg
wqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0YWZmX3Igc3lzYWRtX3Igc3lzdGVtX3I8L2I+PC9kaXY+PGRpdj48
Yj5zeXNhZG1fdcKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1z
MDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzYWRtX3I8L2I+PC9kaXY+PGRp
dj48Yj5zeXN0ZW1fdcKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBz
MC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzdGVtX3I8L2I+PC9kaXY+
PGRpdj48Yj51bmNvbmZpbmVkX3XCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKg
czAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbV9yIHVuY29uZmlu
ZWRfcjwvYj48L2Rpdj48ZGl2PjxiPnVzZXJfdcKgIMKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDC
oHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgdXNlcl9yPC9iPjwvZGl2PjxkaXY+PGI+eGd1ZXN0X3XCoCDCoCDCoCDCoCB1c2VywqAg
wqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHhndWVzdF9yPC9iPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtd2VpZ2h0OmJv
bGQiPjxicj48L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXdlaWdodDpib2xkIj48YnI+PC9k
aXY+PGRpdj48ZGl2PjxiPsKgc2VtYW5hZ2UgbG9naW4gLWw8L2I+PC9kaXY+PGRpdj48Yj48YnI+
PC9iPjwvZGl2PjxkaXY+PGI+TG9naW4gTmFtZcKgIMKgIMKgIMKgIMKgIMKgU0VMaW51eCBVc2Vy
wqAgwqAgwqAgwqAgwqBNTFMvTUNTIFJhbmdlwqAgwqAgwqAgwqAgU2VydmljZTwvYj48L2Rpdj48
ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5fX2RlZmF1bHRfX8KgIMKgIMKgIMKgIMKgIHN5
c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48
L2Rpdj48ZGl2PjxiPmNjbXNlcnZpY2XCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDC
oCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2Pjxi
PmN1Y23CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkbWluX3XCoCDCoCDCoCDCoCDCoCDCoCDC
oCBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPmRyZmtleXPCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5kcmZ1c2VywqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3BlY2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAqPC9iPjwvZGl2PjxkaXY+PGI+aW5mb3JtaXjCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNp
YWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjwvYj48
L2Rpdj48ZGl2PjxiPnB3cmVjb3ZlcnnCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDC
oCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2Pjxi
PnJvb3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAg
wqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPnNmdHB1c2VywqAg
wqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5zeXN0ZW1fdcKgIMKgIMKgIMKgIMKg
IMKgIMKgc3lzYWRtX3XCoCDCoCDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAg
wqAqPC9iPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQiPjxicj48L2Rpdj48L2Rp
dj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5DYW4gYW55Ym9keSBQbGVhc2UgaGVscCBt
ZS48L2I+PC9kaXY+PHNwYW4gY2xhc3M9Im1fLTExOTE0ODQ4NzcwMzk2NDI2NTNIT0VuWmIiPjxm
b250IGNvbG9yPSIjODg4ODg4Ij48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBjbGFzcz0ibV8t
MTE5MTQ4NDg3NzAzOTY0MjY1M21fLTQxODkwNjIwMjM1ODE3NTk0NTNnbWFpbF9zaWduYXR1cmUi
PjxkaXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5BbWFu
PC9kaXY+PGRpdj5DZWxsOiArOTEgOTk5MDI5NjQwNCB8IMKgRW1haWwgSUQgOiA8YSBocmVmPSJt
YWlsdG86YW1hbnNoLnNoYXJtYTVAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YW1hbnNoLnNo
YXJtYTVAZ21haWwuY29tPC9hPjwvZGl2PjwvZGl2PjwvZGl2Pg0KPC9mb250Pjwvc3Bhbj48L2Rp
dj48L2Rpdj4NCjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0
ciI+PGJyPjwvZGl2PjwvZGl2Pg0KPC9kaXY+DQo=
--94eb2c04e950f31b0a055eb3acfa--
