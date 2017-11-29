MIME-Version: 1.0
In-Reply-To: <1511966833.10464.7.camel@tycho.nsa.gov>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 20:47:19 +0530
Message-ID: <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a1140eeeaba3c88055f20a1c8"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140eeeaba3c88055f20a1c8
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

I tried all the three command i.e.
semanage export > localchanges

semanage login -D
semanage user -D

Then I reboot the system and after reboot , still its showing the root User
as Same id context i.e.

*id*
*uid=0(root) gid=0(root) groups=0(root)
context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*

* id -Z*
*system_u:system_r:unconfined_t:s0-s0:c0.c1023*


Also check the below output :
*semanage user -l*

*                Labeling   MLS/       MLS/                          *
*SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles*

*guest_u         user       s0         s0
 guest_r*
*root            user       s0         s0-s0:c0.c1023
 staff_r sysadm_r system_r unconfined_r*
*staff_u         user       s0         s0-s0:c0.c1023
 staff_r sysadm_r system_r unconfined_r*
*sysadm_u        user       s0         s0-s0:c0.c1023
 sysadm_r*
*system_u        user       s0         s0-s0:c0.c1023
 system_r unconfined_r*
*unconfined_u    user       s0         s0-s0:c0.c1023
 system_r unconfined_r*
*user_u          user       s0         s0
 user_r*
*xguest_u        user       s0         s0
 xguest_r*
*[root@cucm ~]# semanage login -l*

*Login Name           SELinux User         MLS/MCS Range        Service*

*__default__          unconfined_u         s0-s0:c0.c1023       **
*root                 unconfined_u         s0-s0:c0.c1023       **
*system_u             system_u             s0-s0:c0.c1023       **

*Please let me know your comments on this.*

*Thanks*
*Aman*

