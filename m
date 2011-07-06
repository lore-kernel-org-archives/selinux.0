Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66Dxk2V026288
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 09:59:46 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p66Dxixw000198
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 13:59:44 GMT
Received: by wwf22 with SMTP id 22so5529733wwf.30
        for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2011 06:59:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309932598.2498.28.camel@localhost.localdomain>
References: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
	<1309932598.2498.28.camel@localhost.localdomain>
Date: Wed, 6 Jul 2011 08:59:42 -0500
Message-ID: <CAJstirRb7dTEpk0eq+xP_HNBwfEcZ4BF6ftXBrtDLT50JQktHg@mail.gmail.com>
Subject: Re: Best base policy to use
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0cd3b54e22a5df04a76703e1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd3b54e22a5df04a76703e1
Content-Type: text/plain; charset=ISO-8859-1

Thanks, this approach sounds pretty good to me.  On my last systems I used
an audit_admin and sec_admin, in addition to a number of other roles. I
looked VERY briefly at the mls policy, but I think it might be a little too
much for what I want, which is basically requiring 3 different roles to
manage a machine, and 3 additional roles to manage/use certain services.

semanage  makes persistent changes to a system, correct? I'm still uncertain
of the best way to modify a module, or at least make one less permissive.
would it be to remove or disable a module, get the source, modify it, rename
it, and then import it over the old one? for example lets say I didn't want
rpm_script_t to be able to transition into initrc_t, no matter what role it
started as. Or, I don't want the sysadm_t to be able to do both run_init_t
and rpm_t. Or am I completely in left field and not understanding the proper
use of roles?

On Wed, Jul 6, 2011 at 1:09 AM, Dominick Grift <domg472@gmail.com> wrote:

>
>
> On Tue, 2011-07-05 at 17:11 -0500, Jeremiah Jahn wrote:
> > So I'm in the process of Upgrading my servers from RHEL5 to RHEL6. On my
> > RHEL5 system I had to build the reference policy from scratch in order to
> > prevent users from being able to  transition to init_t through initrc_t.
> > Basically, I want systems that have to be rebooted in order to restart
> > certain services, like auditd, or at least be able to split those duties
> > into different roles. One role can edit a file or install something, but
> a
> > different role must restart it. Because life the universe and everything
> > goes through initrc_t, just about anything on the system running as root
> can
> > mess with services. I'd like to highly limit things, and haven't  really
> > looked at any new developments in selinux for about 4 years. What's the
> best
> > way/place to start removing domain transitions and requiring additional
> > roles.
>
> Main difference between el5 and el6 policy is that el6 policy is a
> hybrid policy of the old targeted and strict policy. (strict policy was
> merged into targeted policy)
>
> You  can now tune your policy to make it behave like the old strict
> policy by removing or disabling the unconfined and unconfineduser
> modules.
>
> In Redhat policy only unconfined_t can transition directly to initrc.
> Sysadm_t needs to use run_init to transition to initrc_t in the system_r
> role.
>
> el6 policy allows you to easily create new roles.
>
> So what you could do in my view is, disable or remove both unconfined
> and unconfineduser modules and then create your own roles, selinux user
> identities and logins.
>

> In that regard el6 policy has pretty much the same properties as current
> reference policy.
>
> > thanks,
> > -jj-
>

--000e0cd3b54e22a5df04a76703e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks, this approach sounds pretty good to me.=A0 On my last systems I use=
d an audit_admin and sec_admin, in addition to a number of other roles. I l=
ooked VERY briefly at the mls policy, but I think it might be a little too =
much for what I want, which is basically requiring 3 different roles to man=
age a machine, and 3 additional roles to manage/use certain services.<br>

<br>
semanage=A0 makes persistent changes to a system, correct? I&#39;m still un=
certain of the best way to modify a module, or at least make one less permi=
ssive. would it be to remove or disable a module, get the source, modify it=
, rename it, and then import it over the old one? for example lets say I di=
dn&#39;t want rpm_script_t to be able to transition into initrc_t, no matte=
r what role it started as. Or, I don&#39;t want the sysadm_t to be able to =
do both run_init_t and rpm_t. Or am I completely in left field and not unde=
rstanding the proper use of roles?<br>
<br><div class=3D"gmail_quote">On Wed, Jul 6, 2011 at 1:09 AM, Dominick Gri=
ft <span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">domg472@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding=
-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
<br>
On Tue, 2011-07-05 at 17:11 -0500, Jeremiah Jahn wrote:<br>
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
ot can<br>
&gt; mess with services. I&#39;d like to highly limit things, and haven&#39=
;t =A0really<br>
&gt; looked at any new developments in selinux for about 4 years. What&#39;=
s the best<br>
&gt; way/place to start removing domain transitions and requiring additiona=
l<br>
&gt; roles.<br>
<br>
</div></div>Main difference between el5 and el6 policy is that el6 policy i=
s a<br>
hybrid policy of the old targeted and strict policy. (strict policy was<br>
merged into targeted policy)<br>
<br>
You =A0can now tune your policy to make it behave like the old strict<br>
policy by removing or disabling the unconfined and unconfineduser<br>
modules.<br>
<br>
In Redhat policy only unconfined_t can transition directly to initrc.<br>
Sysadm_t needs to use run_init to transition to initrc_t in the system_r<br=
>
role.<br>
<br>
el6 policy allows you to easily create new roles.<br>
<br>
So what you could do in my view is, disable or remove both unconfined<br>
and unconfineduser modules and then create your own roles, selinux user<br>
identities and logins. <br></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">
<br>
In that regard el6 policy has pretty much the same properties as current<br=
>
reference policy.<br>
<br>
&gt; thanks,<br>
&gt; -jj-<br>
</blockquote></div><br>

--000e0cd3b54e22a5df04a76703e1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
