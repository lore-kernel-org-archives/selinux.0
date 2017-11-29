MIME-Version: 1.0
In-Reply-To: <291642867.19424177.1511969385007.JavaMail.zimbra@redhat.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <291642867.19424177.1511969385007.JavaMail.zimbra@redhat.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 21:04:47 +0530
Message-ID: <CAPMH7-8LkCF_7AmbeyMEwrvf4vj4o_X-7yWW_i=aR22bLM0ojg@mail.gmail.com>
To: Simon Sekidde <ssekidde@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11351a002c9ae1055f20e06c"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11351a002c9ae1055f20e06c
Content-Type: text/plain; charset="UTF-8"

No, I am not using 3rd party SSH client. This is normal ssh .

On Wed, Nov 29, 2017 at 8:59 PM, Simon Sekidde <ssekidde@redhat.com> wrote:

> Aman,
>
> ----- Original Message -----
> > From: "Aman Sharma" <amansh.sharma5@gmail.com>
> > To: "Stephen Smalley" <sds@tycho.nsa.gov>
> > Cc: "SELinux" <selinux@tycho.nsa.gov>
> > Sent: Wednesday, November 29, 2017 10:17:19 AM
> > Subject: Re: Fwd: Qwery regarding Selinux Change Id context
> >
> > Hi Stephen,
> >
> > I tried all the three command i.e.
> > semanage export > localchanges
> >
> > semanage login -D
> > semanage user -D
> >
> > Then I reboot the system and after reboot , still its showing the root
> User
> > as Same id context i.e.
> >
> > *id*
> > *uid=0(root) gid=0(root) groups=0(root)
> > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> >
> > * id -Z*
> > *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> >
>
> Are you using a 3rd party ssh client?
>
> >
> > Also check the below output :
> > *semanage user -l*
> >
> > *                Labeling   MLS/       MLS/                          *
> > *SELinux User    Prefix     MCS Level  MCS Range
> > SELinux Roles*
> >
> > *guest_u         user       s0         s0
> >  guest_r*
> > *root            user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r system_r unconfined_r*
> > *staff_u         user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r system_r unconfined_r*
> > *sysadm_u        user       s0         s0-s0:c0.c1023
> >  sysadm_r*
> > *system_u        user       s0         s0-s0:c0.c1023
> >  system_r unconfined_r*
> > *unconfined_u    user       s0         s0-s0:c0.c1023
> >  system_r unconfined_r*
> > *user_u          user       s0         s0
> >  user_r*
> > *xguest_u        user       s0         s0
> >  xguest_r*
> > *[root@cucm ~]# semanage login -l*
> >
> > *Login Name           SELinux User         MLS/MCS Range        Service*
> >
> > *__default__          unconfined_u         s0-s0:c0.c1023       **
> > *root                 unconfined_u         s0-s0:c0.c1023       **
> > *system_u             system_u             s0-s0:c0.c1023       **
> >
> > *Please let me know your comments on this.*
> >
> > *Thanks*
> > *Aman*
> >
> > On Wed, Nov 29, 2017 at 8:17 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> > > On Wed, 2017-11-29 at 20:11 +0530, Aman Sharma wrote:
> > > > Hi Stephen,
> > > >
> > > > Thanks for the reply.
> > > >
> > > > Can you please let me know how to delete all local customizations
> > > > (via semanage or manually) and revert
> > > > to a default policy.
> > >
> > > First, save any local customizations in case you want to restore them
> > > later:
> > > semanage export > localchanges
> > >
> > > Then, delete them:
> > > semanage login -D
> > > semanage user -D
> > >
> > > Then logout and log back in.
> > >
> > > >
> > > > Otherwise the output of semanage login -l and semanage user -l  :
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
> > > > Please let me know if any comments are there.
> > > >
> > > > Thanks
> > > > Aman
> > > >
> > > > On Wed, Nov 29, 2017 at 7:21 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > > wrote:
> > > > > On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:
> > > > > > Hi Stephen,
> > > > > >
> > > > > > Below is the output of command :
> > > > > >
> > > > > >  sestatus -v output
> > > > > > SELinux status:                 enabled
> > > > > > SELinuxfs mount:                /sys/fs/selinux
> > > > > > SELinux root directory:         /etc/selinux
> > > > > > Loaded policy name:             targeted
> > > > > > Current mode:                   enforcing
> > > > > > Mode from config file:          permissive
> > > > > > Policy MLS status:              enabled
> > > > > > Policy deny_unknown status:     allowed
> > > > > > Max kernel policy version:      28
> > > > > >
> > > > > > Process contexts:
> > > > > > Current context:
> > > > > system_u:system_r:unconfined_t:s0-
> > > > > > s0:c0.c1023
> > > > > > Init context:                   system_u:system_r:init_t:s0
> > > > > > /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> > > > > > s0:c0.c1023
> > > > > >
> > > > > > File contexts:
> > > > > > Controlling terminal:
> > > > >  system_u:object_r:sshd_devpts_t:s0
> > > > > > /etc/passwd
> > > > >  system_u:object_r:passwd_file_t:s0
> > > > > > /etc/shadow                     system_u:object_r:shadow_t:s0
> > > > > > /bin/bash                       system_u:object_r:shell_exec_
> t:s0
> > > > > > /bin/login                      system_u:object_r:login_exec_
> t:s0
> > > > > > /bin/sh                         system_u:object_r:bin_t:s0 ->
> > > > > > system_u:object_r:shell_exec_t:s0
> > > > > > /sbin/agetty                    system_u:object_r:getty_exec_
> t:s0
> > > > > > /sbin/init                      system_u:object_r:bin_t:s0 ->
> > > > > > system_u:object_r:init_exec_t:s0
> > > > > > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> > > > > > /lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > > > > > system_u:object_r:lib_t:s0
> > > > > > /lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > > > > > system_u:object_r:ld_so_t:s0
> > > > > >
> > > > > > Also I am using ssh session for login.
> > > > > >
> > > > > > Please let me know how to change id command context to
> > > > > unconfined_u
> > > > > > or Sysadm_u.
> > > > >
> > > > > So from your earlier message, it is clear that you (or someone
> > > > > else)
> > > > > has heavily customized your semanage login and user mappings from
> > > > > the
> > > > > stock targeted policy.  The question is why, and whether you
> > > > > want/need
> > > > > to retain any of those customizations.  If not, then you could just
> > > > > delete all local customizations (via semanage or manually) and
> > > > > revert
> > > > > to a stock policy.
> > > > >
> > > > > If you do need to retain some of those customizations, then please
> > > > > show
> > > > > your current semanage login -l and semanage user -l output since
> > > > > you
> > > > > said you ran some further semanage commands after the last output
> > > > > you
> > > > > showed.
> > > > >
> > > > >
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Thanks
> > > > Aman
> > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > >
> >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >
>
> --
> Simon Sekidde
> gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
>
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11351a002c9ae1055f20e06c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, I am not using 3rd party SSH client. This is normal ss=
h .</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, =
Nov 29, 2017 at 8:59 PM, Simon Sekidde <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:ssekidde@redhat.com" target=3D"_blank">ssekidde@redhat.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Aman,<br>
<span class=3D""><br>
----- Original Message -----<br>
&gt; From: &quot;Aman Sharma&quot; &lt;<a href=3D"mailto:amansh.sharma5@gma=
il.com">amansh.sharma5@gmail.com</a>&gt;<br>
</span><span class=3D"">&gt; To: &quot;Stephen Smalley&quot; &lt;<a href=3D=
"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; Cc: &quot;SELinux&quot; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">s=
elinux@tycho.nsa.gov</a>&gt;<br>
&gt; Sent: Wednesday, November 29, 2017 10:17:19 AM<br>
&gt; Subject: Re: Fwd: Qwery regarding Selinux Change Id context<br>
&gt;<br>
&gt; Hi Stephen,<br>
&gt;<br>
&gt; I tried all the three command i.e.<br>
&gt; semanage export &gt; localchanges<br>
&gt;<br>
&gt; semanage login -D<br>
&gt; semanage user -D<br>
&gt;<br>
&gt; Then I reboot the system and after reboot , still its showing the root=
 User<br>
