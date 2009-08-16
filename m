Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7GIrooH029861
	for <selinux@tycho.nsa.gov>; Sun, 16 Aug 2009 14:53:50 -0400
Received: from mail-fx0-f207.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7GIrJ3k027905
	for <selinux@tycho.nsa.gov>; Sun, 16 Aug 2009 18:53:19 GMT
Received: by fxm3 with SMTP id 3so2005478fxm.32
        for <selinux@tycho.nsa.gov>; Sun, 16 Aug 2009 11:53:48 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 16 Aug 2009 11:53:48 -0700
Message-ID: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
Subject: checking user status
From: Larry Ross <selinux.larry@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c5c1eb40bda9047146ce32
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5c1eb40bda9047146ce32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Using the RHEL5.3 strict policy I am trying to allow a custom selinux user
permission to use the passwd and chage commands to get the status of a local
user.

With selinux in permissive it works as expected, with selinux in enforcing,
all I get are cryptic error messages.  I installed the enableaudit.pp base
policy module, still no denials.

Does anyone know what permissions I need to add or what I could be doing
wrong?  Is this even possible?

  Thank you,
  Larry

[secadm@newhost ~]$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          permissive
Policy version:                 21
Policy from config file:        strict

[secadm@newhost ~]$ sudo chage -l user
chage: Permission denied.
[secadm@newhost ~]$ sudo /usr/bin/passwd -S user
Only root can do that.

[secadm@newhost ~]$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 21
Policy from config file:        strict

[secadm@newhost ~]$ sudo chage -l user
Last password change                                    : May 14, 2009
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7

[secadm@newhost ~]$ sudo /usr/bin/passwd -S user
user PS 2009-05-13 0 99999 7 -1 (Password set, unknown crypt variant.)
[secadm@newhost ~]$

--001636c5c1eb40bda9047146ce32
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Using the RHEL5.3 strict policy I am trying to allow a custom selinux =
user permission to use the passwd and chage commands to get the status of a=
 local user.</div>
<div>=A0</div>
<div>With selinux in permissive it works as expected, with selinux in enfor=
cing, all I get are cryptic error messages.=A0 I=A0installed the enableaudi=
t.pp base policy module, still no denials.</div>
<div>=A0</div>
<div>Does anyone know what permissions I need to add or what I=A0could be=
=A0doing wrong?=A0 Is this even possible?</div>
<div>=A0</div>
<div>=A0 Thank you,</div>
<div>=A0=A0Larry</div>
<div>=A0</div>
<div>[secadm@newhost ~]$ sestatus<br>SELinux status:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled<br>SELinuxfs mount:=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 /selinux<br>Current mode:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enforcing<br>Mode from config file:=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 permissive<br>Policy version:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 21<br>
Policy from config file:=A0=A0=A0=A0=A0=A0=A0 strict</div>
<p>[secadm@newhost ~]$ sudo chage -l user<br>chage: Permission denied.<br>[=
secadm@newhost ~]$ sudo /usr/bin/passwd -S user<br>Only root can do that.</=
p>
<p>[secadm@newhost ~]$ sestatus<br>SELinux status:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 enabled<br>SELinuxfs mount:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 /selinux<br>Current mode:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 permissive<br>Mode from config file:=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 permissive<br>Policy version:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 21<br>
Policy from config file:=A0=A0=A0=A0=A0=A0=A0 strict</p>
<div><br>[secadm@newhost ~]$ sudo chage -l user<br>Last password change=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 : May 14, 2009<br>Password expires=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : never<br>Password inactive=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 : never<br>
Account expires=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : never<br>Min=
imum number of days between password change=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0<=
br>Maximum number of days between password change=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 : 99999<br>Number of days of warning before password expires=A0=A0=A0=
=A0=A0=A0 : 7</div>

<div><br>[secadm@newhost ~]$ sudo /usr/bin/passwd -S user<br>user PS 2009-0=
5-13 0 99999 7 -1 (Password set, unknown crypt variant.)<br>[secadm@newhost=
 ~]$<br></div>

--001636c5c1eb40bda9047146ce32--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