On Wed, Nov 29, 2017 at 8:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 20:11 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > Thanks for the reply.
> >
> > Can you please let me know how to delete all local customizations
> > (via semanage or manually) and revert
> > to a default policy.
>
> First, save any local customizations in case you want to restore them
> later:
> semanage export > localchanges
>
> Then, delete them:
> semanage login -D
> semanage user -D
>
> Then logout and log back in.
>
> >
> > Otherwise the output of semanage login -l and semanage user -l  :
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
> > Please let me know if any comments are there.
> >
> > Thanks
> > Aman
> >
> > On Wed, Nov 29, 2017 at 7:21 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:
> > > > Hi Stephen,
> > > >
> > > > Below is the output of command :
> > > >
> > > >  sestatus -v output
> > > > SELinux status:                 enabled
> > > > SELinuxfs mount:                /sys/fs/selinux
> > > > SELinux root directory:         /etc/selinux
> > > > Loaded policy name:             targeted
> > > > Current mode:                   enforcing
> > > > Mode from config file:          permissive
> > > > Policy MLS status:              enabled
> > > > Policy deny_unknown status:     allowed
> > > > Max kernel policy version:      28
> > > >
> > > > Process contexts:
> > > > Current context:
> > > system_u:system_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > Init context:                   system_u:system_r:init_t:s0
> > > > /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> > > > s0:c0.c1023
> > > >
> > > > File contexts:
> > > > Controlling terminal:
> > >  system_u:object_r:sshd_devpts_t:s0
> > > > /etc/passwd
> > >  system_u:object_r:passwd_file_t:s0
> > > > /etc/shadow                     system_u:object_r:shadow_t:s0
> > > > /bin/bash                       system_u:object_r:shell_exec_t:s0
> > > > /bin/login                      system_u:object_r:login_exec_t:s0
> > > > /bin/sh                         system_u:object_r:bin_t:s0 ->
> > > > system_u:object_r:shell_exec_t:s0
> > > > /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> > > > /sbin/init                      system_u:object_r:bin_t:s0 ->
> > > > system_u:object_r:init_exec_t:s0
> > > > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> > > > /lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > > > system_u:object_r:lib_t:s0
> > > > /lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > > > system_u:object_r:ld_so_t:s0
> > > >
> > > > Also I am using ssh session for login.
> > > >
> > > > Please let me know how to change id command context to
> > > unconfined_u
> > > > or Sysadm_u.
> > >
> > > So from your earlier message, it is clear that you (or someone
> > > else)
> > > has heavily customized your semanage login and user mappings from
> > > the
> > > stock targeted policy.  The question is why, and whether you
> > > want/need
> > > to retain any of those customizations.  If not, then you could just
> > > delete all local customizations (via semanage or manually) and
> > > revert
> > > to a stock policy.
> > >
> > > If you do need to retain some of those customizations, then please
> > > show
> > > your current semanage login -l and semanage user -l output since
> > > you
> > > said you ran some further semanage commands after the last output
> > > you
> > > showed.
> > >
> > >
> >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a1140eeeaba3c88055f20a1c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgU3RlcGhlbiw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdHJpZWQgYWxs
IHRoZSB0aHJlZSBjb21tYW5kIGkuZS48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTIuOHB4Ij5zZW1hbmFnZSBleHBvcnQgJmd0OyBsb2NhbGNoYW5nZXM8L3NwYW4+PGJyIHN0eWxl
PSJmb250LXNpemU6MTIuOHB4Ij48YnIgc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTIuOHB4Ij5zZW1hbmFnZSBsb2dpbiAtRDwvc3Bhbj48YnIgc3R5bGU9
ImZvbnQtc2l6ZToxMi44cHgiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuOHB4Ij5zZW1hbmFn
ZSB1c2VyIC1EPC9zcGFuPjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZW4gSSByZWJv
b3QgdGhlIHN5c3RlbSBhbmQgYWZ0ZXIgcmVib290ICwgc3RpbGwgaXRzIHNob3dpbmcgdGhlIHJv
b3QgVXNlciBhcyBTYW1lIGlkIGNvbnRleHQgaS5lLsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48ZGl2PjxiPmlkPC9iPjwvZGl2PjxkaXY+PGI+dWlkPTAocm9vdCkgZ2lkPTAocm9vdCkgZ3Jv
dXBzPTAocm9vdCkgY29udGV4dD1zeXN0ZW1fdTpzeXN0ZW1fcjp1bmNvbmZpbmVkX3Q6czAtczA6
YzAuYzEwMjM8L2I+PC9kaXY+PC9kaXY+PGRpdj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGRpdj48
Yj7CoGlkIC1aPC9iPjwvZGl2PjxkaXY+PGI+c3lzdGVtX3U6c3lzdGVtX3I6dW5jb25maW5lZF90
OnMwLXMwOmMwLmMxMDIzPC9iPjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+QWxzbyBjaGVjayB0aGUgYmVsb3cgb3V0cHV0IDo8L2Rpdj48ZGl2PjxkaXY+PGI+
c2VtYW5hZ2UgdXNlciAtbDwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMYWJlbGluZ8KgIMKgTUxTL8KgIMKgIMKgIMKgTUxTL8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8L2I+PC9kaXY+PGRpdj48Yj5T
RUxpbnV4IFVzZXLCoCDCoCBQcmVmaXjCoCDCoCDCoE1DUyBMZXZlbMKgIE1DUyBSYW5nZcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNFTGludXggUm9sZXM8L2I+PC9kaXY+PGRpdj48
Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGI+Z3Vlc3RfdcKgIMKgIMKgIMKgIMKgdXNlcsKgIMKgIMKg
IMKgczDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBndWVzdF9yPC9iPjwvZGl2PjxkaXY+PGI+cm9vdMKgIMKgIMKgIMKgIMKgIMKgIHVz
ZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RhZmZfciBzeXNhZG1fciBzeXN0ZW1fciB1bmNvbmZpbmVkX3I8L2I+PC9k
aXY+PGRpdj48Yj5zdGFmZl91wqAgwqAgwqAgwqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKg
IMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YWZmX3Igc3lz
YWRtX3Igc3lzdGVtX3IgdW5jb25maW5lZF9yPC9iPjwvZGl2PjxkaXY+PGI+c3lzYWRtX3XCoCDC
oCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV9yPC9iPjwvZGl2PjxkaXY+PGI+c3lzdGVtX3XC
oCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbV9yIHVuY29uZmluZWRfcjwvYj48L2Rpdj48
ZGl2PjxiPnVuY29uZmluZWRfdcKgIMKgIHVzZXLCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBz
MC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzdGVtX3IgdW5jb25maW5l
ZF9yPC9iPjwvZGl2PjxkaXY+PGI+dXNlcl91wqAgwqAgwqAgwqAgwqAgdXNlcsKgIMKgIMKgIMKg
czDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB1c2VyX3I8L2I+PC9kaXY+PGRpdj48Yj54Z3Vlc3RfdcKgIMKgIMKgIMKgIHVzZXLCoCDC
oCDCoCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgeGd1ZXN0X3I8L2I+PC9kaXY+PGRpdj48Yj5bcm9vdEBjdWNtIH5dIyBzZW1h
bmFnZSBsb2dpbiAtbDwvYj48L2Rpdj48ZGl2PjxiPjxicj48L2I+PC9kaXY+PGRpdj48Yj5Mb2dp
biBOYW1lwqAgwqAgwqAgwqAgwqAgwqBTRUxpbnV4IFVzZXLCoCDCoCDCoCDCoCDCoE1MUy9NQ1Mg
UmFuZ2XCoCDCoCDCoCDCoCBTZXJ2aWNlPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48
ZGl2PjxiPl9fZGVmYXVsdF9fwqAgwqAgwqAgwqAgwqAgdW5jb25maW5lZF91wqAgwqAgwqAgwqAg
wqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjwvYj48L2Rpdj48ZGl2PjxiPnJvb3TCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHVuY29uZmluZWRfdcKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEw
MjPCoCDCoCDCoCDCoCo8L2I+PC9kaXY+PGRpdj48Yj5zeXN0ZW1fdcKgIMKgIMKgIMKgIMKgIMKg
IMKgc3lzdGVtX3XCoCDCoCDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAq
PC9iPjwvZGl2PjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48L2Rpdj48ZGl2PjxiPlBsZWFzZSBsZXQg
bWUga25vdyB5b3VyIGNvbW1lbnRzIG9uIHRoaXMuPC9iPjwvZGl2PjxkaXY+PGI+PGJyPjwvYj48
L2Rpdj48ZGl2PjxiPlRoYW5rczwvYj48L2Rpdj48ZGl2PjxiPkFtYW48L2I+PC9kaXY+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24g
V2VkLCBOb3YgMjksIDIwMTcgYXQgODoxNyBQTSwgU3RlcGhlbiBTbWFsbGV5IDxzcGFuIGRpcj0i
bHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292IiB0YXJnZXQ9Il9ibGFu
ayI+c2RzQHR5Y2hvLm5zYS5nb3Y8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxzcGFuIGNsYXNzPSIiPk9uIFdlZCwg
MjAxNy0xMS0yOSBhdCAyMDoxMSArMDUzMCwgQW1hbiBTaGFybWEgd3JvdGU6PGJyPg0KJmd0OyBI
aSBTdGVwaGVuLDxicj4NCiZndDs8YnI+DQo8L3NwYW4+PHNwYW4gY2xhc3M9IiI+Jmd0OyBUaGFu
a3MgZm9yIHRoZSByZXBseS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBDYW4geW91IHBsZWFzZSBsZXQg
bWUga25vdyBob3cgdG8gZGVsZXRlIGFsbCBsb2NhbMKgY3VzdG9taXphdGlvbnM8YnI+DQomZ3Q7
ICh2aWEgc2VtYW5hZ2Ugb3IgbWFudWFsbHkpIGFuZCByZXZlcnQ8YnI+DQomZ3Q7IHRvIGEgZGVm
YXVsdCBwb2xpY3kuwqA8YnI+DQo8YnI+DQo8L3NwYW4+Rmlyc3QsIHNhdmUgYW55IGxvY2FsIGN1
c3RvbWl6YXRpb25zIGluIGNhc2UgeW91IHdhbnQgdG8gcmVzdG9yZSB0aGVtPGJyPg0KbGF0ZXI6
PGJyPg0Kc2VtYW5hZ2UgZXhwb3J0ICZndDsgbG9jYWxjaGFuZ2VzPGJyPg0KPGJyPg0KVGhlbiwg
ZGVsZXRlIHRoZW06PGJyPg0Kc2VtYW5hZ2UgbG9naW4gLUQ8YnI+DQpzZW1hbmFnZSB1c2VyIC1E
PGJyPg0KPGJyPg0KVGhlbiBsb2dvdXQgYW5kIGxvZyBiYWNrIGluLjxicj4NCjxkaXYgY2xhc3M9
IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4NCiZndDs8YnI+DQomZ3Q7IE90aGVyd2lzZSB0
aGUgb3V0cHV0IG9mwqBzZW1hbmFnZSBsb2dpbiAtbCBhbmQgc2VtYW5hZ2UgdXNlciAtbMKgIDo8
YnI+DQomZ3Q7PGJyPg0KJmd0OyBzZW1hbmFnZSB1c2VyIC1sPGJyPg0KJmd0Ozxicj4NCiZndDsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTGFiZWxpbmfCoCDCoE1MUy/CoCDCoCDCoCDCoE1MUy/C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPGJyPg0KJmd0OyBTRUxpbnV4
IFVzZXLCoCDCoCBQcmVmaXjCoCDCoCDCoE1DUyBMZXZlbMKgIE1DUyBSYW5nZcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyBTRUxpbnV4IFJvbGVzPGJyPg0KJmd0Ozxi
cj4NCiZndDsgYWRtaW5fdcKgIMKgIMKgIMKgIMKgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDC
oCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IMKgc3lz
YWRtX3Igc3lzdGVtX3I8YnI+DQomZ3Q7IGd1ZXN0X3XCoCDCoCDCoCDCoCDCoHVzZXLCoCDCoCDC
oCDCoHMwwqAgwqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyDCoGd1ZXN0X3I8YnI+DQomZ3Q7IHJvb3TCoCDCoCDCoCDCoCDCoCDC
oCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqBzdGFmZl9yIHN5c2FkbV9yPGJyPg0KJmd0OyBzcGVj
aWFsdXNlcl91wqAgwqB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqBzeXNhZG1fciBzeXN0
ZW1fcjxicj4NCiZndDsgc3RhZmZfdcKgIMKgIMKgIMKgIMKgdXNlcsKgIMKgIMKgIMKgczDCoCDC
oCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
IMKgc3RhZmZfciBzeXNhZG1fciBzeXN0ZW1fcjxicj4NCiZndDsgc3lzYWRtX3XCoCDCoCDCoCDC
oCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqBzeXNhZG1fcjxicj4NCiZndDsgc3lzdGVtX3XCoCDC
oCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsgwqBzeXN0ZW1fcjxicj4NCiZndDsgdW5jb25m
aW5lZF91wqAgwqAgdXNlcsKgIMKgIMKgIMKgczDCoCDCoCDCoCDCoCDCoHMwLXMwOmMwLmMxMDIz
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IMKgc3lzdGVtX3IgdW5jb25maW5lZF9y
PGJyPg0KJmd0OyB1c2VyX3XCoCDCoCDCoCDCoCDCoCB1c2VywqAgwqAgwqAgwqBzMMKgIMKgIMKg
IMKgIMKgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDsgwqB1c2VyX3I8YnI+DQomZ3Q7IHhndWVzdF91wqAgwqAgwqAgwqAgdXNlcsKgIMKgIMKgIMKg
czDCoCDCoCDCoCDCoCDCoHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+DQomZ3Q7IMKgeGd1ZXN0X3I8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDsgwqBz
ZW1hbmFnZSBsb2dpbiAtbDxicj4NCiZndDs8YnI+DQomZ3Q7IExvZ2luIE5hbWXCoCDCoCDCoCDC
oCDCoCDCoFNFTGludXggVXNlcsKgIMKgIMKgIMKgIMKgTUxTL01DUyBSYW5nZcKgIMKgIMKgIMKg
PGJyPg0KJmd0OyBTZXJ2aWNlPGJyPg0KJmd0Ozxicj4NCiZndDsgX19kZWZhdWx0X1/CoCDCoCDC
oCDCoCDCoCBzeXNhZG1fdcKgIMKgIMKgIMKgIMKgIMKgIMKgczAtczA6YzAuYzEwMjPCoCDCoCDC
oCDCoCo8YnI+DQomZ3Q7IGNjbXNlcnZpY2XCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XC
oCDCoCDCoCDCoCBzMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjxicj4NCiZndDsgY3Vj
bcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWRtaW5fdcKgIMKgIMKgIMKgIMKgIMKgIMKgIHMw
LXMwOmMwLmMxMDIzwqAgwqAgwqAgwqAqPGJyPg0KJmd0OyBkcmZrZXlzwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3BlY2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAqPGJyPg0KJmd0OyBkcmZ1c2VywqAgwqAgwqAgwqAgwqAgwqAgwqAgc3BlY2lhbHVzZXJf
dcKgIMKgIMKgIMKgIHMwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPGJyPg0KJmd0OyBp
bmZvcm1peMKgIMKgIMKgIMKgIMKgIMKgIMKgc3BlY2lhbHVzZXJfdcKgIMKgIMKgIMKgIHMwwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqPGJyPg0KJmd0OyBwd3JlY292ZXJ5wqAgwqAgwqAg
wqAgwqAgwqBzcGVjaWFsdXNlcl91wqAgwqAgwqAgwqAgczDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCo8YnI+DQomZ3Q7IHJvb3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c2FkbV91
wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKgIMKgIMKgKjxicj4NCiZndDsg
c2Z0cHVzZXLCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNpYWx1c2VyX3XCoCDCoCDCoCDCoCBzMMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKjxicj4NCiZndDsgc3lzdGVtX3XCoCDCoCDCoCDC
oCDCoCDCoCDCoHN5c2FkbV91wqAgwqAgwqAgwqAgwqAgwqAgwqBzMC1zMDpjMC5jMTAyM8KgIMKg
IMKgIMKgKjxicj4NCiZndDs8YnI+DQomZ3Q7IFBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgY29t
bWVudHMgYXJlIHRoZXJlLjxicj4NCiZndDs8YnI+DQomZ3Q7IFRoYW5rczxicj4NCiZndDsgQW1h
bjxicj4NCiZndDs8YnI+DQomZ3Q7IE9uIFdlZCwgTm92IDI5LCAyMDE3IGF0IDc6MjEgUE0sIFN0
ZXBoZW4gU21hbGxleSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnNkc0B0eWNoby5uc2EuZ292Ij5zZHNA
dHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJyPg0KJmd0OyB3cm90ZTo8YnI+DQomZ3Q7ICZndDsgT24g
V2VkLCAyMDE3LTExLTI5IGF0IDA5OjMzICswNTMwLCBBbWFuIFNoYXJtYSB3cm90ZTo8YnI+DQom
Z3Q7ICZndDsgJmd0OyBIaSBTdGVwaGVuLDxicj4NCiZndDsgJmd0OyAmZ3Q7PGJyPg0KJmd0OyAm
Z3Q7ICZndDsgQmVsb3cgaXMgdGhlIG91dHB1dCBvZiBjb21tYW5kIDo8YnI+DQomZ3Q7ICZndDsg
Jmd0Ozxicj4NCiZndDsgJmd0OyAmZ3Q7IMKgc2VzdGF0dXMgLXYgb3V0cHV0PGJyPg0KJmd0OyAm
Z3Q7ICZndDsgU0VMaW51eCBzdGF0dXM6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGVk
PGJyPg0KJmd0OyAmZ3Q7ICZndDsgU0VMaW51eGZzIG1vdW50OsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC9zeXMvZnMvc2VsaW51eDxicj4NCiZndDsgJmd0OyAmZ3Q7IFNFTGludXggcm9vdCBkaXJl
Y3Rvcnk6wqAgwqAgwqAgwqAgwqAvZXRjL3NlbGludXg8YnI+DQomZ3Q7ICZndDsgJmd0OyBMb2Fk
ZWQgcG9saWN5IG5hbWU6wqAgwqAgwqAgwqAgwqAgwqAgwqB0YXJnZXRlZDxicj4NCiZndDsgJmd0
OyAmZ3Q7IEN1cnJlbnQgbW9kZTrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuZm9yY2lu
Zzxicj4NCiZndDsgJmd0OyAmZ3Q7IE1vZGUgZnJvbSBjb25maWcgZmlsZTrCoCDCoCDCoCDCoCDC
oCBwZXJtaXNzaXZlPGJyPg0KJmd0OyAmZ3Q7ICZndDsgUG9saWN5IE1MUyBzdGF0dXM6wqAgwqAg
wqAgwqAgwqAgwqAgwqAgZW5hYmxlZDxicj4NCiZndDsgJmd0OyAmZ3Q7IFBvbGljeSBkZW55X3Vu
a25vd24gc3RhdHVzOsKgIMKgIMKgYWxsb3dlZDxicj4NCiZndDsgJmd0OyAmZ3Q7IE1heCBrZXJu
ZWwgcG9saWN5IHZlcnNpb246wqAgwqAgwqAgMjg8YnI+DQomZ3Q7ICZndDsgJmd0Ozxicj4NCiZn
dDsgJmd0OyAmZ3Q7IFByb2Nlc3MgY29udGV4dHM6PGJyPg0KJmd0OyAmZ3Q7ICZndDsgQ3VycmVu
dCBjb250ZXh0OsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyAmZ3Q7IHN5c3RlbV91
OnN5c3RlbV9yOnVuY29uZmluZWRfPHdicj50OnMwLTxicj4NCiZndDsgJmd0OyAmZ3Q7IHMwOmMw
LmMxMDIzPGJyPg0KJmd0OyAmZ3Q7ICZndDsgSW5pdCBjb250ZXh0OsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3lzdGVtX3U6c3lzdGVtX3I6aW5pdF90OnMwPGJyPg0KJmd0OyAmZ3Q7ICZn
dDsgL3Vzci9zYmluL3NzaGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpzeXN0
ZW1fcjpzc2hkX3Q6czAtPGJyPg0KJmd0OyAmZ3Q7ICZndDsgczA6YzAuYzEwMjM8YnI+DQomZ3Q7
ICZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAmZ3Q7IEZpbGUgY29udGV4dHM6PGJyPg0KJmd0OyAm
Z3Q7ICZndDsgQ29udHJvbGxpbmcgdGVybWluYWw6wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7ICZn
dDsgwqBzeXN0ZW1fdTpvYmplY3Rfcjpzc2hkXzx3YnI+ZGV2cHRzX3Q6czA8YnI+DQomZ3Q7ICZn
dDsgJmd0OyAvZXRjL3Bhc3N3ZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyAmZ3Q7IMKgc3lzdGVtX3U6b2JqZWN0X3I6cGFzc3dkXzx3YnI+ZmlsZV90OnMwPGJyPg0KJmd0
OyAmZ3Q7ICZndDsgL2V0Yy9zaGFkb3fCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5
c3RlbV91Om9iamVjdF9yOnNoYWRvd190OnMwPGJyPg0KJmd0OyAmZ3Q7ICZndDsgL2Jpbi9iYXNo
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXN0ZW1fdTpvYmplY3RfcjpzaGVs
bF9leGVjXzx3YnI+dDpzMDxicj4NCiZndDsgJmd0OyAmZ3Q7IC9iaW4vbG9naW7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpvYmplY3Rfcjpsb2dpbl9leGVjXzx3YnI+
dDpzMDxicj4NCiZndDsgJmd0OyAmZ3Q7IC9iaW4vc2jCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN5c3RlbV91Om9iamVjdF9yOmJpbl90OnMwIC0mZ3Q7PGJyPg0KJmd0OyAm
Z3Q7ICZndDsgc3lzdGVtX3U6b2JqZWN0X3I6c2hlbGxfZXhlY188d2JyPnQ6czA8YnI+DQomZ3Q7
ICZndDsgJmd0OyAvc2Jpbi9hZ2V0dHnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0
ZW1fdTpvYmplY3RfcjpnZXR0eV9leGVjXzx3YnI+dDpzMDxicj4NCiZndDsgJmd0OyAmZ3Q7IC9z
YmluL2luaXTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpvYmplY3Rf
cjpiaW5fdDpzMCAtJmd0Ozxicj4NCiZndDsgJmd0OyAmZ3Q7IHN5c3RlbV91Om9iamVjdF9yOmlu
aXRfZXhlY190Ojx3YnI+czA8YnI+DQomZ3Q7ICZndDsgJmd0OyAvdXNyL3NiaW4vc3NoZMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c3RlbV91Om9iamVjdF9yOnNzaGRfZXhlY190Ojx3YnI+
czA8YnI+DQomZ3Q7ICZndDsgJmd0OyAvbGliL2xpYmMuc28uNsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwIC0mZ3Q7PGJyPg0KJmd0OyAmZ3Q7ICZn
dDsgc3lzdGVtX3U6b2JqZWN0X3I6bGliX3Q6czA8YnI+DQomZ3Q7ICZndDsgJmd0OyAvbGliL2xk
LWxpbnV4LnNvLjLCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW1fdTpvYmplY3RfcjpsaWJfdDpz
MCAtJmd0Ozxicj4NCiZndDsgJmd0OyAmZ3Q7IHN5c3RlbV91Om9iamVjdF9yOmxkX3NvX3Q6czA8
YnI+DQomZ3Q7ICZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyAmZ3Q7IEFsc28gSSBhbSB1c2luZyBz
c2ggc2Vzc2lvbiBmb3IgbG9naW4uPGJyPg0KJmd0OyAmZ3Q7ICZndDs8YnI+DQomZ3Q7ICZndDsg
Jmd0OyBQbGVhc2UgbGV0IG1lIGtub3cgaG93IHRvIGNoYW5nZSBpZCBjb21tYW5kIGNvbnRleHQg
dG88YnI+DQomZ3Q7ICZndDsgdW5jb25maW5lZF91PGJyPg0KJmd0OyAmZ3Q7ICZndDsgb3IgU3lz
YWRtX3UuPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IFNvIGZyb20geW91ciBlYXJsaWVy
IG1lc3NhZ2UsIGl0IGlzIGNsZWFyIHRoYXQgeW91IChvciBzb21lb25lPGJyPg0KJmd0OyAmZ3Q7
IGVsc2UpPGJyPg0KJmd0OyAmZ3Q7IGhhcyBoZWF2aWx5IGN1c3RvbWl6ZWQgeW91ciBzZW1hbmFn
ZSBsb2dpbiBhbmQgdXNlciBtYXBwaW5ncyBmcm9tPGJyPg0KJmd0OyAmZ3Q7IHRoZTxicj4NCiZn
dDsgJmd0OyBzdG9jayB0YXJnZXRlZCBwb2xpY3kuwqAgVGhlIHF1ZXN0aW9uIGlzIHdoeSwgYW5k
IHdoZXRoZXIgeW91PGJyPg0KJmd0OyAmZ3Q7IHdhbnQvbmVlZDxicj4NCiZndDsgJmd0OyB0byBy
ZXRhaW4gYW55IG9mIHRob3NlIGN1c3RvbWl6YXRpb25zLsKgIElmIG5vdCwgdGhlbiB5b3UgY291
bGQganVzdDxicj4NCiZndDsgJmd0OyBkZWxldGUgYWxsIGxvY2FsIGN1c3RvbWl6YXRpb25zICh2
aWEgc2VtYW5hZ2Ugb3IgbWFudWFsbHkpIGFuZDxicj4NCiZndDsgJmd0OyByZXZlcnQ8YnI+DQom
Z3Q7ICZndDsgdG8gYSBzdG9jayBwb2xpY3kuPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7
IElmIHlvdSBkbyBuZWVkIHRvIHJldGFpbiBzb21lIG9mIHRob3NlIGN1c3RvbWl6YXRpb25zLCB0
aGVuIHBsZWFzZTxicj4NCiZndDsgJmd0OyBzaG93PGJyPg0KJmd0OyAmZ3Q7IHlvdXIgY3VycmVu
dCBzZW1hbmFnZSBsb2dpbiAtbCBhbmQgc2VtYW5hZ2UgdXNlciAtbCBvdXRwdXQgc2luY2U8YnI+
DQomZ3Q7ICZndDsgeW91PGJyPg0KJmd0OyAmZ3Q7IHNhaWQgeW91IHJhbiBzb21lIGZ1cnRoZXIg
c2VtYW5hZ2UgY29tbWFuZHMgYWZ0ZXIgdGhlIGxhc3Qgb3V0cHV0PGJyPg0KJmd0OyAmZ3Q7IHlv
dTxicj4NCiZndDsgJmd0OyBzaG93ZWQuPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7PGJy
Pg0KJmd0Ozxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyAtLcKgPGJyPg0KJmd0Ozxicj4N
CiZndDsgVGhhbmtzPGJyPg0KJmd0OyBBbWFuPGJyPg0KJmd0OyBDZWxsOiArOTEgOTk5MDI5NjQw
NCB8IMKgRW1haWwgSUQgOiA8YSBocmVmPSJtYWlsdG86YW1hbnNoLnNoYXJtYTVAZ21haWwuY29t
Ij5hbWFuc2guc2hhcm1hNUBnbWFpbC5jb208L2E+PGJyPg0KPC9kaXY+PC9kaXY+PC9ibG9ja3F1
b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+
PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3M8L2Rpdj48ZGl2PkFtYW48
L2Rpdj48ZGl2PkNlbGw6ICs5MSA5OTkwMjk2NDA0IHwgwqBFbWFpbCBJRCA6IDxhIGhyZWY9Im1h
aWx0bzphbWFuc2guc2hhcm1hNUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hbWFuc2guc2hh
cm1hNUBnbWFpbC5jb208L2E+PC9kaXY+PC9kaXY+PC9kaXY+DQo8L2Rpdj4NCg==
--001a1140eeeaba3c88055f20a1c8--
