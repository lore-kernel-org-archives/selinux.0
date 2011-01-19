Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0JLipUj017695
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 16:44:51 -0500
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0JLioJu010151
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 21:44:50 GMT
Received: by yxd39 with SMTP id 39so588779yxd.12
        for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 13:44:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D37458B.4050705@redhat.com>
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
	<4D37458B.4050705@redhat.com>
Date: Wed, 19 Jan 2011 16:44:49 -0500
Message-ID: <AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>
Subject: Re: SELinux role separation
From: Qwyjibo Jones <qwyjibojones@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf30434030237ee3049a39edc2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30434030237ee3049a39edc2
Content-Type: text/plain; charset=ISO-8859-1

I don't seem to have the "allow_sysadm_manage_security" boolean. Do I need
to create it somehow and put it under /selinux/booleans ?

# getsebool -a | grep allow_sysadm_manage_security
# getsebool -a | grep allow_sysadm
# getsebool -a | grep sysadm
allow_httpd_sysadm_script_anon_write --> off
ssh_sysadm_login --> off
staff_read_sysadm_file --> off
xdm_sysadm_login --> off



Thanks,

On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> >
> > I am currently working with an Itanium2 system which has RHEL 5.3 MLS
> > installed.
> > I am trying to understand how separation of roles works in SELinux/MLS
> > policy version 21. We have been told that we need to separate roles that
> > the sys admin is no longer allowed to do.
> >
> > After reading through these threads, in the archives I am still
> > wondering about a couple things:
> >
> >
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> >
> > And this one:
> >
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> >
> > 1) Is the RHEL 5.x MLS policy version 21 capable of the following
> > separation of sysadm_r and secadm_r roles:
> >
> >    a) Can the secadm_r role be the only role that can assign roles via
> > semanage?
>
> >    c) Can the secadm_r role be the only role that can control files used
> > in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> >
> auditadm_r:auditadm_t is only allowed to modify these files.
>
> > 2) Is this better accomplished with a combination of SUDO and SELinux?
> Since sysadm_t can hack his way around the SELinux controls via tools
> like rpm and fdisk, you are better off using sudo to further restrict
> his actions, if possible.
> > 3) How can I determine what secadm_r can do in the current
> > configuration? can any of the CLI tools show me that? ( no gui tools
> > available )
> >
> You probably want to look at secadm_t
>
> sesearch -A -t secadm_t
>
> > If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
> > Itanium systems, but we may have new hardware soon)
> >
> > Any tips. hints, pointers etc... would be very helpfull.
> >
> > Thanks for your time,
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk03RYsACgkQrlYvE4MpobPxeQCfYZFtvY0/6oiB0kCUhZfy8NBe
> 1isAoI2+zCfveZJRpCxIxeu+XAvcjFcw
> =vT6y
> -----END PGP SIGNATURE-----
>

--20cf30434030237ee3049a39edc2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don&#39;t seem to have the &quot;allow_sysadm_manage_security&quot; boole=
an. Do I need to create it somehow and put it under /selinux/booleans ? <br=
><br># getsebool -a | grep allow_sysadm_manage_security<br># getsebool -a |=
 grep allow_sysadm<br>
# getsebool -a | grep sysadm<br>allow_httpd_sysadm_script_anon_write --&gt;=
 off<br>ssh_sysadm_login --&gt; off<br>staff_read_sysadm_file --&gt; off<br=
>xdm_sysadm_login --&gt; off<br><br><br><br>Thanks,<br><br><div class=3D"gm=
ail_quote">
On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div class=3D"im"><br>
On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:<br>
&gt;<br>
&gt; I am currently working with an Itanium2 system which has RHEL 5.3 MLS<=
br>
&gt; installed.<br>
&gt; I am trying to understand how separation of roles works in SELinux/MLS=
<br>
&gt; policy version 21. We have been told that we need to separate roles th=
at<br>
&gt; the sys admin is no longer allowed to do.<br>
&gt;<br>
&gt; After reading through these threads, in the archives I am still<br>
&gt; wondering about a couple things:<br>
&gt;<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0504/threa=
d_body66.shtml#11082" target=3D"_blank">http://www.nsa.gov/research/selinux=
/list-archive/0504/thread_body66.shtml#11082</a><br>
&gt;<br>
&gt; And this one:<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0802/threa=
d_body60.shtml" target=3D"_blank">http://www.nsa.gov/research/selinux/list-=
archive/0802/thread_body60.shtml</a><br>
&gt;<br>
&gt; 1) Is the RHEL 5.x MLS policy version 21 capable of the following<br>
&gt; separation of sysadm_r and secadm_r roles:<br>
&gt;<br>
&gt; =A0 =A0a) Can the secadm_r role be the only role that can assign roles=
 via<br>
&gt; semanage?<br>
</div><div class=3D"im"><br>
&gt; =A0 =A0c) Can the secadm_r role be the only role that can control file=
s used<br>
&gt; in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...<=
br>
&gt;<br>
</div>auditadm_r:auditadm_t is only allowed to modify these files.<br>
<div class=3D"im"><br>
&gt; 2) Is this better accomplished with a combination of SUDO and SELinux?=
<br>
</div>Since sysadm_t can hack his way around the SELinux controls via tools=
<br>
like rpm and fdisk, you are better off using sudo to further restrict<br>
his actions, if possible.<br>
<div class=3D"im">&gt; 3) How can I determine what secadm_r can do in the c=
urrent<br>
&gt; configuration? can any of the CLI tools show me that? ( no gui tools<b=
r>
&gt; available )<br>
&gt;<br>
</div>You probably want to look at secadm_t<br>
<br>
sesearch -A -t secadm_t<br>
<div class=3D"im"><br>
&gt; If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to<=
br>
&gt; Itanium systems, but we may have new hardware soon)<br>
&gt;<br>
&gt; Any tips. hints, pointers etc... would be very helpfull.<br>
&gt;<br>
&gt; Thanks for your time,<br>
<br>
</div>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
iEYEARECAAYFAk03RYsACgkQrlYvE4MpobPxeQCfYZFtvY0/6oiB0kCUhZfy8NBe<br>
1isAoI2+zCfveZJRpCxIxeu+XAvcjFcw<br>
=3DvT6y<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br>

--20cf30434030237ee3049a39edc2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
