Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0KH5R6N018147
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 12:05:27 -0500
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0KH5Qsm009124
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 17:05:27 GMT
Received: by yxd39 with SMTP id 39so261639yxd.12
        for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2011 09:05:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D384567.1030104@redhat.com>
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
	<4D37458B.4050705@redhat.com>
	<AANLkTimcB_2Dt6fetoDZ_Da0CaWKFDHv-UA=pA3P-Oc7@mail.gmail.com>
	<4D375CE6.7030107@redhat.com>
	<AANLkTi=7qtTjmVPDrVyDX0OiX1QbG3CzYXAtsT8L-von@mail.gmail.com>
	<4D384567.1030104@redhat.com>
Date: Thu, 20 Jan 2011 12:05:26 -0500
Message-ID: <AANLkTike3iQo3jbXh=cspKi0fdSdA7hz4mDSDeKv8Ckk@mail.gmail.com>
Subject: Re: SELinux role separation
From: Qwyjibo Jones <qwyjibojones@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00163628354ed70bfd049a4a23c0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00163628354ed70bfd049a4a23c0
Content-Type: text/plain; charset=ISO-8859-1

Okay,

We aren't using any desktop right now. this system is a headless server.

As for how important... Well if you ask me, (the sysadmin), I would say not
very. But alas it is not up to me. I will have to get the customer (Govt) to
tell me how much they need this. Perhaps I can get them to wait until 6.1
comes out since they are thinking of a hardware refresh anyhow.

My current policy skills are probably insufficient to the task of making the
policy you described. I can use audit2allow pretty well tho... :)

Thanks,