&gt; as Same id context i.e.<br>
&gt;<br>
</span>&gt; *id*<br>
&gt; *uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023*<br>
&gt;<br>
&gt; * id -Z*<br>
&gt; *system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023*<br>
&gt;<br>
<br>
Are you using a 3rd party ssh client?<br>
<span class=3D""><br>
&gt;<br>
&gt; Also check the below output :<br>
</span><span class=3D"">&gt; *semanage user -l*<br>
&gt;<br>
&gt; *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Labeling=C2=
=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
</span>&gt; *SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Level=
=C2=A0 MCS Range<br>
&gt; SELinux Roles*<br>
<span class=3D"">&gt;<br>
&gt; *guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt;=C2=A0 guest_r*<br>
</span>&gt; *root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt;=C2=A0 staff_r sysadm_r system_r unconfined_r*<br>
&gt; *staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt;=C2=A0 staff_r sysadm_r system_r unconfined_r*<br>
<span class=3D"">&gt; *sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt;=C2=A0 sysadm_r*<br>
</span>&gt; *system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =
=C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt;=C2=A0 system_r unconfined_r*<br>
&gt; *unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
<span class=3D"">&gt;=C2=A0 system_r unconfined_r*<br>
&gt; *user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt;=C2=A0 user_r*<br>
&gt; *xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt;=C2=A0 xguest_r*<br>
</span>&gt; *[root@cucm ~]# semanage login -l*<br>
&gt;<br>
&gt; *Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux User=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 Servic=
e*<br>
&gt;<br>
&gt; *__default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unconfined_u=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; *root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unc=
onfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0**<br>
&gt; *system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =
=C2=A0 =C2=A0**<br>
&gt;<br>
&gt; *Please let me know your comments on this.*<br>
&gt;<br>
&gt; *Thanks*<br>
&gt; *Aman*<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt; On Wed, Nov 29, 2017 at 8:17 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, 2017-11-29 at 20:11 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks for the reply.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can you please let me know how to delete all local customiza=
tions<br>
&gt; &gt; &gt; (via semanage or manually) and revert<br>
&gt; &gt; &gt; to a default policy.<br>
&gt; &gt;<br>
&gt; &gt; First, save any local customizations in case you want to restore =
them<br>
&gt; &gt; later:<br>
&gt; &gt; semanage export &gt; localchanges<br>
&gt; &gt;<br>
&gt; &gt; Then, delete them:<br>
&gt; &gt; semanage login -D<br>
&gt; &gt; semanage user -D<br>
&gt; &gt;<br>
&gt; &gt; Then logout and log back in.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Otherwise the output of semanage login -l and semanage user =
-l=C2=A0 :<br>
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
&gt; &gt; &gt; Please let me know if any comments are there.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Nov 29, 2017 at 7:21 PM, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:<b=
r>
&gt; &gt; &gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Below is the output of command :<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 sestatus -v output<br>
&gt; &gt; &gt; &gt; &gt; SELinux status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0enabled<br>
&gt; &gt; &gt; &gt; &gt; SELinuxfs mount:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /sys/fs/selinux<br>
&gt; &gt; &gt; &gt; &gt; SELinux root directory:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/etc/selinux<br>
&gt; &gt; &gt; &gt; &gt; Loaded policy name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0targeted<br>
&gt; &gt; &gt; &gt; &gt; Current mode:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enforcing<br>
&gt; &gt; &gt; &gt; &gt; Mode from config file:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 permissive<br>
&gt; &gt; &gt; &gt; &gt; Policy MLS status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enabled<br>
&gt; &gt; &gt; &gt; &gt; Policy deny_unknown status:=C2=A0 =C2=A0 =C2=A0all=
owed<br>
&gt; &gt; &gt; &gt; &gt; Max kernel policy version:=C2=A0 =C2=A0 =C2=A0 28<=
br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Process contexts:<br>
&gt; &gt; &gt; &gt; &gt; Current context:<br>
&gt; &gt; &gt; &gt; system_u:system_r:unconfined_<wbr>t:s0-<br>
&gt; &gt; &gt; &gt; &gt; s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; Init context:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:system_r:init_t:s0<br>
&gt; &gt; &gt; &gt; &gt; /usr/sbin/sshd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:system_r:sshd_t:s0-<br>
&gt; &gt; &gt; &gt; &gt; s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; File contexts:<br>
&gt; &gt; &gt; &gt; &gt; Controlling terminal:<br>
&gt; &gt; &gt; &gt;=C2=A0 system_u:object_r:sshd_devpts_<wbr>t:s0<br>
&gt; &gt; &gt; &gt; &gt; /etc/passwd<br>
&gt; &gt; &gt; &gt;=C2=A0 system_u:object_r:passwd_file_<wbr>t:s0<br>
&gt; &gt; &gt; &gt; &gt; /etc/shadow=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:shadow_t:s0<br>
&gt; &gt; &gt; &gt; &gt; /bin/bash=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:shell_exec_<wbr=
>t:s0<br>
&gt; &gt; &gt; &gt; &gt; /bin/login=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:login_exec_<wbr>t:=
s0<br>
&gt; &gt; &gt; &gt; &gt; /bin/sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:bin_t:s0 =
-&gt;<br>
&gt; &gt; &gt; &gt; &gt; system_u:object_r:shell_exec_<wbr>t:s0<br>
&gt; &gt; &gt; &gt; &gt; /sbin/agetty=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:getty_exec_<wbr>t:s0<br>
&gt; &gt; &gt; &gt; &gt; /sbin/init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:bin_t:s0 -&gt;<br>
&gt; &gt; &gt; &gt; &gt; system_u:object_r:init_exec_t:<wbr>s0<br>
&gt; &gt; &gt; &gt; &gt; /usr/sbin/sshd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:sshd_exec_t:<wbr>s0<br>
&gt; &gt; &gt; &gt; &gt; /lib/libc.so.6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:object_r:lib_t:s0 -&gt;<br>
&gt; &gt; &gt; &gt; &gt; system_u:object_r:lib_t:s0<br>
&gt; &gt; &gt; &gt; &gt; /lib/ld-linux.so.2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 system_u:object_r:lib_t:s0 -&gt;<br>
&gt; &gt; &gt; &gt; &gt; system_u:object_r:ld_so_t:s0<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Also I am using ssh session for login.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Please let me know how to change id command contex=
t to<br>
&gt; &gt; &gt; &gt; unconfined_u<br>
&gt; &gt; &gt; &gt; &gt; or Sysadm_u.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; So from your earlier message, it is clear that you (or =
someone<br>
&gt; &gt; &gt; &gt; else)<br>
&gt; &gt; &gt; &gt; has heavily customized your semanage login and user map=
pings from<br>
&gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; stock targeted policy.=C2=A0 The question is why, and w=
hether you<br>
&gt; &gt; &gt; &gt; want/need<br>
&gt; &gt; &gt; &gt; to retain any of those customizations.=C2=A0 If not, th=
en you could just<br>
&gt; &gt; &gt; &gt; delete all local customizations (via semanage or manual=
ly) and<br>
&gt; &gt; &gt; &gt; revert<br>
&gt; &gt; &gt; &gt; to a stock policy.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; If you do need to retain some of those customizations, =
then please<br>
&gt; &gt; &gt; &gt; show<br>
&gt; &gt; &gt; &gt; your current semanage login -l and semanage user -l out=
put since<br>
&gt; &gt; &gt; &gt; you<br>
&gt; &gt; &gt; &gt; said you ran some further semanage commands after the l=
ast output<br>
&gt; &gt; &gt; &gt; you<br>
&gt; &gt; &gt; &gt; showed.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:am=
ansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt;<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Simon Sekidde<br>
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11351a002c9ae1055f20e06c--
