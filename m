MIME-Version: 1.0
In-Reply-To: <1511798379.23941.6.camel@tycho.nsa.gov>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 09:33:31 +0530
Message-ID: <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113dbf6afcf1a7055f173761"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113dbf6afcf1a7055f173761
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Below is the output of command :

* sestatus -v output*
*SELinux status:                 enabled*
*SELinuxfs mount:                /sys/fs/selinux*
*SELinux root directory:         /etc/selinux*
*Loaded policy name:             targeted*
*Current mode:                   enforcing*
*Mode from config file:          permissive*
*Policy MLS status:              enabled*
*Policy deny_unknown status:     allowed*
*Max kernel policy version:      28*

*Process contexts:*
*Current context:
system_u:system_r:unconfined_t:s0-s0:c0.c1023*
*Init context:                   system_u:system_r:init_t:s0*
*/usr/sbin/sshd                  system_u:system_r:sshd_t:s0-s0:c0.c1023*

*File contexts:*
*Controlling terminal:           system_u:object_r:sshd_devpts_t:s0*
*/etc/passwd                     system_u:object_r:passwd_file_t:s0*
*/etc/shadow                     system_u:object_r:shadow_t:s0*
*/bin/bash                       system_u:object_r:shell_exec_t:s0*
*/bin/login                      system_u:object_r:login_exec_t:s0*
*/bin/sh                         system_u:object_r:bin_t:s0 ->
system_u:object_r:shell_exec_t:s0*
*/sbin/agetty                    system_u:object_r:getty_exec_t:s0*
*/sbin/init                      system_u:object_r:bin_t:s0 ->
system_u:object_r:init_exec_t:s0*
*/usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0*
*/lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
system_u:object_r:lib_t:s0*
*/lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
system_u:object_r:ld_so_t:s0*

*Also I am using ssh session for login.*

*Please let me know how to change id command context to unconfined_u or
Sysadm_u.*

Thanks in advance
Aman