On Thu, Jan 20, 2011 at 9:23 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/20/2011 08:45 AM, Qwyjibo Jones wrote:
> > Sorry, one more question...
> >
> > Does the MLS policy shipped with RHEL 6 have the separation?
> >
> > Thanks,
> >
> > On Wed, Jan 19, 2011 at 4:51 PM, Daniel J Walsh <dwalsh@redhat.com
> > <mailto:dwalsh@redhat.com>> wrote:
> >
> > On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:
> >> I don't seem to have the "allow_sysadm_manage_security" boolean. Do I
> >> need to create it somehow and put it under /selinux/booleans ?
> >
> >> # getsebool -a | grep allow_sysadm_manage_security
> >> # getsebool -a | grep allow_sysadm
> >> # getsebool -a | grep sysadm
> >> allow_httpd_sysadm_script_anon_write --> off
> >> ssh_sysadm_login --> off
> >> staff_read_sysadm_file --> off
> >> xdm_sysadm_login --> off
> >
> >
> >
> >> Thanks,
> >
> >> On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh <dwalsh@redhat.com
> > <mailto:dwalsh@redhat.com>
> >> <mailto:dwalsh@redhat.com <mailto:dwalsh@redhat.com>>> wrote:
> >
> >> On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> >
> >>> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
> >>> installed.
> >>> I am trying to understand how separation of roles works in
> > SELinux/MLS
> >>> policy version 21. We have been told that we need to separate
> >> roles that
> >>> the sys admin is no longer allowed to do.
> >
> >>> After reading through these threads, in the archives I am still
> >>> wondering about a couple things:
> >
> >
> >
> >
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> >
> >>> And this one:
> >
> >
> >
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> >
> >>> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
> >>> separation of sysadm_r and secadm_r roles:
> >
> >>>    a) Can the secadm_r role be the only role that can assign
> > roles via
> >>> semanage?
> >
> >>>    c) Can the secadm_r role be the only role that can control
> >> files used
> >>> in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> >
> >> auditadm_r:auditadm_t is only allowed to modify these files.
> >
> >>> 2) Is this better accomplished with a combination of SUDO and
> > SELinux?
> >> Since sysadm_t can hack his way around the SELinux controls via tools
> >> like rpm and fdisk, you are better off using sudo to further restrict
> >> his actions, if possible.
> >>> 3) How can I determine what secadm_r can do in the current
> >>> configuration? can any of the CLI tools show me that? ( no gui tools
> >>> available )
> >
> >> You probably want to look at secadm_t
> >
> >> sesearch -A -t secadm_t
> >
> >>> If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
> >>> Itanium systems, but we may have new hardware soon)
> >
> >>> Any tips. hints, pointers etc... would be very helpfull.
> >
> >>> Thanks for your time,
> >
> > Oops I misread the policy,  I guess we abandoned the separation.
> >
> >
> >                ifdef(`enable_mls',`
> >
> >  userdom_security_administrator(secadm_t,secadm_r,{
> > secadm_tty_device_t sysadm_devpts_t })
> > #                       tunable_policy(`allow_sysadm_manage_security',`
> >
> >  userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
> > #                       ')
> >
> >
> > Missed the "#" at the beginning of the lines.  So I don't think we
> > prevent sysadm_t from managing the security, of course he has to be able
> > to run at SystemHigh.
> >
> One idea would be to build the separation into a separate module
> sysadm_secadm.pp then you could disable this module and take away the
> power of sysadm to do security administration. How important is this?
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk04RWcACgkQrlYvE4MpobNgkwCgrpfXVA3VACrLFueZjW6V5Gko
> YRsAoJsGGp76ODNFPSIhpl24h4D5KA6A
> =Ae9m
> -----END PGP SIGNATURE-----
>

--00163628354ed70bfd049a4a23c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Okay,<br><br>We aren&#39;t using any desktop right now. this system is a he=
adless server. <br><br>As for how important... Well if you ask me, (the sys=
admin), I would say not very. But alas it is not up to me. I will have to g=
et the customer (Govt) to tell me how much they need this. Perhaps I can ge=
t them to wait until 6.1 comes out since they are thinking of a hardware re=
fresh anyhow.<br>
<br>My current policy skills are probably insufficient to the task of makin=
g the policy you described. I can use audit2allow pretty well tho... :)<br>=
<br>Thanks,<br><br><div class=3D"gmail_quote">On Thu, Jan 20, 2011 at 9:23 =
AM, Daniel J Walsh <span dir=3D"ltr">&lt;<a href=3D"mailto:dwalsh@redhat.co=
m">dwalsh@redhat.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
</div><div class=3D"im">On 01/20/2011 08:45 AM, Qwyjibo Jones wrote:<br>
</div><div class=3D"im">&gt; Sorry, one more question...<br>
&gt;<br>
&gt; Does the MLS policy shipped with RHEL 6 have the separation?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; On Wed, Jan 19, 2011 at 4:51 PM, Daniel J Walsh &lt;<a href=3D"mailto:=
dwalsh@redhat.com">dwalsh@redhat.com</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:dwalsh@redhat.com=
">dwalsh@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; On 01/19/2011 04:44 PM, Qwyjibo Jones wrote:<br>
&gt;&gt; I don&#39;t seem to have the &quot;allow_sysadm_manage_security&qu=
ot; boolean. Do I<br>
&gt;&gt; need to create it somehow and put it under /selinux/booleans ?<br>
&gt;<br>
&gt;&gt; # getsebool -a | grep allow_sysadm_manage_security<br>
&gt;&gt; # getsebool -a | grep allow_sysadm<br>
&gt;&gt; # getsebool -a | grep sysadm<br>
&gt;&gt; allow_httpd_sysadm_script_anon_write --&gt; off<br>
&gt;&gt; ssh_sysadm_login --&gt; off<br>
&gt;&gt; staff_read_sysadm_file --&gt; off<br>
&gt;&gt; xdm_sysadm_login --&gt; off<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; Thanks,<br>
&gt;<br>
&gt;&gt; On Wed, Jan 19, 2011 at 3:11 PM, Daniel J Walsh &lt;<a href=3D"mai=
lto:dwalsh@redhat.com">dwalsh@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&=
gt;<br>
</div><div><div></div><div class=3D"h5">&gt;&gt; &lt;mailto:<a href=3D"mail=
to:dwalsh@redhat.com">dwalsh@redhat.com</a> &lt;mailto:<a href=3D"mailto:dw=
alsh@redhat.com">dwalsh@redhat.com</a>&gt;&gt;&gt; wrote:<br>
&gt;<br>
&gt;&gt; On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:<br>
&gt;<br>
&gt;&gt;&gt; I am currently working with an Itanium2 system which has RHEL =
5.3 MLS<br>
&gt;&gt;&gt; installed.<br>
&gt;&gt;&gt; I am trying to understand how separation of roles works in<br>
&gt; SELinux/MLS<br>
&gt;&gt;&gt; policy version 21. We have been told that we need to separate<=
br>
&gt;&gt; roles that<br>
&gt;&gt;&gt; the sys admin is no longer allowed to do.<br>
&gt;<br>
&gt;&gt;&gt; After reading through these threads, in the archives I am stil=
l<br>
&gt;&gt;&gt; wondering about a couple things:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0504/threa=
d_body66.shtml#11082" target=3D"_blank">http://www.nsa.gov/research/selinux=
/list-archive/0504/thread_body66.shtml#11082</a><br>
&gt;<br>
&gt;&gt;&gt; And this one:<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"http://www.nsa.gov/research/selinux/list-archive/0802/threa=
d_body60.shtml" target=3D"_blank">http://www.nsa.gov/research/selinux/list-=
archive/0802/thread_body60.shtml</a><br>
&gt;<br>
&gt;&gt;&gt; 1) Is the RHEL 5.x MLS policy version 21 capable of the follow=
ing<br>
&gt;&gt;&gt; separation of sysadm_r and secadm_r roles:<br>
&gt;<br>
&gt;&gt;&gt; =A0 =A0a) Can the secadm_r role be the only role that can assi=
gn<br>
&gt; roles via<br>
&gt;&gt;&gt; semanage?<br>
&gt;<br>
&gt;&gt;&gt; =A0 =A0c) Can the secadm_r role be the only role that can cont=
rol<br>
&gt;&gt; files used<br>
&gt;&gt;&gt; in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd=
 etc...<br>
