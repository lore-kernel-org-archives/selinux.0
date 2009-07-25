Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6PMO3lL027571
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 18:24:03 -0400
Received: from mail-fx0-f215.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6PMNbhF025820
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 22:23:38 GMT
Received: by fxm11 with SMTP id 11so2081841fxm.18
        for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 15:24:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1248559521.13970.29.camel@notebook2.grift.internal>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248553007.13970.3.camel@notebook2.grift.internal>
	 <81092d890907251359x4eb2914v3247c752d326e612@mail.gmail.com>
	 <1248556274.13970.11.camel@notebook2.grift.internal>
	 <81092d890907251431l534981ebva0cc7945d616175f@mail.gmail.com>
	 <1248558388.13970.21.camel@notebook2.grift.internal>
	 <81092d890907251454q100a854ck7091cc663aa312ed@mail.gmail.com>
	 <1248559521.13970.29.camel@notebook2.grift.internal>
Date: Sat, 25 Jul 2009 15:24:00 -0700
Message-ID: <81092d890907251524l53387082h2fe2e16fab896b21@mail.gmail.com>
Subject: Re: "Error! Unable to set executable context."
From: Larry Ross <selinux.larry@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364267d9704044046f8f2d9f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364267d9704044046f8f2d9f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Jul 25, 2009 at 3:05 PM, Dominick Grift <domg472@gmail.com> wrote:

