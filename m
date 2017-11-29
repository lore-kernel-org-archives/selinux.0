MIME-Version: 1.0
In-Reply-To: <1511963505.10464.2.camel@tycho.nsa.gov>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 20:11:55 +0530
Message-ID: <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11351a001afa58055f20231b"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11351a001afa58055f20231b
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Thanks for the reply.

Can you please let me know how to delete all local customizations (via
semanage or manually) and revert
to a default policy.

Otherwise the output of semanage login -l and semanage user -l  :

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

*Please let me know if any comments are there.*

*Thanks*
*Aman*

On Wed, Nov 29, 2017 at 7:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > Below is the output of command :
> >
> >  sestatus -v output
> > SELinux status:                 enabled
> > SELinuxfs mount:                /sys/fs/selinux
> > SELinux root directory:         /etc/selinux
> > Loaded policy name:             targeted
> > Current mode:                   enforcing
> > Mode from config file:          permissive
> > Policy MLS status:              enabled
> > Policy deny_unknown status:     allowed
> > Max kernel policy version:      28
> >
> > Process contexts:
> > Current context:                system_u:system_r:unconfined_t:s0-
> > s0:c0.c1023
> > Init context:                   system_u:system_r:init_t:s0
> > /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> > s0:c0.c1023
> >
> > File contexts:
> > Controlling terminal:           system_u:object_r:sshd_devpts_t:s0
> > /etc/passwd                     system_u:object_r:passwd_file_t:s0
> > /etc/shadow                     system_u:object_r:shadow_t:s0
> > /bin/bash                       system_u:object_r:shell_exec_t:s0
> > /bin/login                      system_u:object_r:login_exec_t:s0
> > /bin/sh                         system_u:object_r:bin_t:s0 ->
> > system_u:object_r:shell_exec_t:s0
> > /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> > /sbin/init                      system_u:object_r:bin_t:s0 ->
> > system_u:object_r:init_exec_t:s0
> > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> > /lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > system_u:object_r:lib_t:s0
> > /lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > system_u:object_r:ld_so_t:s0
> >
> > Also I am using ssh session for login.
> >
> > Please let me know how to change id command context to unconfined_u
> > or Sysadm_u.
>
> So from your earlier message, it is clear that you (or someone else)
> has heavily customized your semanage login and user mappings from the
> stock targeted policy.  The question is why, and whether you want/need
> to retain any of those customizations.  If not, then you could just
> delete all local customizations (via semanage or manually) and revert
> to a stock policy.
>
> If you do need to retain some of those customizations, then please show
> your current semanage login -l and semanage user -l output since you
> said you ran some further semanage commands after the last output you
> showed.
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11351a001afa58055f20231b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgU3RlcGhlbiw8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyBmb3Ig
dGhlIHJlcGx5LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2FuIHlvdSBwbGVhc2UgbGV0IG1l
IGtub3cgaG93IHRvIGRlbGV0ZSBhbGwgbG9jYWzCoDxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIu
OHB4Ij5jdXN0b21pemF0aW9ucyAodmlhIHNlbWFuYWdlIG9yIG1hbnVhbGx5KSBhbmQgcmV2ZXJ0
PC9zcGFuPjwvZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuOHB4Ij50byBhIGRlZmF1bHQg
cG9saWN5LsKgPC9zcGFuPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPjxicj48
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+T3RoZXJ3aXNl
IHRoZSBvdXRwdXQgb2bCoDwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+c2Vt
YW5hZ2UgbG9naW4gLWwgYW5kIHNlbWFuYWdlIHVzZXIgLWw8L3NwYW4+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMi44cHgiPsKgIDo8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjhweCI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTox
Mi44cHgiPjxkaXY+PGI+c2VtYW5hZ2UgdXNlciAtbDwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+
PC9kaXY+PGRpdj48Yj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMYWJlbGluZ8KgIMKgTUxTL8Kg
IMKgIMKgIMKgTUxTL8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2I+
PC9kaXY+PGRpdj48Yj5TRUxpbnV4IFVzZXLCoCDCoCBQcmVmaXjCoCDCoCDCoE1DUyBMZXZlbMKg
IE1DUyBSYW5nZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNFTGludXggUm9sZXM8
L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGI+YWRtaW5fdcKgIMKgIMKgIMKg
IMKgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzeXNhZG1fciBzeXN0ZW1fcjwvYj48L2Rpdj48ZGl2PjxiPmd1ZXN0
X3XCoCDCoCDCoCDCoCDCoHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Vlc3RfcjwvYj48L2Rpdj48ZGl2
PjxiPnJvb3TCoCDCoCDCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKg
czAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YWZmX3Igc3lzYWRtX3I8
L2I+PC9kaXY+PGRpdj48Yj5zcGVjaWFsdXNlcl91wqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKg
IMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5
c2FkbV9yIHN5c3RlbV9yPC9iPjwvZGl2PjxkaXY+PGI+c3RhZmZfdcKgIMKgIMKgIMKgIMKgdXNl
csKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdGFmZl9yIHN5c2FkbV9yIHN5c3RlbV9yPC9iPjwvZGl2PjxkaXY+PGI+c3lz
YWRtX3XCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAu
YzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV9yPC9iPjwvZGl2PjxkaXY+PGI+
c3lzdGVtX3XCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6
YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbV9yPC9iPjwvZGl2PjxkaXY+
PGI+dW5jb25maW5lZF91wqAgwqAgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwLXMw
OmMwLmMxMDIzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fciB1bmNvbmZpbmVkX3I8
L2I+PC9kaXY+PGRpdj48Yj51c2VyX3XCoCDCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKg
IMKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHVzZXJfcjwvYj48L2Rpdj48ZGl2PjxiPnhndWVzdF91wqAgwqAgwqAgwqAgdXNlcsKgIMKgIMKg
IMKgczDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB4Z3Vlc3RfcjwvYj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXdlaWdodDpib2xkIj48
YnI+PC9kaXY+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEyLjhweDtmb250LXdlaWdodDpi
b2xkIj48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEyLjhweCI+PGRpdj48Yj7CoHNl
bWFuYWdlIGxvZ2luIC1sPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PjxiPkxv
Z2luIE5hbWXCoCDCoCDCoCDCoCDCoCDCoFNFTGludXggVXNlcsKgIMKgIMKgIMKgIMKgTUxTL01D
UyBSYW5nZcKgIMKgIMKgIMKgIFNlcnZpY2U8L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2
PjxkaXY+PGI+X19kZWZhdWx0X1/CoCDCoCDCoCDCoCDCoCBzeXNhZG1fdcKgIMKgIMKgIMKgIMKg
IMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5jY21zZXJ2
aWNlwqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5jdWNtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBhZG1pbl91wqAgwqAgwqAgwqAgwqAgwqAgwqAgczAtczA6YzAuYzEwMjPCoCDC
oCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5kcmZrZXlzwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3Bl
Y2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPC9i
PjwvZGl2PjxkaXY+PGI+ZHJmdXNlcsKgIMKgIMKgIMKgIMKgIMKgIMKgIHNwZWNpYWx1c2VyX3XC
oCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2
PjxiPmluZm9ybWl4wqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAg
czDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5wd3JlY292
ZXJ5wqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5yb290wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzeXNhZG1fdcKgIMKgIMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDC
oCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5zZnRwdXNlcsKgIMKgIMKgIMKgIMKgIMKgIMKgc3Bl
Y2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPC9i
PjwvZGl2PjxkaXY+PGI+c3lzdGVtX3XCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV91wqAgwqAg
wqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2Pjxi
Pjxicj48L2I+PC9kaXY+PGRpdj48Yj5QbGVhc2UgbGV0IG1lIGtub3cgaWYgYW55IGNvbW1lbnRz
IGFyZSB0aGVyZS48L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGI+VGhhbmtz
PC9iPjwvZGl2PjxkaXY+PGI+QW1hbjwvYj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBXZWQsIE5v
diAyOSwgMjAxNyBhdCA3OjIxIFBNLCBTdGVwaGVuIFNtYWxsZXkgPHNwYW4gZGlyPSJsdHIiPiZs
dDs8YSBocmVmPSJtYWlsdG86c2RzQHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5zZHNA
dHljaG8ubnNhLmdvdjwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNz
PSJoNSI+T24gV2VkLCAyMDE3LTExLTI5IGF0IDA5OjMzICswNTMwLCBBbWFuIFNoYXJtYSB3cm90
ZTo8YnI+DQomZ3Q7IEhpIFN0ZXBoZW4sPGJyPg0KJmd0Ozxicj4NCiZndDsgQmVsb3cgaXMgdGhl
IG91dHB1dCBvZiBjb21tYW5kIDo8YnI+DQomZ3Q7PGJyPg0KJmd0OyDCoHNlc3RhdHVzIC12IG91
dHB1dDxicj4NCiZndDsgU0VMaW51eCBzdGF0dXM6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
bmFibGVkPGJyPg0KJmd0OyBTRUxpbnV4ZnMgbW91bnQ6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
L3N5cy9mcy9zZWxpbnV4PGJyPg0KJmd0OyBTRUxpbnV4IHJvb3QgZGlyZWN0b3J5OsKgIMKgIMKg
IMKgIMKgL2V0Yy9zZWxpbnV4PGJyPg0KJmd0OyBMb2FkZWQgcG9saWN5IG5hbWU6wqAgwqAgwqAg
wqAgwqAgwqAgwqB0YXJnZXRlZDxicj4NCiZndDsgQ3VycmVudCBtb2RlOsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZW5mb3JjaW5nPGJyPg0KJmd0OyBNb2RlIGZyb20gY29uZmlnIGZpbGU6
wqAgwqAgwqAgwqAgwqAgcGVybWlzc2l2ZTxicj4NCiZndDsgUG9saWN5IE1MUyBzdGF0dXM6wqAg
wqAgwqAgwqAgwqAgwqAgwqAgZW5hYmxlZDxicj4NCiZndDsgUG9saWN5IGRlbnlfdW5rbm93biBz
dGF0dXM6wqAgwqAgwqBhbGxvd2VkPGJyPg0KJmd0OyBNYXgga2VybmVsIHBvbGljeSB2ZXJzaW9u
OsKgIMKgIMKgIDI4PGJyPg0KJmd0Ozxicj4NCiZndDsgUHJvY2VzcyBjb250ZXh0czo8YnI+DQom
Z3Q7IEN1cnJlbnQgY29udGV4dDrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpzeXN0
ZW1fcjp1bmNvbmZpbmVkXzx3YnI+dDpzMC08YnI+DQomZ3Q7IHMwOmMwLmMxMDIzPGJyPg0KJmd0
OyBJbml0IGNvbnRleHQ6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpzeXN0
ZW1fcjppbml0X3Q6czA8YnI+DQomZ3Q7IC91c3Ivc2Jpbi9zc2hkwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc3lzdGVtX3U6c3lzdGVtX3I6c3NoZF90OnMwLTxicj4NCiZndDsgczA6YzAuYzEw
MjM8YnI+DQomZ3Q7PGJyPg0KJmd0OyBGaWxlIGNvbnRleHRzOjxicj4NCiZndDsgQ29udHJvbGxp
bmcgdGVybWluYWw6wqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpvYmplY3Rfcjpzc2hkXzx3YnI+
ZGV2cHRzX3Q6czA8YnI+DQomZ3Q7IC9ldGMvcGFzc3dkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzeXN0ZW1fdTpvYmplY3RfcjpwYXNzd2RfPHdicj5maWxlX3Q6czA8YnI+DQomZ3Q7
IC9ldGMvc2hhZG93wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpvYmpl
Y3RfcjpzaGFkb3dfdDpzMDxicj4NCiZndDsgL2Jpbi9iYXNowqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpvYmplY3RfcjpzaGVsbF9leGVjXzx3YnI+dDpzMDxicj4N
CiZndDsgL2Jpbi9sb2dpbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c3RlbV91
Om9iamVjdF9yOmxvZ2luX2V4ZWNfPHdicj50OnMwPGJyPg0KJmd0OyAvYmluL3NowqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpvYmplY3RfcjpiaW5fdDpzMCAt
Jmd0Ozxicj4NCiZndDsgc3lzdGVtX3U6b2JqZWN0X3I6c2hlbGxfZXhlY188d2JyPnQ6czA8YnI+
DQomZ3Q7IC9zYmluL2FnZXR0ecKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c3RlbV91
Om9iamVjdF9yOmdldHR5X2V4ZWNfPHdicj50OnMwPGJyPg0KJmd0OyAvc2Jpbi9pbml0wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzdGVtX3U6b2JqZWN0X3I6YmluX3Q6czAgLSZn
dDs8YnI+DQomZ3Q7IHN5c3RlbV91Om9iamVjdF9yOmluaXRfZXhlY190Ojx3YnI+czA8YnI+DQom
Z3Q7IC91c3Ivc2Jpbi9zc2hkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzdGVtX3U6b2Jq
ZWN0X3I6c3NoZF9leGVjX3Q6PHdicj5zMDxicj4NCiZndDsgL2xpYi9saWJjLnNvLjbCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpvYmplY3RfcjpsaWJfdDpzMCAtJmd0Ozxicj4N
CiZndDsgc3lzdGVtX3U6b2JqZWN0X3I6bGliX3Q6czA8YnI+DQomZ3Q7IC9saWIvbGQtbGludXgu
c28uMsKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwIC0mZ3Q7
PGJyPg0KJmd0OyBzeXN0ZW1fdTpvYmplY3RfcjpsZF9zb190OnMwPGJyPg0KJmd0Ozxicj4NCiZn
dDsgQWxzbyBJIGFtIHVzaW5nIHNzaCBzZXNzaW9uIGZvciBsb2dpbi48YnI+DQomZ3Q7PGJyPg0K
Jmd0OyBQbGVhc2UgbGV0IG1lIGtub3cgaG93IHRvIGNoYW5nZSBpZCBjb21tYW5kIGNvbnRleHQg
dG8gdW5jb25maW5lZF91PGJyPg0KJmd0OyBvciBTeXNhZG1fdS48YnI+DQo8YnI+DQo8L2Rpdj48
L2Rpdj5TbyBmcm9tIHlvdXIgZWFybGllciBtZXNzYWdlLCBpdCBpcyBjbGVhciB0aGF0IHlvdSAo
b3Igc29tZW9uZSBlbHNlKTxicj4NCmhhcyBoZWF2aWx5IGN1c3RvbWl6ZWQgeW91ciBzZW1hbmFn
ZSBsb2dpbiBhbmQgdXNlciBtYXBwaW5ncyBmcm9tIHRoZTxicj4NCnN0b2NrIHRhcmdldGVkIHBv
bGljeS7CoCBUaGUgcXVlc3Rpb24gaXMgd2h5LCBhbmQgd2hldGhlciB5b3Ugd2FudC9uZWVkPGJy
Pg0KdG8gcmV0YWluIGFueSBvZiB0aG9zZSBjdXN0b21pemF0aW9ucy7CoCBJZiBub3QsIHRoZW4g
eW91IGNvdWxkIGp1c3Q8YnI+DQpkZWxldGUgYWxsIGxvY2FsIGN1c3RvbWl6YXRpb25zICh2aWEg
c2VtYW5hZ2Ugb3IgbWFudWFsbHkpIGFuZCByZXZlcnQ8YnI+DQp0byBhIHN0b2NrIHBvbGljeS48
YnI+DQo8YnI+DQpJZiB5b3UgZG8gbmVlZCB0byByZXRhaW4gc29tZSBvZiB0aG9zZSBjdXN0b21p
emF0aW9ucywgdGhlbiBwbGVhc2Ugc2hvdzxicj4NCnlvdXIgY3VycmVudCBzZW1hbmFnZSBsb2dp
biAtbCBhbmQgc2VtYW5hZ2UgdXNlciAtbCBvdXRwdXQgc2luY2UgeW91PGJyPg0Kc2FpZCB5b3Ug
cmFuIHNvbWUgZnVydGhlciBzZW1hbmFnZSBjb21tYW5kcyBhZnRlciB0aGUgbGFzdCBvdXRwdXQg
eW91PGJyPg0Kc2hvd2VkLjxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNs
ZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1
cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+
PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj5BbWFuPC9kaXY+PGRpdj5DZWxsOiArOTEg
OTk5MDI5NjQwNCB8IMKgRW1haWwgSUQgOiA8YSBocmVmPSJtYWlsdG86YW1hbnNoLnNoYXJtYTVA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YW1hbnNoLnNoYXJtYTVAZ21haWwuY29tPC9hPjwv
ZGl2PjwvZGl2PjwvZGl2Pg0KPC9kaXY+DQo=
--001a11351a001afa58055f20231b--