&gt;<br>
&gt;&gt; auditadm_r:auditadm_t is only allowed to modify these files.<br>
&gt;<br>
&gt;&gt;&gt; 2) Is this better accomplished with a combination of SUDO and<=
br>
&gt; SELinux?<br>
&gt;&gt; Since sysadm_t can hack his way around the SELinux controls via to=
ols<br>
&gt;&gt; like rpm and fdisk, you are better off using sudo to further restr=
ict<br>
&gt;&gt; his actions, if possible.<br>
&gt;&gt;&gt; 3) How can I determine what secadm_r can do in the current<br>
&gt;&gt;&gt; configuration? can any of the CLI tools show me that? ( no gui=
 tools<br>
&gt;&gt;&gt; available )<br>
&gt;<br>
&gt;&gt; You probably want to look at secadm_t<br>
&gt;<br>
&gt;&gt; sesearch -A -t secadm_t<br>
&gt;<br>
&gt;&gt;&gt; If not, what about RHEL 6 ? ( I understand RHEL 6 is not avail=
able to<br>
&gt;&gt;&gt; Itanium systems, but we may have new hardware soon)<br>
&gt;<br>
&gt;&gt;&gt; Any tips. hints, pointers etc... would be very helpfull.<br>
&gt;<br>
&gt;&gt;&gt; Thanks for your time,<br>
&gt;<br>
&gt; Oops I misread the policy, =A0I guess we abandoned the separation.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ifdef(`enable_mls&#39;,`<br>
&gt;<br>
&gt; =A0userdom_security_administrator(secadm_t,secadm_r,{<br>
&gt; secadm_tty_device_t sysadm_devpts_t })<br>
&gt; # =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tunable_policy(`allow_sy=
sadm_manage_security&#39;,`<br>
&gt;<br>
&gt; =A0userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)<br=
>
&gt; # =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &#39;)<br>
&gt;<br>
&gt;<br>
&gt; Missed the &quot;#&quot; at the beginning of the lines. =A0So I don&#3=
9;t think we<br>
&gt; prevent sysadm_t from managing the security, of course he has to be ab=
le<br>
&gt; to run at SystemHigh.<br>
&gt;<br>
</div></div>One idea would be to build the separation into a separate modul=
e<br>
sysadm_secadm.pp then you could disable this module and take away the<br>
power of sysadm to do security administration. How important is this?<br>
<div class=3D"im">-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
</div>iEYEARECAAYFAk04RWcACgkQrlYvE4MpobNgkwCgrpfXVA3VACrLFueZjW6V5Gko<br>
YRsAoJsGGp76ODNFPSIhpl24h4D5KA6A<br>
=3DAe9m<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br>

--00163628354ed70bfd049a4a23c0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