>  On Sat, 2009-07-25 at 14:54 -0700, Larry Ross wrote:
> > On Sat, Jul 25, 2009 at 2:46 PM, Dominick Grift <domg472@gmail.com>
> > wrote:
> >
> >         On Sat, 2009-07-25 at 14:31 -0700, Larry Ross wrote:
> >         > On Sat, Jul 25, 2009 at 2:11 PM, Dominick Grift
> >         <domg472@gmail.com>
> >         > wrote:
> >         >
> >         >         On Sat, 2009-07-25 at 13:59 -0700, Larry Ross wrote:
> >         >         > On Sat, Jul 25, 2009 at 1:16 PM, Dominick Grift
> >         >         <domg472@gmail.com>
> >         >         > wrote:
> >         >         > On Sat, 2009-07-25 at 12:41 -0700, Larry Ross
> >         wrote:
> >         >         > > I am trying to create a custom selinux user for
> >         the strict
> >         >         policy on
> >         >         > > RHEL5.3
> >         >         > > I want logins that are mapped to this user to be
> >         able to
> >         >         login via
> >         >         > > gdm, but when they do I get an error "Error!
> >         Unable to set
> >         >         > executable
> >         >         > > context."
> >         >         > >
> >         >         > > What does this error message mean?
> >         >         > >
> >         >         > > I am able to login via gdm with logins that are
> >         mapped to
> >         >         user_u.  I
> >         >         > > have run the AVCs generated when I login in
> >         permissive
> >         >         mode (which
> >         >         > > succeeds) through audit2allow and gotten to the
> >         point
> >         >         where it
> >         >         > doesn't
> >         >         > > seem that I am getting any killer AVCs.  What am
> >         I missing
> >         >         that is
> >         >         > > needed for a custom user to use X-Windows?  Is
> >         there some
> >         >         place I
> >         >         > can
> >         >         > > look to determine what is causing the error?
> >         >         > >
> >         >         > >    Thank you,
> >         >         > >    Larry
> >         >         > >
> >         >         > > /var/log/messages:
> >         >         > >  Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm
> >         login:
> >         >         unable to
> >         >         > > obtain default security context for appuser.
> >         >         > >
> >         >         > >
> >         >         > >  /var/log/audit/audit.log:
> >         >         > > type=USER_AUTH msg=audit(1248550033.507:1432):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14022
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > authentication acct="?" :
> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=failed)'
> >         >         > > type=USER_LOGIN msg=audit(1248550033.507:1433):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14022
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         > > msg='acct=dbapp:
> >         >         exe="/usr/sbin/gdm-binary" (hostname=newhost,
> >         >         > > addr=127.0.0.1, terminal=:0 res=failed)'
> >         >         > > type=USER_AUTH msg=audit(1248550043.787:1434):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14022
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > authentication acct="appuser" :
> >         >         > > exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
> >         >         terminal=:0
> >         >         > > res=success)'
> >         >         > > type=USER_ACCT msg=audit(1248550043.789:1435):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14022
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > accounting acct="appuser" :
> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=success)'
> >         >         > > type=CRED_ACQ msg=audit(1248550043.790:1436):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14022
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > setcred acct="appuser" :
> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=success)'
> >         >         > > type=LOGIN msg=audit(1248550043.796:1437): login
> >         pid=3003
> >         >         uid=0 old
> >         >         > > auid=14022 new auid=14020 old ses=35 new ses=36
> >         >         > > type=USER_START msg=audit(1248550043.804:1438):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14020
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > session open acct="appuser" :
> >         >         > exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=success)'
> >         >         > > type=USER_LOGIN msg=audit(1248550043.804:1439):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14020
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         > msg='uid=14020:
> >         >         > > exe="/usr/sbin/gdm-binary" (hostname=newhost,
> >         >         addr=127.0.0.1,
> >         >         > > terminal=:0 res=success)'
> >         >         > > type=USER_END msg=audit(1248550092.461:1440):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14020
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > session close acct="appuser" :
> >         >         > exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=success)'
> >         >         > > type=CRED_DISP msg=audit(1248550092.461:1441):
> >         user
> >         >         pid=3003 uid=0
> >         >         > > auid=14020
> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
> >         >         msg='PAM:
> >         >         > > setcred acct="appuser" :
> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
> >         >         > > addr=?, terminal=:0 res=success)'
> >         >         > >
> >         >         >
> >         >         > Dominick,
> >         >         >   Thank you for your reply.
> >         >         >
> >         >         >         probably means you have no default
> >         contexts defined
> >         >         for
> >         >         >         "appuser"
> >         >         >
> >         >         > How do I define a default context for an selinux
> >         user?
> >         >
> >         >
> >         >         Well this is how a default contexts file looks for
> >         the user_u
> >         >         selinux
> >         >         user in fedora (targeted policy):
> >         >
> >         >         [root@notebook2 ~]#
> >         >         cat /etc/selinux/targeted/contexts/users/user_u
> >         >         system_r:local_login_t:s0       user_r:user_t:s0
> >         >         system_r:remote_login_t:s0      user_r:user_t:s0
> >         >         system_r:sshd_t:s0              user_r:user_t:s0
> >         >         system_r:crond_t:s0             user_r:user_t:s0
> >         >         system_r:xdm_t:s0               user_r:user_t:s0
> >         >         user_r:user_su_t:s0             user_r:user_t:s0
> >         >         user_r:user_sudo_t:s0           user_r:user_t:s0
> >         >         system_r:initrc_su_t:s0         user_r:user_t:s0
> >         >         user_r:user_t:s0                user_r:user_t:s0
> >         >
> >         > That looks like the information that is
> >         > in /etc/selinux/strict/contexts/default_contexts:
> >         > system_r:sulogin_t:s0   sysadm_r:sysadm_t:s0
> >         > system_r:local_login_t:s0       staff_r:staff_t:s0
> >         user_r:user_t:s0
> >         > sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0
> >         > system_r:remote_login_t:s0      user_r:user_t:s0
> >         staff_r:staff_t:s0
> >         > system_r:sshd_t:s0              user_r:user_t:s0
> >         staff_r:staff_t:s0
> >         > sysadm_r:sysadm_t:s0
> >         > system_r:crond_t:s0     user_r:user_crond_t:s0
> >         > staff_r:staff_crond_t:s0 sysadm_r:sysadm_crond_t:s0
> >         > system_r:system_crond_t:s0 mailman_r:user_crond_t:s0
> >         > system_r:xdm_t:s0               staff_r:staff_t:s0
> >         user_r:user_t:s0
> >         > sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0
> >         > staff_r:staff_su_t:s0   staff_r:staff_t:s0 user_r:user_t:s0
> >         > sysadm_r:sysadm_t:s0
> >         > sysadm_r:sysadm_su_t:s0 staff_r:staff_t:s0 user_r:user_t:s0
> >         > sysadm_r:sysadm_t:s0
> >         > user_r:user_su_t:s0     staff_r:staff_t:s0 user_r:user_t:s0
> >         > sysadm_r:sysadm_t:s0
> >         > sysadm_r:sysadm_sudo_t:s0       sysadm_r:sysadm_t:s0
> >         > staff_r:staff_sudo_t:s0 sysadm_r:sysadm_t:s0
> >         staff_r:staff_t:s0
> >         > user_r:user_sudo_t:s0   sysadm_r:sysadm_t:s0
> >         user_r:user_t:s0
> >         >
> >         >
> >         > I added app_user contexts into that file.  It isn't well
> >         documented,
> >         > so I may have done it wrong.
> >
> >
> >         i would try to add something like this:
> >
> >         system_r:local_login_t:s0       app_user_r:app_user_t:s0
> >         system_r:remote_login_t:s0      app_user_r:app_user_t:s0
> >         system_r:sshd_t:s0              app_user_r:app_user_t:s0
> >         system_r:crond_t:s0     app_user_r:app_user_crond_t:s0
> >         system_r:xdm_t:s0               app_user_r:app_user_t:s0
> >         app_user_r:app_user_su_t:s0     app_user_r:app_user_t:s0
> >         app_user_r:app_user_sudo_t:s0   app_user_r:app_user_t:s0
> >
> >         maybe also:
> >
> >         app_user_r:app_user_t:s0
> >          app_user_r:app_user_t:s0
> >
> >         or maybe just append the second column on the rows that also
> >         have user_t
> >         above.
> >
> >         like for example:
> >
> >         system_r:local_login_t:s0       staff_r:staff_t:s0
> >         user_r:user_t:s0
> >
> >         app_user_r:app_user_t:s0
> >
> > I thought I had done that, but I see now I missed a few.  I appended
> > the app_user contexts to the rows in default_contexts and tried it
> > without success.  Is there something I have to do to make the new
> > default_contexts active?  Do I have to reboot the machine?
>
> No you should not have to do anything else afaik.
> Unfortunately my experience with el5 is very limited.
> I kind of ran out of suggestions.
>
> You might also check
> the /etc/pam.d/gdm, /etc/pam.d/sshd, /etc/pam.d/login to see if they
> have pam_selinux entries, but i do not think this is related since your
> user_u and other logins work
>
> Have a good look at /etc/selinux/strict, see if you can find some clues.
> It may also be that your app_user_t policy has errors.


