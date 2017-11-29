Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAT8ps98029821
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 03:51:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3ymvRC3cQpz3GDJZ
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 08:51:51 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3ymvRC1qyZz3GDJW
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 08:51:51 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id w127so2899694iow.11
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 00:51:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171129082215.GA1225@julius.enp8s0.d30>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <20171129082215.GA1225@julius.enp8s0.d30>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 14:21:46 +0530
Message-ID: <CAPMH7-9r-TTzrjVYMNCQftnFyz1N2cAT7dYQufUhSs91hszsQg@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113f8cc4dd5403055f1b3e6f"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f8cc4dd5403055f1b3e6f
Content-Type: text/plain; charset="UTF-8"

Hi ,

Check the output for the same.

* getsebool -a | grep ssh*
fenced_can_ssh --> off
selinuxuser_use_ssh_chroot --> on
ssh_chroot_rw_homedirs --> off
ssh_keysign --> off
ssh_sysadm_login --> on


On Wed, Nov 29, 2017 at 1:52 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> On Wed, Nov 29, 2017 at 09:33:31AM +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > Below is the output of command :
> >
> > * sestatus -v output*
> > *SELinux status:                 enabled*
> > *SELinuxfs mount:                /sys/fs/selinux*
> > *SELinux root directory:         /etc/selinux*
> > *Loaded policy name:             targeted*
> > *Current mode:                   enforcing*
> > *Mode from config file:          permissive*
> > *Policy MLS status:              enabled*
> > *Policy deny_unknown status:     allowed*
> > *Max kernel policy version:      28*
> >
> > *Process contexts:*
> > *Current context:
> > system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > *Init context:                   system_u:system_r:init_t:s0*
> > */usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> s0:c0.c1023*
> >
> > *File contexts:*
> > *Controlling terminal:           system_u:object_r:sshd_devpts_t:s0*
> > */etc/passwd                     system_u:object_r:passwd_file_t:s0*
> > */etc/shadow                     system_u:object_r:shadow_t:s0*
> > */bin/bash                       system_u:object_r:shell_exec_t:s0*
> > */bin/login                      system_u:object_r:login_exec_t:s0*
> > */bin/sh                         system_u:object_r:bin_t:s0 ->
> > system_u:object_r:shell_exec_t:s0*
> > */sbin/agetty                    system_u:object_r:getty_exec_t:s0*
> > */sbin/init                      system_u:object_r:bin_t:s0 ->
> > system_u:object_r:init_exec_t:s0*
> > */usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0*
> > */lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > system_u:object_r:lib_t:s0*
> > */lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > system_u:object_r:ld_so_t:s0*
> >
> > *Also I am using ssh session for login.*
> >
> > *Please let me know how to change id command context to unconfined_u or
> > Sysadm_u.*
> >
> > Thanks in advance
> > Aman
>
> not sure and shot in dark, but:
>
> root is assoc. with sysadm_u. sysadm_u is only authorized to use sysadm_r.
> if you have the boolean ssh_priv_login set to off then
> sysadm_u:sysadm_r:sysadm_t:s0 is inaccessible
> pam_selinux attempts to use any other contexts that are accessible, and it
> appears that system_u:system_r:unconfined_t was it.
>
> Do you have the ssh_priv_login boolean set to off? `getsebool -a | grep
> ssh`
>
> >
> > On Mon, Nov 27, 2017 at 9:29 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> > > On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:
> > > >
> > > >
> > > > Hi All,
> > > >
> > > > Currently Working on Cent OS 7.3 and login as a root User and my Id
> > > > command output is :
> > > >
> > > > id
> > > > uid=0(root) gid=0(root) groups=0(root)
> > > > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> > > >
> > > > I want to change System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> > > > or unconfined_u:unconfined_r.
> > > >
> > > > Also showing the output of following command :
> > > >
> > > > semanage user -l
> > > >
> > > >                 Labeling   MLS/       MLS/
> > > > SELinux User    Prefix     MCS Level  MCS Range
> > > > SELinux Roles
> > > >
> > > > admin_u         user       s0         s0-s0:c0.c1023
> > > >  sysadm_r system_r
> > > > guest_u         user       s0         s0
> > > >  guest_r
> > > > root            user       s0         s0-s0:c0.c1023
> > > >  staff_r sysadm_r
> > > > specialuser_u   user       s0         s0
> > > >  sysadm_r system_r
> > > > staff_u         user       s0         s0-s0:c0.c1023
> > > >  staff_r sysadm_r system_r
> > > > sysadm_u        user       s0         s0-s0:c0.c1023
> > > >  sysadm_r
> > > > system_u        user       s0         s0-s0:c0.c1023
> > > >  system_r
> > > > unconfined_u    user       s0         s0-s0:c0.c1023
> > > >  system_r unconfined_r
> > > > user_u          user       s0         s0
> > > >  user_r
> > > > xguest_u        user       s0         s0
> > > >  xguest_r
> > > >
> > > >
> > > >  semanage login -l
> > > >
> > > > Login Name           SELinux User         MLS/MCS Range
> > > > Service
> > > >
> > > > __default__          sysadm_u             s0-s0:c0.c1023       *
> > > > ccmservice           specialuser_u        s0                   *
> > > > cucm                 admin_u              s0-s0:c0.c1023       *
> > > > drfkeys              specialuser_u        s0                   *
> > > > drfuser              specialuser_u        s0                   *
> > > > informix             specialuser_u        s0                   *
> > > > pwrecovery           specialuser_u        s0                   *
> > > > root                 sysadm_u             s0-s0:c0.c1023       *
> > > > sftpuser             specialuser_u        s0                   *
> > > > system_u             sysadm_u             s0-s0:c0.c1023       *
> > > >
> > > >
> > > > Can anybody Please help me.
> > >
> > > What is your sestatus -v output?  How are you logging in (console, gdm,
> > > ssh, ...)?
> > >
> > > You don't appear to be running the default policy, or if you are,
> > > someone has heavily customized your user and login mappings.
> > >
> > >
> > >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113f8cc4dd5403055f1b3e6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi ,<div><br></div><div>Check the output for the same.</di=
v><div><br></div><div><div><b>=C2=A0getsebool -a | grep ssh</b></div><div>f=
enced_can_ssh --&gt; off</div><div>selinuxuser_use_ssh_chroot --&gt; on</di=
v><div>ssh_chroot_rw_homedirs --&gt; off</div><div>ssh_keysign --&gt; off</=
div><div>ssh_sysadm_login --&gt; on</div></div><div><br></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Nov 29, 2017 at =
1:52 PM, Dominick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.overrid=
e@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, Nov 29, 2017 at=
 09:33:31AM +0530, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
