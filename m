Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAO6q84E019004
 for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2017 01:52:08 -0500
Received: by mail-qt0-f181.google.com with SMTP id r39so30273928qtr.13
 for <selinux@tycho.nsa.gov>; Thu, 23 Nov 2017 22:52:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
From: Ravi Kumar <nxp.ravi@gmail.com>
Date: Fri, 24 Nov 2017 12:22:04 +0530
Message-ID: <CACikiw0K0ospvKt-midzSPYQegd3GR46mVjhwiPc3eUULV4oUg@mail.gmail.com>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113f4b969215df055eb4fd17"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f4b969215df055eb4fd17
Content-Type: text/plain; charset="UTF-8"

Based on the config  each type of login ( ssh ,shell  ) will have it own
role .  if this is just for testing you can try setting the  bool value  if
you are logging via ssh.

setsebool -P ssh_sysadm_login 1



Regards,
Ravi

On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma <amansh.sharma5@gmail.com>
wrote:

>
>
> Hi All,
>
> Currently Working on Cent OS 7.3 and login as a root User and my Id
> command output is :
>
> *id*
> *uid=0(root) gid=0(root) groups=0(root)
> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
>
> I want to change *System_u:system_r:unconfined_t to sysadm_u:sysadm_r or *
> *unconfined_u:**unconfined_r**. *
>
> *Also showing the output of following command :*
>
> *semanage user -l*
>
> *                Labeling   MLS/       MLS/                          *
> *SELinux User    Prefix     MCS Level  MCS Range
> SELinux Roles*
>
> *admin_u         user       s0         s0-s0:c0.c1023
>  sysadm_r system_r*
> *guest_u         user       s0         s0
>  guest_r*
> *root            user       s0         s0-s0:c0.c1023
>  staff_r sysadm_r*
> *specialuser_u   user       s0         s0
>  sysadm_r system_r*
> *staff_u         user       s0         s0-s0:c0.c1023
>  staff_r sysadm_r system_r*
> *sysadm_u        user       s0         s0-s0:c0.c1023
>  sysadm_r*
> *system_u        user       s0         s0-s0:c0.c1023
>  system_r*
> *unconfined_u    user       s0         s0-s0:c0.c1023
>  system_r unconfined_r*
> *user_u          user       s0         s0
>  user_r*
> *xguest_u        user       s0         s0
>  xguest_r*
>
>
> * semanage login -l*
>
> *Login Name           SELinux User         MLS/MCS Range        Service*
>
> *__default__          sysadm_u             s0-s0:c0.c1023       **
> *ccmservice           specialuser_u        s0                   **
> *cucm                 admin_u              s0-s0:c0.c1023       **
> *drfkeys              specialuser_u        s0                   **
> *drfuser              specialuser_u        s0                   **
> *informix             specialuser_u        s0                   **
> *pwrecovery           specialuser_u        s0                   **
> *root                 sysadm_u             s0-s0:c0.c1023       **
> *sftpuser             specialuser_u        s0                   **
> *system_u             sysadm_u             s0-s0:c0.c1023       **
>
>
> *Can anybody Please help me.*
>
> --
>
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>
>