That is true.  That it why I asked the original question about what this
error means.  What is an "executable context" that the error is referring
to?  It looks like it is scanning through the default_contexts looking for
one that it can transition to.  Could it be that there is no rule that
allows it to transition from its current context (which I think is xdm_t) to
app_user_t?  Or am I misunderstanding it?



> Hopefully others can add more suggestions. Although its weekend now so
> may be a while.


 I realize that and thank you for your time.

Just realized that I have been replying to you directly, I meant to leave
the whole discussion on the group.  Hopefully it hasn't been too mangled.



>
> >
> >
> >
> >         >
> >         >
> >
> >
> >         >         >         can you show us the output of 'semanage
> >         user -l |
> >         >         grep
> >         >         >         appuser'?
> >         >         >
> >         >         > [root@newhost ~]# semanage user -l | grep appuser
> >         >         >
> >         >         > returns no results, as I would expect, appuser is
> >         a linux
> >         >         login id,
> >         >         > not an selinux user.
> >         >         >
> >         >         > [root@newhost ~]# semanage login -l | grep appuser
> >         >         > appuser                   app_user_u
> >         s0
> >         >
> >         >
> >         >         semanage user -l | grep app_user_u
> >         >
> >         > [root@newhost ~]# semanage user -l | grep app_user_u
> >         > app_user_u       app_user    s0         s0
> >         > app_user_r
> >         >
> >         >
> >         >
> >         >
> >         >         >
> >         >         >
> >         >         >         If this user is based of off user_u you
> >         could
> >         >         simply:
> >         >         >
> >         >         >
> >         >
> >         cp /etc/selinux/contexts/users/user_u
> /etc/selinux/contexts/users/appuser
> >         >         >
> >         >         >         but it depends on how your appuser
> >         selinux-user is
> >         >         configured
> >         >         >         ( whats
> >         >         >         his default domain )
> >         >         >
> >         >         > The only thing
> >         in /etc/selinux/strict/contexts/users/
> >         >         > is "root", there is no file there for user_u.
> >         >
> >         >
> >         >         That's weird, i would expect default contexts be
> >         defined since
> >         >         you
> >         >         stated that your user_u login works. Maybe it is
> >         stored in a
> >         >         different
> >         >         location in el5.
> >         >
> >         >         See if you can locate a file called user_u or any
> >         other file
> >         >         that may
> >         >         have similar entries as i pasted above in
> >         >         you /etc/selinux/strict/contexts (and /users).
> >         >
> >         > see above.
> >         >
> >         >
> >         >
> >         >         >
> >         >         >   -- Larry
> >         >         >
> >         >
> >
> >
>