&gt; Below is the output of command :<br>
&gt;<br>
</span>&gt; * sestatus -v output*<br>
&gt; *SELinux status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0enabled*<br>
&gt; *SELinuxfs mount:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /sys/fs/selinux*<br>
&gt; *SELinux root directory:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/etc/selinux=
*<br>
&gt; *Loaded policy name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ta=
rgeted*<br>
&gt; *Current mode:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enforcing*<br>
&gt; *Mode from config file:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 permissive*<=
br>
&gt; *Policy MLS status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en=
abled*<br>
&gt; *Policy deny_unknown status:=C2=A0 =C2=A0 =C2=A0allowed*<br>
&gt; *Max kernel policy version:=C2=A0 =C2=A0 =C2=A0 28*<br>
&gt;<br>
&gt; *Process contexts:*<br>
&gt; *Current context:<br>
&gt; system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023*<br>
&gt; *Init context:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0system_u:system_r:init_t:s0*<br>
&gt; */usr/sbin/sshd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 system_u:system_r:sshd_t:s0-<wbr>s0:c0.c1023*<br>
&gt;<br>
&gt; *File contexts:*<br>
&gt; *Controlling terminal:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_=
u:object_r:sshd_devpts_<wbr>t:s0*<br>
&gt; */etc/passwd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0system_u:object_r:passwd_file_<wbr>t:s0*<br>
&gt; */etc/shadow=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0system_u:object_r:shadow_t:s0*<br>
&gt; */bin/bash=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:shell_exec_<wbr>t:s0*<br>
&gt; */bin/login=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 system_u:object_r:login_exec_<wbr>t:s0*<br>
&gt; */bin/sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:bin_t:s0 -&gt;<br>
&gt; system_u:object_r:shell_exec_<wbr>t:s0*<br>
&gt; */sbin/agetty=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 system_u:object_r:getty_exec_<wbr>t:s0*<br>
&gt; */sbin/init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 system_u:object_r:bin_t:s0 -&gt;<br>
&gt; system_u:object_r:init_exec_t:<wbr>s0*<br>
&gt; */usr/sbin/sshd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 system_u:object_r:sshd_exec_t:<wbr>s0*<br>
&gt; */lib/libc.so.6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 system_u:object_r:lib_t:s0 -&gt;<br>
&gt; system_u:object_r:lib_t:s0*<br>
&gt; */lib/ld-linux.so.2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sy=
stem_u:object_r:lib_t:s0 -&gt;<br>
&gt; system_u:object_r:ld_so_t:s0*<br>
&gt;<br>
&gt; *Also I am using ssh session for login.*<br>
&gt;<br>
&gt; *Please let me know how to change id command context to unconfined_u o=
r<br>
&gt; Sysadm_u.*<br>
&gt;<br>
&gt; Thanks in advance<br>
&gt; Aman<br>
<br>
not sure and shot in dark, but:<br>
<br>
root is assoc. with sysadm_u. sysadm_u is only authorized to use sysadm_r.<=
br>
if you have the boolean ssh_priv_login set to off then sysadm_u:sysadm_r:sy=
sadm_t:s0 is inaccessible<br>
pam_selinux attempts to use any other contexts that are accessible, and it =
appears that system_u:system_r:unconfined_t was it.<br>
<br>
Do you have the ssh_priv_login boolean set to off? `getsebool -a | grep ssh=
`<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Mon, Nov 27, 2017 at 9:29 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Currently Working on Cent OS 7.3 and login as a root User an=
d my Id<br>
&gt; &gt; &gt; command output is :<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; id<br>
&gt; &gt; &gt; uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; &gt; &gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I want to change System_u:system_r:unconfined_t to sysadm_u:=
sysadm_r<br>
&gt; &gt; &gt; or unconfined_u:unconfined_r.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Also showing the output of following command :<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; semanage user -l<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Labeling=C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/<br>
&gt; &gt; &gt; SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Leve=
l=C2=A0 MCS Range<br>
&gt; &gt; &gt; SELinux Roles<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; admin_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 sysadm_r system_r<br>
&gt; &gt; &gt; guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt;=C2=A0 guest_r<br>
&gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 staff_r sysadm_r<br>
&gt; &gt; &gt; specialuser_u=C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt;=C2=A0 sysadm_r system_r<br>
&gt; &gt; &gt; staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 staff_r sysadm_r system_r<br>
&gt; &gt; &gt; sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 sysadm_r<br>
&gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 system_r<br>
&gt; &gt; &gt; unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt;=C2=A0 system_r unconfined_r<br>
&gt; &gt; &gt; user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt;=C2=A0 user_r<br>
&gt; &gt; &gt; xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt;=C2=A0 xguest_r<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 semanage login -l<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux U=
ser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range<br>
&gt; &gt; &gt; Service<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; __default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysadm_u=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*<br>
&gt; &gt; &gt; ccmservice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialus=
er_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; cucm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0admin_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s0-s0:c0.c102=
3=C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; drfkeys=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; drfuser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; informix=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; pwrecovery=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialus=
er_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c102=
3=C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; sftpuser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysa=
dm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can anybody Please help me.<br>
&gt; &gt;<br>
&gt; &gt; What is your sestatus -v output?=C2=A0 How are you logging in (co=
nsole, gdm,<br>
&gt; &gt; ssh, ...)?<br>
&gt; &gt;<br>
&gt; &gt; You don&#39;t appear to be running the default policy, or if you =
are,<br>
&gt; &gt; someone has heavily customized your user and login mappings.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/<wbr>pks/lookup?op=3Dget&amp;search=3D<wbr>0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 999=
0296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targ=
et=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113f8cc4dd5403055f1b3e6f--