--001a113f4b969215df055eb4fd17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+QmFzZWQgb24gdGhlIGNvbmZpZ8KgIGVhY2ggdHlwZSBvZiBsb2dpbiAo
IHNzaCAsc2hlbGzCoCApIHdpbGwgaGF2ZSBpdCBvd24gcm9sZSAuwqAgaWYgdGhpcyBpcyBqdXN0
IGZvciB0ZXN0aW5nIHlvdSBjYW4gdHJ5IHNldHRpbmcgdGhlwqAgYm9vbCB2YWx1ZcKgIGlmIHlv
dSBhcmUgbG9nZ2luZyB2aWEgc3NoLsKgPGRpdj48YnI+PGRpdj5zZXRzZWJvb2wgLVAgc3NoX3N5
c2FkbV9sb2dpbiAxPGJyPjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8YnI+UmF2aTwvZGl2PjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgTm92
IDI0LCAyMDE3IGF0IDEwOjQ3IEFNLCBBbWFuIFNoYXJtYSA8c3BhbiBkaXI9Imx0ciI+Jmx0Ozxh
IGhyZWY9Im1haWx0bzphbWFuc2guc2hhcm1hNUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5h
bWFuc2guc2hhcm1hNUBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48YnI+PGRpdiBjbGFzcz0ibV8tNjI5ODY1MTg1ODg0MTUyODE0
OEhPRW5aYiI+PGRpdiBjbGFzcz0ibV8tNjI5ODY1MTg1ODg0MTUyODE0OGg1Ij48ZGl2IGRpcj0i
bHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJyPjxkaXYgZGlyPSJsdHIiPkhpIEFsbCw8
ZGl2Pjxicj48L2Rpdj48ZGl2PkN1cnJlbnRseSBXb3JraW5nIG9uIENlbnQgT1MgNy4zIGFuZCBs
b2dpbiBhcyBhIHJvb3QgVXNlciBhbmQgbXkgSWQgY29tbWFuZCBvdXRwdXQgaXMgOjwvZGl2Pjxk
aXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PjxkaXY+PGI+aWQ8L2I+PC9kaXY+PGRpdj48Yj51aWQ9
MChyb290KSBnaWQ9MChyb290KSBncm91cHM9MChyb290KSBjb250ZXh0PXN5c3RlbV91OnN5c3Rl
bV9yOnVuY288d2JyPm5maW5lZF90OnMwLXMwOmMwLmMxMDIzPC9iPjwvZGl2PjxkaXY+PGI+PGJy
PjwvYj48L2Rpdj48ZGl2Pkkgd2FudCB0byBjaGFuZ2UgPGI+U3lzdGVtX3U6c3lzdGVtX3I6dW5j
b25maW5lZF90IHRvIHN5c2FkbV91OnN5c2FkbV9yIG9ywqA8L2I+PGI+dW5jb25maW5lZF91Ojwv
Yj48Yj51bmNvbmZpbmVkX3I8L2I+PGI+LsKgPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rp
dj48ZGl2PjxiPkFsc28gc2hvd2luZyB0aGUgb3V0cHV0IG9mIGZvbGxvd2luZyBjb21tYW5kIDo8
L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGRpdj48Yj5zZW1hbmFnZSB1c2Vy
IC1sPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PjxiPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIExhYmVsaW5nwqAgwqBNTFMvwqAgwqAgwqAgwqBNTFMvwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoDwvYj48L2Rpdj48ZGl2PjxiPlNFTGludXggVXNlcsKg
IMKgIFByZWZpeMKgIMKgIMKgTUNTIExldmVswqAgTUNTIFJhbmdlwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgU0VMaW51eCBSb2xlczwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9k
aXY+PGRpdj48Yj5hZG1pbl91wqAgwqAgwqAgwqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKg
IMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV9yIHN5
c3RlbV9yPC9iPjwvZGl2PjxkaXY+PGI+Z3Vlc3RfdcKgIMKgIMKgIMKgIMKgdXNlcsKgIMKgIMKg
IMKgczDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBndWVzdF9yPC9iPjwvZGl2PjxkaXY+PGI+cm9vdMKgIMKgIMKgIMKgIMKgIMKgIHVz
ZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RhZmZfciBzeXNhZG1fcjwvYj48L2Rpdj48ZGl2PjxiPnNwZWNpYWx1c2Vy
X3XCoCDCoHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzYWRtX3Igc3lzdGVtX3I8L2I+PC9kaXY+PGRp
dj48Yj5zdGFmZl91wqAgwqAgwqAgwqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKg
czAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YWZmX3Igc3lzYWRtX3Ig
c3lzdGVtX3I8L2I+PC9kaXY+PGRpdj48Yj5zeXNhZG1fdcKgIMKgIMKgIMKgIHVzZXLCoCDCoCDC
oCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3lzYWRtX3I8L2I+PC9kaXY+PGRpdj48Yj5zeXN0ZW1fdcKgIMKgIMKgIMKgIHVzZXLCoCDC
oCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3lzdGVtX3I8L2I+PC9kaXY+PGRpdj48Yj51bmNvbmZpbmVkX3XCoCDCoCB1c2VywqAg
wqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN5c3RlbV9yIHVuY29uZmluZWRfcjwvYj48L2Rpdj48ZGl2PjxiPnVzZXJfdcKgIMKg
IMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXNlcl9yPC9iPjwvZGl2PjxkaXY+PGI+eGd1
ZXN0X3XCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHhndWVzdF9yPC9iPjwvZGl2Pjxk
aXYgc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQiPjxicj48L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXdlaWdodDpib2xkIj48YnI+PC9kaXY+PGRpdj48ZGl2PjxiPsKgc2VtYW5hZ2UgbG9naW4g
LWw8L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGI+TG9naW4gTmFtZcKgIMKg
IMKgIMKgIMKgIMKgU0VMaW51eCBVc2VywqAgwqAgwqAgwqAgwqBNTFMvTUNTIFJhbmdlwqAgwqAg
wqAgwqAgU2VydmljZTwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5fX2Rl
ZmF1bHRfX8KgIMKgIMKgIMKgIMKgIHN5c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1zMDpj
MC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPmNjbXNlcnZpY2XCoCDCoCDCoCDC
oCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPmN1Y23CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFk
bWluX3XCoCDCoCDCoCDCoCDCoCDCoCDCoCBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48
L2Rpdj48ZGl2PjxiPmRyZmtleXPCoCDCoCDCoCDCoCDCoCDCoCDCoCBzcGVjaWFsdXNlcl91wqAg
wqAgwqAgwqAgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48
Yj5kcmZ1c2VywqAgwqAgwqAgwqAgwqAgwqAgwqAgc3BlY2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMw
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPC9iPjwvZGl2PjxkaXY+PGI+aW5mb3JtaXjC
oCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPnB3cmVjb3ZlcnnCoCDCoCDCoCDC
oCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPnJvb3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5
c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48
L2Rpdj48ZGl2PjxiPnNmdHB1c2VywqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91wqAg
wqAgwqAgwqAgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48
Yj5zeXN0ZW1fdcKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzYWRtX3XCoCDCoCDCoCDCoCDCoCDCoCDC
oHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAqPC9iPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtd2Vp
Z2h0OmJvbGQiPjxicj48L2Rpdj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5D
YW4gYW55Ym9keSBQbGVhc2UgaGVscCBtZS48L2I+PC9kaXY+PHNwYW4gY2xhc3M9IkhPRW5aYiI+
PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxzcGFuIGNsYXNzPSJtXy02Mjk4NjUxODU4ODQxNTI4MTQ4
bV8tMTE5MTQ4NDg3NzAzOTY0MjY1M0hPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxkaXY+
PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJtXy02Mjk4NjUxODU4ODQxNTI4MTQ4bV8tMTE5
MTQ4NDg3NzAzOTY0MjY1M21fLTQxODkwNjIwMjM1ODE3NTk0NTNnbWFpbF9zaWduYXR1cmUiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5BbWFuPC9k
aXY+PGRpdj5DZWxsOiArOTEgOTk5MDI5NjQwNCB8IMKgRW1haWwgSUQgOiA8YSBocmVmPSJtYWls
dG86YW1hbnNoLnNoYXJtYTVAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YW1hbnNoLnNoYXJt
YTVAZ21haWwuY29tPC9hPjwvZGl2PjwvZGl2PjwvZGl2Pg0KPC9mb250Pjwvc3Bhbj48L2ZvbnQ+
PC9zcGFuPjwvZGl2PjwvZGl2Pg0KPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGRpdiBj
bGFzcz0ibV8tNjI5ODY1MTg1ODg0MTUyODE0OGdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1h
aWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjwvZGl2Pg0KPC9k
aXY+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pg0K
--001a113f4b969215df055eb4fd17--