--0016364267d9704044046f8f2d9f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Sat, Jul 25, 2009 at 3:05 PM, Dominick Grift =
<span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">domg472@gmail.co=
m</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Sat, 2009-07-25 at 14:54 -0700, Larry Ross wrote:<br>&=
gt; On Sat, Jul 25, 2009 at 2:46 PM, Dominick Grift &lt;<a href=3D"mailto:d=
omg472@gmail.com">domg472@gmail.com</a>&gt;<br>&gt; wrote:<br>&gt;<br>&gt; =
=A0 =A0 =A0 =A0 On Sat, 2009-07-25 at 14:31 -0700, Larry Ross wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Sat, Jul 25, 2009 at 2:11 PM, Dominick Grift<b=
r>&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:domg472@gmail.com">domg472@gma=
il.com</a>&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; wrote:<br>&gt; =A0 =A0 =A0 =A0 =
&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 On Sat, 2009-07-25 at 13:=
59 -0700, Larry Ross wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; On Sat, Jul 25, 2009 at 1:16=
 PM, Dominick Grift<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &lt;<a hre=
f=3D"mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; wrote:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 &gt; On Sat, 2009-07-25 at 12:41 -0700, Larry Ross<br>
&gt; =A0 =A0 =A0 =A0 wrote:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &g=
t; &gt; I am trying to create a custom selinux user for<br>&gt; =A0 =A0 =A0=
 =A0 the strict<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 policy on<br>&=
gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; RHEL5.3<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; I want logins that are =
mapped to this user to be<br>&gt; =A0 =A0 =A0 =A0 able to<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 login via<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0=
 =A0 =A0 &gt; &gt; gdm, but when they do I get an error &quot;Error!<br>
&gt; =A0 =A0 =A0 =A0 Unable to set<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0=
 =A0 &gt; executable<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;=
 context.&quot;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>&=
gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; What does this error mes=
sage mean?<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>&gt; =A0 =A0 =A0 =A0=
 &gt; =A0 =A0 =A0 =A0 &gt; &gt; I am able to login via gdm with logins that=
 are<br>&gt; =A0 =A0 =A0 =A0 mapped to<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0=
 =A0 =A0 user_u. =A0I<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt=
