Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66EERDe027568
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 10:14:27 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p66EEPxw004494
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 14:14:26 GMT
Received: by wwf22 with SMTP id 22so5542217wwf.30
        for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2011 07:14:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201107061810.56632.russell@coker.com.au>
References: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
	<201107061810.56632.russell@coker.com.au>
Date: Wed, 6 Jul 2011 09:14:25 -0500
Message-ID: <CAJstirQphEFdqC6BVWq=cycjcnJnVj_bduDzXMgh4LGbiujxAA@mail.gmail.com>
Subject: Re: Best base policy to use
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0016364d2c79b884a004a7673747
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364d2c79b884a004a7673747
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jul 6, 2011 at 3:10 AM, Russell Coker <russell@coker.com.au> wrote:

> On Wed, 6 Jul 2011, Jeremiah Jahn <jeremiah@goodinassociates.com> wrote:
> > So I'm in the process of Upgrading my servers from RHEL5 to RHEL6. On my
> > RHEL5 system I had to build the reference policy from scratch in order to
> > prevent users from being able to  transition to init_t through initrc_t.
> > Basically, I want systems that have to be rebooted in order to restart
> > certain services, like auditd, or at least be able to split those duties
> > into different roles. One role can edit a file or install something, but
> a
> > different role must restart it. Because life the universe and everything
> > goes through initrc_t, just about anything on the system running as root
> > can mess with services. I'd like to highly limit things, and
> > haven't  really looked at any new developments in selinux for about 4
> > years. What's the best way/place to start removing domain transitions and
> > requiring additional roles.
>
> When you are talking about "just about anything on the system running as
> root"
> are you referring to processes run as part of a system start script or a
> root
> login shell?
>

rpm script, when battening down the hatches on EL5 most of the modules could
be changed fairly easy to handle an auditadm, secadm, sysadm in the ref
policy, but it was a pain to limit sysadm due to it being able to transition
to both rpm_t AND initrc_t, because if you can get to one, you can get to
the other. My question is really what is the best way to remove transitions
without trying to build the policy from modified source. The old ref policy
wasn't quite strict enough. My EL5 systems are so locked down, the services
cannot be restarted without a reboot from the physical console and some usb
drives. It takes 3 people to do anything. It's rough, but we sleep pretty
well at night.


>
> In the former case if you want to prevent the init.d script from daemon A
> from
> messing with daemon B (which is a real concern as some of the init.d
> scripts
> access data written by the daemon and could potentially be subverted) then
> one
> option would be to have the init.d script run in the context of the daemon.
>
> In the latter case you could prevent a transition from sysadm_t to initrc_t
> without significant modifications to the policy, but you still need ways
> for
> the sysadm to restart daemons.
>




>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>

--0016364d2c79b884a004a7673747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 6, 2011 at 3:10 AM, Russell =
Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au">russell=
@coker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Wed, 6 Jul 2011, Jeremiah Jahn &lt;<a =
href=3D"mailto:jeremiah@goodinassociates.com">jeremiah@goodinassociates.com=
</a>&gt; wrote:<br>
&gt; So I&#39;m in the process of Upgrading my servers from RHEL5 to RHEL6.=
 On my<br>
&gt; RHEL5 system I had to build the reference policy from scratch in order=
 to<br>
&gt; prevent users from being able to =A0transition to init_t through initr=
c_t.<br>
&gt; Basically, I want systems that have to be rebooted in order to restart=
<br>
&gt; certain services, like auditd, or at least be able to split those duti=
es<br>
&gt; into different roles. One role can edit a file or install something, b=
ut a<br>
&gt; different role must restart it. Because life the universe and everythi=
ng<br>
&gt; goes through initrc_t, just about anything on the system running as ro=
ot<br>
&gt; can mess with services. I&#39;d like to highly limit things, and<br>
&gt; haven&#39;t =A0really looked at any new developments in selinux for ab=
out 4<br>
&gt; years. What&#39;s the best way/place to start removing domain transiti=
ons and<br>
&gt; requiring additional roles.<br>
<br>
</div></div>When you are talking about &quot;just about anything on the sys=
tem running as root&quot;<br>
are you referring to processes run as part of a system start script or a ro=
ot<br>
login shell?<br></blockquote><div><br>rpm script, when battening down the h=
atches on EL5 most of the modules could be changed fairly easy to handle an=
 auditadm, secadm, sysadm in the ref policy, but it was a pain to limit sys=
adm due to it being able to transition to both rpm_t AND initrc_t, because =
if you can get to one, you can get to the other. My question is really what=
 is the best way to remove transitions without trying to build the policy f=
rom modified source. The old ref policy wasn&#39;t quite strict enough. My =
EL5 systems are so locked down, the services cannot be restarted without a =
reboot from the physical console and some usb drives. It takes 3 people to =
do anything. It&#39;s rough, but we sleep pretty well at night.<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
In the former case if you want to prevent the init.d script from daemon A f=
rom<br>
messing with daemon B (which is a real concern as some of the init.d script=
s<br>
access data written by the daemon and could potentially be subverted) then =
one<br>
option would be to have the init.d script run in the context of the daemon.=
<br>
<br>
In the latter case you could prevent a transition from sysadm_t to initrc_t=
<br>
without significant modifications to the policy, but you still need ways fo=
r<br>
the sysadm to restart daemons.<br></blockquote><div><br><br>=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left=
: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<font color=3D"#888888"><br>
--<br>
My Main Blog =A0 =A0 =A0 =A0 <a href=3D"http://etbe.coker.com.au/" target=
=3D"_blank">http://etbe.coker.com.au/</a><br>
My Documents Blog =A0 =A0<a href=3D"http://doc.coker.com.au/" target=3D"_bl=
ank">http://doc.coker.com.au/</a><br>
</font></blockquote></div><br>

--0016364d2c79b884a004a7673747--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