On Mon, Nov 27, 2017 at 9:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:
> >
> >
> > Hi All,
> >
> > Currently Working on Cent OS 7.3 and login as a root User and my Id
> > command output is :
> >
> > id
> > uid=0(root) gid=0(root) groups=0(root)
> > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> >
> > I want to change System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> > or unconfined_u:unconfined_r.
> >
> > Also showing the output of following command :
> >
> > semanage user -l
> >
> >                 Labeling   MLS/       MLS/
> > SELinux User    Prefix     MCS Level  MCS Range
> > SELinux Roles
> >
> > admin_u         user       s0         s0-s0:c0.c1023
> >  sysadm_r system_r
> > guest_u         user       s0         s0
> >  guest_r
> > root            user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r
> > specialuser_u   user       s0         s0
> >  sysadm_r system_r
> > staff_u         user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r system_r
> > sysadm_u        user       s0         s0-s0:c0.c1023
> >  sysadm_r
> > system_u        user       s0         s0-s0:c0.c1023
> >  system_r
> > unconfined_u    user       s0         s0-s0:c0.c1023
> >  system_r unconfined_r
> > user_u          user       s0         s0
> >  user_r
> > xguest_u        user       s0         s0
> >  xguest_r
> >
> >
> >  semanage login -l
> >
> > Login Name           SELinux User         MLS/MCS Range
> > Service
> >
> > __default__          sysadm_u             s0-s0:c0.c1023       *
> > ccmservice           specialuser_u        s0                   *
> > cucm                 admin_u              s0-s0:c0.c1023       *
> > drfkeys              specialuser_u        s0                   *
> > drfuser              specialuser_u        s0                   *
> > informix             specialuser_u        s0                   *
> > pwrecovery           specialuser_u        s0                   *
> > root                 sysadm_u             s0-s0:c0.c1023       *
> > sftpuser             specialuser_u        s0                   *
> > system_u             sysadm_u             s0-s0:c0.c1023       *
> >
> >
> > Can anybody Please help me.
>
> What is your sestatus -v output?  How are you logging in (console, gdm,
> ssh, ...)?
>
> You don't appear to be running the default policy, or if you are,
> someone has heavily customized your user and login mappings.
>
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113dbf6afcf1a7055f173761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgU3RlcGhlbiw8ZGl2Pjxicj48L2Rpdj48ZGl2PkJlbG93IGlzIHRo
ZSBvdXRwdXQgb2YgY29tbWFuZCA6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PjxiPsKg
c2VzdGF0dXMgLXYgb3V0cHV0PC9iPjwvZGl2PjxkaXY+PGI+U0VMaW51eCBzdGF0dXM6wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGVkPC9iPjwvZGl2PjxkaXY+PGI+U0VMaW51eGZzIG1v
dW50OsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC9zeXMvZnMvc2VsaW51eDwvYj48L2Rpdj48ZGl2
PjxiPlNFTGludXggcm9vdCBkaXJlY3Rvcnk6wqAgwqAgwqAgwqAgwqAvZXRjL3NlbGludXg8L2I+
PC9kaXY+PGRpdj48Yj5Mb2FkZWQgcG9saWN5IG5hbWU6wqAgwqAgwqAgwqAgwqAgwqAgwqB0YXJn
ZXRlZDwvYj48L2Rpdj48ZGl2PjxiPkN1cnJlbnQgbW9kZTrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVuZm9yY2luZzwvYj48L2Rpdj48ZGl2PjxiPk1vZGUgZnJvbSBjb25maWcgZmlsZTrC
oCDCoCDCoCDCoCDCoCBwZXJtaXNzaXZlPC9iPjwvZGl2PjxkaXY+PGI+UG9saWN5IE1MUyBzdGF0
dXM6wqAgwqAgwqAgwqAgwqAgwqAgwqAgZW5hYmxlZDwvYj48L2Rpdj48ZGl2PjxiPlBvbGljeSBk
ZW55X3Vua25vd24gc3RhdHVzOsKgIMKgIMKgYWxsb3dlZDwvYj48L2Rpdj48ZGl2PjxiPk1heCBr
ZXJuZWwgcG9saWN5IHZlcnNpb246wqAgwqAgwqAgMjg8L2I+PC9kaXY+PGRpdj48Yj48YnI+PC9i
PjwvZGl2PjxkaXY+PGI+UHJvY2VzcyBjb250ZXh0czo8L2I+PC9kaXY+PGRpdj48Yj5DdXJyZW50
IGNvbnRleHQ6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzdGVtX3U6c3lzdGVtX3I6dW5jb25m
aW5lZF90OnMwLXMwOmMwLmMxMDIzPC9iPjwvZGl2PjxkaXY+PGI+SW5pdCBjb250ZXh0OsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzdGVtX3U6c3lzdGVtX3I6aW5pdF90OnMwPC9iPjwv
ZGl2PjxkaXY+PGI+L3Vzci9zYmluL3NzaGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0
ZW1fdTpzeXN0ZW1fcjpzc2hkX3Q6czAtczA6YzAuYzEwMjM8L2I+PC9kaXY+PGRpdj48Yj48YnI+
PC9iPjwvZGl2PjxkaXY+PGI+RmlsZSBjb250ZXh0czo8L2I+PC9kaXY+PGRpdj48Yj5Db250cm9s
bGluZyB0ZXJtaW5hbDrCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbV91Om9iamVjdF9yOnNzaGRfZGV2
cHRzX3Q6czA8L2I+PC9kaXY+PGRpdj48Yj4vZXRjL3Bhc3N3ZMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3lzdGVtX3U6b2JqZWN0X3I6cGFzc3dkX2ZpbGVfdDpzMDwvYj48L2Rpdj48
ZGl2PjxiPi9ldGMvc2hhZG93wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1f
dTpvYmplY3RfcjpzaGFkb3dfdDpzMDwvYj48L2Rpdj48ZGl2PjxiPi9iaW4vYmFzaMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzdGVtX3U6b2JqZWN0X3I6c2hlbGxfZXhlY190
OnMwPC9iPjwvZGl2PjxkaXY+PGI+L2Jpbi9sb2dpbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN5c3RlbV91Om9iamVjdF9yOmxvZ2luX2V4ZWNfdDpzMDwvYj48L2Rpdj48ZGl2Pjxi
Pi9iaW4vc2jCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbV91Om9i
amVjdF9yOmJpbl90OnMwIC0mZ3Q7IHN5c3RlbV91Om9iamVjdF9yOnNoZWxsX2V4ZWNfdDpzMDwv
Yj48L2Rpdj48ZGl2PjxiPi9zYmluL2FnZXR0ecKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHN5c3RlbV91Om9iamVjdF9yOmdldHR5X2V4ZWNfdDpzMDwvYj48L2Rpdj48ZGl2PjxiPi9zYmlu
L2luaXTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpvYmplY3Rfcjpi
aW5fdDpzMCAtJmd0OyBzeXN0ZW1fdTpvYmplY3Rfcjppbml0X2V4ZWNfdDpzMDwvYj48L2Rpdj48
ZGl2PjxiPi91c3Ivc2Jpbi9zc2hkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzdGVtX3U6
b2JqZWN0X3I6c3NoZF9leGVjX3Q6czA8L2I+PC9kaXY+PGRpdj48Yj4vbGliL2xpYmMuc28uNsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwIC0mZ3Q7
IHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwPC9iPjwvZGl2PjxkaXY+PGI+L2xpYi9sZC1saW51
eC5zby4ywqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzdGVtX3U6b2JqZWN0X3I6bGliX3Q6czAgLSZn
dDsgc3lzdGVtX3U6b2JqZWN0X3I6bGRfc29fdDpzMDwvYj48L2Rpdj48L2Rpdj48ZGl2PjxiPjxi
cj48L2I+PC9kaXY+PGRpdj48Yj5BbHNvIEkgYW0gdXNpbmcgc3NoIHNlc3Npb24gZm9yIGxvZ2lu
LjwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5QbGVhc2UgbGV0IG1lIGtu
b3cgaG93IHRvIGNoYW5nZSBpZCBjb21tYW5kIGNvbnRleHQgdG8gdW5jb25maW5lZF91IG9yIFN5
c2FkbV91LjwvYj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyBpbiBhZHZhbmNlPC9k
aXY+PGRpdj5BbWFuPC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gTW9uLCBOb3YgMjcsIDIwMTcgYXQgOToyOSBQTSwgU3Rl
cGhlbiBTbWFsbGV5IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNo
by5uc2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0Ozwvc3Bh
bj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPk9uIEZyaSwgMjAxNy0xMS0yNCBh
dCAxMDo0NyArMDUzMCwgQW1hbiBTaGFybWEgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZndDs8YnI+
DQomZ3Q7IEhpIEFsbCw8YnI+DQomZ3Q7PGJyPg0KJmd0OyBDdXJyZW50bHkgV29ya2luZyBvbiBD
ZW50IE9TIDcuMyBhbmQgbG9naW4gYXMgYSByb290IFVzZXIgYW5kIG15IElkPGJyPg0KJmd0OyBj
b21tYW5kIG91dHB1dCBpcyA6PGJyPg0KJmd0Ozxicj4NCiZndDsgaWQ8YnI+DQomZ3Q7IHVpZD0w
KHJvb3QpIGdpZD0wKHJvb3QpIGdyb3Vwcz0wKHJvb3QpPGJyPg0KJmd0OyBjb250ZXh0PXN5c3Rl
bV91OnN5c3RlbV9yOjx3YnI+dW5jb25maW5lZF90OnMwLXMwOmMwLmMxMDIzPGJyPg0KJmd0Ozxi
cj4NCiZndDsgSSB3YW50IHRvIGNoYW5nZSBTeXN0ZW1fdTpzeXN0ZW1fcjp1bmNvbmZpbmVkX3Qg
dG8gc3lzYWRtX3U6c3lzYWRtX3I8YnI+DQomZ3Q7IG9ywqB1bmNvbmZpbmVkX3U6dW5jb25maW5l
ZF9yLsKgPGJyPg0KJmd0Ozxicj4NCiZndDsgQWxzbyBzaG93aW5nIHRoZSBvdXRwdXQgb2YgZm9s
bG93aW5nIGNvbW1hbmQgOjxicj4NCiZndDs8YnI+DQomZ3Q7IHNlbWFuYWdlIHVzZXIgLWw8YnI+
DQomZ3Q7PGJyPg0KJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMYWJlbGluZ8KgIMKgTUxT
L8KgIMKgIMKgIMKgTUxTL8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8
YnI+DQomZ3Q7IFNFTGludXggVXNlcsKgIMKgIFByZWZpeMKgIMKgIMKgTUNTIExldmVswqAgTUNT
IFJhbmdlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IFNFTGludXgg
Um9sZXM8YnI+DQomZ3Q7PGJyPg0KJmd0OyBhZG1pbl91wqAgwqAgwqAgwqAgwqB1c2VywqAgwqAg
wqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiZndDsgwqBzeXNhZG1fciBzeXN0ZW1fcjxicj4NCiZndDsgZ3Vlc3RfdcKgIMKgIMKg
IMKgIMKgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IMKgZ3Vlc3Rfcjxicj4NCiZndDsgcm9v
dMKgIMKgIMKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpj
MC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyDCoHN0YWZmX3Igc3lzYWRt
X3I8YnI+DQomZ3Q7IHNwZWNpYWx1c2VyX3XCoCDCoHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAg
wqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyDCoHN5c2FkbV9yIHN5c3RlbV9yPGJyPg0KJmd0OyBzdGFmZl91wqAgwqAgwqAgwqAgwqB1c2Vy
wqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDsgwqBzdGFmZl9yIHN5c2FkbV9yIHN5c3RlbV9yPGJyPg0KJmd0OyBz
eXNhZG1fdcKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpj
MC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyDCoHN5c2FkbV9yPGJyPg0K
Jmd0OyBzeXN0ZW1fdcKgIMKgIMKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBz
MC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyDCoHN5c3RlbV9y
PGJyPg0KJmd0OyB1bmNvbmZpbmVkX3XCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKg
IMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqBzeXN0
ZW1fciB1bmNvbmZpbmVkX3I8YnI+DQomZ3Q7IHVzZXJfdcKgIMKgIMKgIMKgIMKgIHVzZXLCoCDC
oCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0OyDCoHVzZXJfcjxicj4NCiZndDsgeGd1ZXN0X3XCoCDCoCDCoCDC
oCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqB4Z3Vlc3Rfcjxicj4NCiZndDs8YnI+DQom
Z3Q7PGJyPg0KJmd0OyDCoHNlbWFuYWdlIGxvZ2luIC1sPGJyPg0KJmd0Ozxicj4NCiZndDsgTG9n
aW4gTmFtZcKgIMKgIMKgIMKgIMKgIMKgU0VMaW51eCBVc2VywqAgwqAgwqAgwqAgwqBNTFMvTUNT
IFJhbmdlwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IFNlcnZpY2U8YnI+DQomZ3Q7PGJyPg0KJmd0OyBf
X2RlZmF1bHRfX8KgIMKgIMKgIMKgIMKgIHN5c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1z
MDpjMC5jMTAyM8KgIMKgIMKgIMKgKjxicj4NCiZndDsgY2Ntc2VydmljZcKgIMKgIMKgIMKgIMKg
IMKgc3BlY2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAqPGJyPg0KJmd0OyBjdWNtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhZG1pbl91wqAgwqAg
wqAgwqAgwqAgwqAgwqAgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCo8YnI+DQomZ3Q7IGRyZmtl
eXPCoCDCoCDCoCDCoCDCoCDCoCDCoCBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCo8YnI+DQomZ3Q7IGRyZnVzZXLCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCo8YnI+DQomZ3Q7IGluZm9ybWl4wqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVjaWFsdXNlcl91
wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCo8YnI+DQomZ3Q7IHB3
cmVjb3ZlcnnCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjxicj4NCiZndDsgcm9vdMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3lzYWRtX3XCoCDCoCDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAg
wqAgwqAqPGJyPg0KJmd0OyBzZnRwdXNlcsKgIMKgIMKgIMKgIMKgIMKgIMKgc3BlY2lhbHVzZXJf
dcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPGJyPg0KJmd0OyBz
eXN0ZW1fdcKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzYWRtX3XCoCDCoCDCoCDCoCDCoCDCoCDCoHMw
LXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAqPGJyPg0KJmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7IENh
biBhbnlib2R5IFBsZWFzZSBoZWxwIG1lLjxicj4NCjxicj4NCjwvZGl2PjwvZGl2PldoYXQgaXMg
eW91ciBzZXN0YXR1cyAtdiBvdXRwdXQ/wqAgSG93IGFyZSB5b3UgbG9nZ2luZyBpbiAoY29uc29s
ZSwgZ2RtLDxicj4NCnNzaCwgLi4uKT88YnI+DQo8YnI+DQpZb3UgZG9uJiMzOTt0IGFwcGVhciB0
byBiZSBydW5uaW5nIHRoZSBkZWZhdWx0IHBvbGljeSwgb3IgaWYgeW91IGFyZSw8YnI+DQpzb21l
b25lIGhhcyBoZWF2aWx5IGN1c3RvbWl6ZWQgeW91ciB1c2VyIGFuZCBsb2dpbiBtYXBwaW5ncy48
YnI+DQo8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxsIj48
ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIiBkYXRhLXNt
YXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlRoYW5rczwvZGl2PjxkaXY+QW1hbjwvZGl2PjxkaXY+Q2VsbDogKzkxIDk5OTAyOTY0MDQg
fCDCoEVtYWlsIElEIDogPGEgaHJlZj0ibWFpbHRvOmFtYW5zaC5zaGFybWE1QGdtYWlsLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPmFtYW5zaC5zaGFybWE1QGdtYWlsLmNvbTwvYT48L2Rpdj48L2Rpdj48
L2Rpdj4NCjwvZGl2Pg0K
--001a113dbf6afcf1a7055f173761--