; have run the AVCs generated when I login in<br>
&gt; =A0 =A0 =A0 =A0 permissive<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 mode (which<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; succ=
eeds) through audit2allow and gotten to the<br>&gt; =A0 =A0 =A0 =A0 point<b=
r>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 where it<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt; doesn&#39;t<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; seem that I am getting =
any killer AVCs. =A0What am<br>&gt; =A0 =A0 =A0 =A0 I missing<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 that is<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 &gt; &gt; needed for a custom user to use X-Windows? =A0Is<br>
&gt; =A0 =A0 =A0 =A0 there some<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 place I<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; can<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; look to determine what is ca=
using the error?<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0Thank you,<br>&g=
t; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0Larry<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0=
 =A0 =A0 =A0 &gt; &gt; /var/log/messages:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 &gt; &gt; =A0Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm<br>
&gt; =A0 =A0 =A0 =A0 login:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 un=
able to<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; obtain defau=
lt security context for appuser.<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 &gt; &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0/var/log/audit/audit=
.log:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; type=3DUSER_AU=
TH msg=3Daudit(1248550033.507:1432):<br>&gt; =A0 =A0 =A0 =A0 user<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0=
 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=3D14022<br>
&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; authentication acct=3D&quot;?&quot; :<br=
>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 exe=3D&quot;/usr/sbin/gdm-binary=
&quot; (hostname=3D?,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; addr=3D?, terminal=3D:0=
 res=3Dfailed)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =
type=3DUSER_LOGIN msg=3Daudit(1248550033.507:1433):<br>&gt; =A0 =A0 =A0 =A0=
 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=3D3003 uid=3D0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=3D14022<br>&gt; =
=A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; msg=3D&#39;acct=3Ddbapp:<br>&gt;=
 =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 exe=3D&quot;/usr/sbin/gdm-binary&quot=
