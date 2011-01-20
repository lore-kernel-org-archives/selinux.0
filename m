Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0KDjpwO002174
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 08:45:51 -0500
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0KDjaW2000111
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 13:45:36 GMT
Received: by gwb10 with SMTP id 10so168609gwb.12
        for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 05:45:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D375CE6.7030107@redhat.com>
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
	<4D37458B.4050705@redhat.com>
	<AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>
	<4D375CE6.7030107@redhat.com>
Date: Thu, 20 Jan 2011 08:45:35 -0500
Message-ID: <AANLkTi=7qtTjmVPDrVyDX0OiX1QbG3CzYXAtsT8L-von@mail.gmail.com>
Subject: Re: SELinux role separation
From: Qwyjibo Jones <qwyjibojones@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00151757093a2164e0049a475905
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00151757093a2164e0049a475905
Content-Type: text/plain; charset=ISO-8859-1

Sorry, one more question...

Does the MLS policy shipped with RHEL 6 have the separation?

Thanks,

On Wed, Jan 19, 2011 at 4:51 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:
> > I don't seem to have the "allow_sysadm_manage_security" boolean. Do I
> > need to create it somehow and put it under /selinux/booleans ?
> >
> > # getsebool -a | grep allow_sysadm_manage_security
> > # getsebool -a | grep allow_sysadm
> > # getsebool -a | grep sysadm
> > allow_httpd_sysadm_script_anon_write --> off
> > ssh_sysadm_login --> off
> > staff_read_sysadm_file --> off
> > xdm_sysadm_login --> off
> >
> >
> >
> > Thanks,
> >
> > On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <dwalsh@redhat.com
> > <mailto:dwalsh@redhat.com>> wrote:
> >
> > On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> >
> >> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
> >> installed.
> >> I am trying to understand how separation of roles works in SELinux/MLS
> >> policy version 21. We have been told that we need to separate
> > roles that
> >> the sys admin is no longer allowed to do.
> >
> >> After reading through these threads, in the archives I am still
> >> wondering about a couple things:
> >
> >
> >
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> >
> >> And this one:
> >
> >
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> >
> >> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
> >> separation of sysadm_r and secadm_r roles:
> >
> >>    a) Can the secadm_r role be the only role that can assign roles via
> >> semanage?
> >
> >>    c) Can the secadm_r role be the only role that can control
> > files used
> >> in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> >
> > auditadm_r:auditadm_t is only allowed to modify these files.
> >
> >> 2) Is this better accomplished with a combination of SUDO and SELinux?
> > Since sysadm_t can hack his way around the SELinux controls via tools
> > like rpm and fdisk, you are better off using sudo to further restrict
> > his actions, if possible.
> >> 3) How can I determine what secadm_r can do in the current
> >> configuration? can any of the CLI tools show me that? ( no gui tools
> >> available )
> >
> > You probably want to look at secadm_t
> >
> > sesearch -A -t secadm_t
> >
> >> If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
> >> Itanium systems, but we may have new hardware soon)
> >
> >> Any tips. hints, pointers etc... would be very helpfull.
> >
> >> Thanks for your time,
> >
> Oops I misread the policy,  I guess we abandoned the separation.
>
>
>                ifdef(`enable_mls',`
>                        userdom_security_administrator(secadm_t,secadm_r,{
> secadm_tty_device_t sysadm_devpts_t })
> #                       tunable_policy(`allow_sysadm_manage_security',`
>
>  userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
> #                       ')
>
>
> Missed the "#" at the beginning of the lines.  So I don't think we
> prevent sysadm_t from managing the security, of course he has to be able
> to run at SystemHigh.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk03XOYACgkQrlYvE4MpobNWvACeO1Q8Rioee4mA8jHSUKWyDFkI
> hHgAn2hf4+hRA36bn2urfI3ezlKNK/+O
> =h3mZ
> -----END PGP SIGNATURE-----
>

--00151757093a2164e0049a475905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, one more question...<br><br>Does the MLS policy shipped with RHEL 6 =
have the separation?<br><br>Thanks,<br><br><div class=3D"gmail_quote">On We=
d, Jan 19, 2011 at 4:51 PM, Daniel J Walsh <span dir=3D"ltr">&lt;<a href=3D=
"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
</div><div class=3D"im">On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:<br>
&gt; I don&#39;t seem to have the &quot;allow_sysadm_manage_security&quot; =
boolean. Do I<br>
&gt; need to create it somehow and put it under /selinux/booleans ?<br>
&gt;<br>
&gt; # getsebool -a | grep allow_sysadm_manage_security<br>
&gt; # getsebool -a | grep allow_sysadm<br>
&gt; # getsebool -a | grep sysadm<br>
&gt; allow_httpd_sysadm_script_anon_write --&gt; off<br>
&gt; ssh_sysadm_login --&gt; off<br>
&gt; staff_read_sysadm_file --&gt; off<br>
&gt; xdm_sysadm_login --&gt; off<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh &lt;<a href=3D"mailto:=
dwalsh@redhat.com">dwalsh@redhat.com</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:dwalsh@redhat.com=
">dwalsh@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
</div><div><div></div><div class=3D"h5">&gt; On 01/18/2011 01:03 PM, Qwyjib=
o Jones wrote:<br>
&gt;<br>
&gt;&gt; I am currently working with an Itanium2 system which has RHEL 5.3 =
MLS<br>
&gt;&gt; installed.<br>
&gt;&gt; I am trying to understand how separation of roles works in SELinux=
/MLS<br>
&gt;&gt; policy version 21. We have been told that we need to separate<br>
&gt; roles that<br>
&gt;&gt; the sys admin is no longer allowed to do.<br>
&gt;<br>
&gt;&gt; After reading through these threads, in the archives I am still<br=
>
&gt;&gt; wondering about a couple things:<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0504/threa=
d_body66.shtml#11082" target=3D"_blank">http://www.nsa.gov/research/selinux=
/list-archive/0504/thread_body66.shtml#11082</a><br>
&gt;<br>
&gt;&gt; And this one:<br>
&gt;<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0802/threa=
d_body60.shtml" target=3D"_blank">http://www.nsa.gov/research/selinux/list-=
archive/0802/thread_body60.shtml</a><br>
&gt;<br>
&gt;&gt; 1) Is the RHEL 5.x MLS policy version 21 capable of the following<=
br>
&gt;&gt; separation of sysadm_r and secadm_r roles:<br>
&gt;<br>
&gt;&gt; =A0 =A0a) Can the secadm_r role be the only role that can assign r=
oles via<br>
&gt;&gt; semanage?<br>
&gt;<br>
&gt;&gt; =A0 =A0c) Can the secadm_r role be the only role that can control<=
br>
&gt; files used<br>
&gt;&gt; in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc=
...<br>
&gt;<br>
&gt; auditadm_r:auditadm_t is only allowed to modify these files.<br>
&gt;<br>
&gt;&gt; 2) Is this better accomplished with a combination of SUDO and SELi=
nux?<br>
&gt; Since sysadm_t can hack his way around the SELinux controls via tools<=
br>
&gt; like rpm and fdisk, you are better off using sudo to further restrict<=
br>
&gt; his actions, if possible.<br>
&gt;&gt; 3) How can I determine what secadm_r can do in the current<br>
&gt;&gt; configuration? can any of the CLI tools show me that? ( no gui too=
ls<br>
&gt;&gt; available )<br>
&gt;<br>
&gt; You probably want to look at secadm_t<br>
&gt;<br>
&gt; sesearch -A -t secadm_t<br>
&gt;<br>
&gt;&gt; If not, what about RHEL 6 ? ( I understand RHEL 6 is not available=
 to<br>
&gt;&gt; Itanium systems, but we may have new hardware soon)<br>
&gt;<br>
&gt;&gt; Any tips. hints, pointers etc... would be very helpfull.<br>
&gt;<br>
&gt;&gt; Thanks for your time,<br>
&gt;<br>
</div></div>Oops I misread the policy, =A0I guess we abandoned the separati=
on.<br>
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ifdef(`enable_mls&#39;,`<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0userdom_security_administra=
tor(secadm_t,secadm_r,{<br>
secadm_tty_device_t sysadm_devpts_t })<br>
# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tunable_policy(`allow_sysadm_=
manage_security&#39;,`<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0userdom_sec=
urity_administrator(sysadm_t,sysadm_r,admin_terminal)<br>
# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &#39;)<br>
<br>
<br>
Missed the &quot;#&quot; at the beginning of the lines. =A0So I don&#39;t t=
hink we<br>
prevent sysadm_t from managing the security, of course he has to be able<br=
>
to run at SystemHigh.<br>
<div class=3D"im"><br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
</div>iEYEARECAAYFAk03XOYACgkQrlYvE4MpobNWvACeO1Q8Rioee4mA8jHSUKWyDFkI<br>
hHgAn2hf4+hRA36bn2urfI3ezlKNK/+O<br>
=3Dh3mZ<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br>

--00151757093a2164e0049a475905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