; (hostname=3Dnewhost,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; addr=3D127.0.0.1, termi=
nal=3D:0 res=3Dfailed)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &g=
t; &gt; type=3DUSER_AUTH msg=3Daudit(1248550043.787:1434):<br>&gt; =A0 =A0 =
=A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=3D3003 uid=3D=
0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=3D14022<br>&gt; =
=A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =A0 =A0 =A0 =A0 &g=
t; =A0 =A0 =A0 =A0 &gt; &gt; authentication acct=3D&quot;appuser&quot; :<br=
>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; exe=3D&quot;/usr/sbin/g=
dm-binary&quot; (hostname=3D?, addr=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 terminal=3D:0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
 &gt; res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
 &gt; type=3DUSER_ACCT msg=3Daudit(1248550043.789:1435):<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14022<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; accounting acct=3D&quot;appu=
ser&quot; :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 exe=3D&quot;/usr/sbin/gdm-binary&=
quot; (hostname=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;=
 addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; &gt; type=3DCRED_ACQ msg=3Daudit(1248550043.790:1436):=
<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14022<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; setcred acct=3D&quot;appuser=
&quot; :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 exe=3D&quot;/usr/sbin/gdm-binary&=
quot; (hostname=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;=
 addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; &gt; type=3DLOGIN msg=3Daudit(1248550043.796:1437): lo=
gin<br>
&gt; =A0 =A0 =A0 =A0 pid=3D3003<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 uid=3D0 old<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14022 new auid=3D14020 old ses=3D35 new ses=3D36<br>&gt; =A0 =A0 =A0 =A0=
 &gt; =A0 =A0 =A0 =A0 &gt; &gt; type=3DUSER_START msg=3Daudit(1248550043.80=
4:1438):<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14020<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; session open acct=3D&quot;ap=
puser&quot; :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; exe=3D&quot;/usr/sbin/gdm-bi=
nary&quot; (hostname=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
 &gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &=
gt; =A0 =A0 =A0 =A0 &gt; &gt; type=3DUSER_LOGIN msg=3Daudit(1248550043.804:=
1439):<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14020<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; msg=3D&#39;uid=3D1402=
0:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; exe=3D&quot;/usr/sbin/g=
dm-binary&quot; (hostname=3Dnewhost,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =
=A0 =A0 addr=3D127.0.0.1,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
 &gt; terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 &gt; &gt; type=3DUSER_END msg=3Daudit(1248550092.461:1440):<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14020<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; session close acct=3D&quot;a=
ppuser&quot; :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; exe=3D&quot;/usr/sbin/gdm-bi=
nary&quot; (hostname=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
 &gt; addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &=
gt; =A0 =A0 =A0 =A0 &gt; &gt; type=3DCRED_DISP msg=3Daudit(1248550092.461:1=
441):<br>
&gt; =A0 =A0 =A0 =A0 user<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pid=
=3D3003 uid=3D0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; auid=
=3D14020<br>&gt; =A0 =A0 =A0 =A0 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1=
023<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 msg=3D&#39;PAM:<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; setcred acct=3D&quot;appuser=
&quot; :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 exe=3D&quot;/usr/sbin/gdm-binary&=
quot; (hostname=3D?,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;=
 addr=3D?, terminal=3D:0 res=3Dsuccess)&#39;<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;=
<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Dominick,<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 Thank you for your reply.<br>&gt; =A0=
 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0=
 =A0 =A0 &gt; =A0 =A0 =A0 =A0 probably means you have no default<br>&gt; =
=A0 =A0 =A0 =A0 contexts defined<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 for<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &quot;appuser&quot;<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 &gt; How do I define a default context for an selinux<br>&gt; =A0 =A0 =
=A0 =A0 user?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 Well this is how a default contexts file looks for=
<br>&gt; =A0 =A0 =A0 =A0 the user_u<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =
=A0 =A0 selinux<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 user in fedora=
 (targeted policy):<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 [roo=
t@notebook2 ~]#<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 cat /etc/selin=
ux/targeted/contexts/users/user_u<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 system_r:local_login_t:s0 =A0 =A0 =A0 user_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 system_r:remote_login_t:s0 =A0 =
=A0 =A0user_r:user_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 system=
_r:sshd_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user_r:user_t:s0<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 system_r:crond_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 us=
er_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 system_r:xdm_t:s0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 user_r:user_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =
user_r:user_su_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 user_r:user_t:s0<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 user_r:user_sudo_t:s0 =A0 =A0 =A0 =A0 =A0 =
user_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 system_r:initrc_su_t:s0 =A0 =A0 =
=A0 =A0 user_r:user_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 user_=
r:user_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user_r:user_t:s0<br>&gt; =A0 =A0=
 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; That looks like the information =
that is<br>
&gt; =A0 =A0 =A0 =A0 &gt; in /etc/selinux/strict/contexts/default_contexts:=
<br>&gt; =A0 =A0 =A0 =A0 &gt; system_r:sulogin_t:s0 =A0 sysadm_r:sysadm_t:s=
0<br>&gt; =A0 =A0 =A0 =A0 &gt; system_r:local_login_t:s0 =A0 =A0 =A0 staff_=
r:staff_t:s0<br>&gt; =A0 =A0 =A0 =A0 user_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0<br>=
&gt; =A0 =A0 =A0 =A0 &gt; system_r:remote_login_t:s0 =A0 =A0 =A0user_r:user=
_t:s0<br>&gt; =A0 =A0 =A0 =A0 staff_r:staff_t:s0<br>&gt; =A0 =A0 =A0 =A0 &g=
t; system_r:sshd_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 staff_r:staff_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; sysadm=
_r:sysadm_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; system_r:crond_t:s0 =A0 =A0 use=
r_r:user_crond_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; staff_r:staff_crond_t:s0 s=
ysadm_r:sysadm_crond_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; system_r:system_cron=
d_t:s0 mailman_r:user_crond_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; system_r:xdm_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta=
ff_r:staff_t:s0<br>&gt; =A0 =A0 =A0 =A0 user_r:user_t:s0<br>&gt; =A0 =A0 =
=A0 =A0 &gt; sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0<br>&gt; =A0 =A0 =
=A0 =A0 &gt; staff_r:staff_su_t:s0 =A0 staff_r:staff_t:s0 user_r:user_t:s0<=
br>
&gt; =A0 =A0 =A0 =A0 &gt; sysadm_r:sysadm_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 sysadm_r:sysadm_su_t:s0 staff_r:staff_t:s0 user_r:user_t:s0<br>&gt; =A0 =
=A0 =A0 =A0 &gt; sysadm_r:sysadm_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; user_r:u=
ser_su_t:s0 =A0 =A0 staff_r:staff_t:s0 user_r:user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 &gt; sysadm_r:sysadm_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 sysadm_r:sysadm_sudo_t:s0 =A0 =A0 =A0 sysadm_r:sysadm_t:s0<br>&gt; =A0 =A0=
 =A0 =A0 &gt; staff_r:staff_sudo_t:s0 sysadm_r:sysadm_t:s0<br>&gt; =A0 =A0 =
=A0 =A0 staff_r:staff_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt; user_r:user_sudo_t:=
s0 =A0 sysadm_r:sysadm_t:s0<br>
&gt; =A0 =A0 =A0 =A0 user_r:user_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =
=A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; I added app_user contexts=
 into that file. =A0It isn&#39;t well<br>&gt; =A0 =A0 =A0 =A0 documented,<b=
r>&gt; =A0 =A0 =A0 =A0 &gt; so I may have done it wrong.<br>
&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 i would try to add something like this=
:<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 system_r:local_login_t:s0 =A0 =A0 =A0 app=
_user_r:app_user_t:s0<br>&gt; =A0 =A0 =A0 =A0 system_r:remote_login_t:s0 =
=A0 =A0 =A0app_user_r:app_user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 system_r:sshd_t:s0 =A0 =A0 =A0 =A0 =A0 =A0 =A0app_user=
_r:app_user_t:s0<br>&gt; =A0 =A0 =A0 =A0 system_r:crond_t:s0 =A0 =A0 app_us=
er_r:app_user_crond_t:s0<br>&gt; =A0 =A0 =A0 =A0 system_r:xdm_t:s0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 app_user_r:app_user_t:s0<br>&gt; =A0 =A0 =A0 =A0 app_us=
er_r:app_user_su_t:s0 =A0 =A0 app_user_r:app_user_t:s0<br>
&gt; =A0 =A0 =A0 =A0 app_user_r:app_user_sudo_t:s0 =A0 app_user_r:app_user_=
t:s0<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 maybe also:<br>&gt;<br>&gt; =A0 =A0 =
=A0 =A0 app_user_r:app_user_t:s0<br>&gt; =A0 =A0 =A0 =A0 =A0app_user_r:app_=
user_t:s0<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 or maybe just append the second c=
olumn on the rows that also<br>
&gt; =A0 =A0 =A0 =A0 have user_t<br>&gt; =A0 =A0 =A0 =A0 above.<br>&gt;<br>=
&gt; =A0 =A0 =A0 =A0 like for example:<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 syst=
em_r:local_login_t:s0 =A0 =A0 =A0 staff_r:staff_t:s0<br>&gt; =A0 =A0 =A0 =
=A0 user_r:user_t:s0<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 app_user_r:app_user_t:=
s0<br>
&gt;<br>&gt; I thought I had done that, but I see now I missed a few. =A0I =
appended<br>&gt; the app_user contexts to the rows in default_contexts and =
tried it<br>&gt; without success. =A0Is there something I have to do to mak=
e the new<br>
&gt; default_contexts active? =A0Do I have to reboot the machine?<br><br></=
div></div>No you should not have to do anything else afaik.<br>Unfortunatel=
y my experience with el5 is very limited.<br>I kind of ran out of suggestio=
ns.<br>
<br>You might also check<br>the /etc/pam.d/gdm, /etc/pam.d/sshd, /etc/pam.d=
/login to see if they<br>have pam_selinux entries, but i do not think this =
is related since your<br>user_u and other logins work<br><br>Have a good lo=
ok at /etc/selinux/strict, see if you can find some clues.<br>
It may also be that your app_user_t policy has errors.</blockquote>
<div>=A0</div>
<div>That is true.=A0 That it why I asked the original question about what =
this error means.=A0 What is an &quot;executable context&quot; that the err=
or is referring to?=A0 It looks like it is scanning through the default_con=
texts looking for one that it can transition to.=A0 Could it be that there =
is no rule that allows it to transition from its current context (which I t=
hink is xdm_t) to app_user_t?=A0 Or am I misunderstanding it?</div>

<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hopefully others can add more su=
ggestions. Although its weekend now so<br>may be a while.</blockquote>
<div>=A0</div>
<div>=A0I realize that and thank you for your time.=A0</div>
<div>=A0</div>
<div>Just realized that I have been replying to you directly, I meant to le=
ave the whole discussion on the group.=A0 Hopefully it hasn&#39;t been too =
mangled.</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class=3D"h5"><span id=3D""></span><br>&gt;<br>&gt;<br>&gt;<br>&gt; =A0=
 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt;<br>&gt;<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 can you show us the o=
utput of &#39;semanage<br>&gt; =A0 =A0 =A0 =A0 user -l |<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 grep<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 appuser&#39;?<br>&gt; =A0 =A0 =A0 =A0=
 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt=
; [root@newhost ~]# semanage user -l | grep appuser<br>&gt; =A0 =A0 =A0 =A0=
 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; returns no results, as I wou=
ld expect, appuser is<br>&gt; =A0 =A0 =A0 =A0 a linux<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 login id,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0=
 =A0 &gt; not an selinux user.<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0=
 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; [root@newhost ~]# semanage l=
ogin -l | grep appuser<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; ap=
puser =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 app_user_u<br>&gt; =A0 =A0 =A0 =
=A0 s0<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 semanage user -l | grep app_user_u<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; [root@newhost ~]# se=
manage user -l | grep app_user_u<br>&gt; =A0 =A0 =A0 =A0 &gt; app_user_u =
=A0 =A0 =A0 app_user =A0 =A0s0 =A0 =A0 =A0 =A0 s0<br>&gt; =A0 =A0 =A0 =A0 &=
gt; app_user_r<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br=
>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =
&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 If t=
his user is based of off user_u you<br>&gt; =A0 =A0 =A0 =A0 could<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 simply:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 =
cp /etc/selinux/contexts/users/user_u /etc/selinux/contexts/users/appuser<b=
r>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &g=
t; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 but it depends on how your appuser<=
br>
&gt; =A0 =A0 =A0 =A0 selinux-user is<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =
=A0 =A0 configured<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 ( whats<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0 =A0 =A0 his default domain )<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; The only thing<b=
r>
&gt; =A0 =A0 =A0 =A0 in /etc/selinux/strict/contexts/users/<br>&gt; =A0 =A0=
 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; is &quot;root&quot;, there is no file th=
ere for user_u.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<b=
r>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 That&#39;s weird, i would expec=
t default contexts be<br>
&gt; =A0 =A0 =A0 =A0 defined since<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0=
 =A0 you<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 stated that your user=
_u login works. Maybe it is<br>&gt; =A0 =A0 =A0 =A0 stored in a<br>&gt; =A0=
 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 different<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 location in el5.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 See =
if you can locate a file called user_u or any<br>&gt; =A0 =A0 =A0 =A0 other=
 file<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 that may<br>&gt; =A0 =A0=
 =A0 =A0 &gt; =A0 =A0 =A0 =A0 have similar entries as i pasted above in<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 you /etc/selinux/strict/contexts =
(and /users).<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; see=
 above.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =
=A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 -- Larry<br>&gt; =A0 =A0=
 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt;<br>=
&gt;<br></div></div></blockquote></div><br>

--0016364267d9704044046f8f2d9f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
