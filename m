MIME-Version: 1.0
In-Reply-To: <4AF482CA.4090109@tycho.nsa.gov>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
	 <4AF482CA.4090109@tycho.nsa.gov>
Date: Fri, 6 Nov 2009 12:39:57 -0800
Message-ID: <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
Subject: Re: "security_compute_sid: invalid context" error when
	starting/stopping mysqld daemon
From: Larry Ross <selinux.larry@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504501634bd736450477b9d810
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504501634bd736450477b9d810
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:

>  On 11/04/2009 06:57 PM, Larry Ross wrote:
> > I have two selinux users that need to be able to stop and start the
> > mysql daemon, which is started by the initialization scripts.  When
> > the daemon is stopped and started by the secadm_u user, it ends up in
> > the context secadm_u:secadm_r:mysqld_t.  When it is stopped and
> > started by the dbadm_u user, it ends up in the
> > dbadm_u:dbadm_r:mysqld_t context.  When it is started by the init
> > scripts it ends up in the system_u:system_r:mysqld_t domain.
> >
> > I would like it to alway end up in the system_r:mysqld_t domain, but
> > can't seem to find any documentation that describes how to get that to
> > work.
> >
> > If I add a role_transition rule to transition the role to system_r
> > when the executable is run:
> > role_transition sysadm_r mysqld_safe_exec_t system_r;
> > role_transition dbadm_r  mysqld_safe_exec_t system_r;
> > I end up getting these errors:
> >
> > Nov  4 15:41:36 localhost kernel: type=1401 audit(1257378096.775:46):
> > security_compute_sid:  invalid context
> > dbadm_u:system_r:mysqld_safe_t:s0 for
> > scontext=dbadm_u:dbadm_r:initrc_t:s0
> > tcontext=system_u:object_r:mysqld_safe_exec_t:s0 tclass=process
> >
> > I believe I have the rules that should allow this, but obviously I am
> > missing something.
> > role dbadm_r types mysqld_safe_t;
> > role sysadm_r types mysqld_safe_t;
> > role system_r types mysqld_safe_t;
> > and this:
> > allow initrc_t mysqld_safe_t : process transition ;
> > which is what the "security_compute_sid" message looks like it is
> missing.
> >
> > Does anyone know where I can find a good description of how to get a
> > service to transistion back into system_r when started by a user or
> > have any idea what I am missing?
>
>
> The run_init program was designed to solve this problem, take a look at
> the man page.
>
> On Fedora at least, the "service" command calls run_init internally, so
> doing "service mysqld start" should in theory start it up in the
> system_r role.  If you're just running "/etc/init.d/mysld start" it
> won't transition.
>
That would be great, but I am trying to use this as normal users on a system
to which the root account is locked.  As far as I know, run_init always asks
for the root password.  Is there a way to use it without having access to
the root password?

BTW, I am using RHEL 5.3, do you know if service there calls run_init
internally?

  Thank you,
  Larry



>
>
> --
>
> Eamon Walsh
> National Security Agency
>
>

--00504501634bd736450477b9d810
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:ewalsh@tycho.nsa.gov">ewalsh@tycho.nsa=
.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On 11/04/2009 06:57 PM, Larry Ross wrote:<br>&gt; I have =
two selinux users that need to be able to stop and start the<br>&gt; mysql =
daemon, which is started by the initialization scripts. =A0When<br>&gt; the=
 daemon is stopped and started by the secadm_u user, it ends up in<br>
&gt; the context secadm_u:secadm_r:mysqld_t. =A0When it is stopped and<br>&=
gt; started by the dbadm_u user, it ends up in the<br>&gt; dbadm_u:dbadm_r:=
mysqld_t context. =A0When it is started by the init<br>&gt; scripts it ends=
 up in the system_u:system_r:mysqld_t domain.<br>
&gt;<br>&gt; I would like it to alway end up in the system_r:mysqld_t domai=
n, but<br>&gt; can&#39;t seem to find any documentation that describes how =
to get that to<br>&gt; work.<br>&gt;<br>&gt; If I add a role_transition rul=
e to transition the role to system_r<br>
&gt; when the executable is run:<br>&gt; role_transition sysadm_r mysqld_sa=
fe_exec_t system_r;<br>&gt; role_transition dbadm_r =A0mysqld_safe_exec_t s=
ystem_r;<br>&gt; I end up getting these errors:<br>&gt;<br>&gt; Nov =A04 15=
:41:36 localhost kernel: type=3D1401 audit(1257378096.775:46):<br>
&gt; security_compute_sid: =A0invalid context<br>&gt; dbadm_u:system_r:mysq=
ld_safe_t:s0 for<br>&gt; scontext=3Ddbadm_u:dbadm_r:initrc_t:s0<br>&gt; tco=
ntext=3Dsystem_u:object_r:mysqld_safe_exec_t:s0 tclass=3Dprocess<br>&gt;<br=
>&gt; I believe I have the rules that should allow this, but obviously I am=
<br>
&gt; missing something.<br>&gt; role dbadm_r types mysqld_safe_t;<br>&gt; r=
ole sysadm_r types mysqld_safe_t;<br>&gt; role system_r types mysqld_safe_t=
;<br>&gt; and this:<br>&gt; allow initrc_t mysqld_safe_t : process transiti=
on ;<br>
&gt; which is what the &quot;security_compute_sid&quot; message looks like =
it is missing.<br>&gt;<br>&gt; Does anyone know where I can find a good des=
cription of how to get a<br>&gt; service to transistion back into system_r =
when started by a user or<br>
&gt; have any idea what I am missing?<br><br><br></div></div>The run_init p=
rogram was designed to solve this problem, take a look at<br>the man page.<=
br><br>On Fedora at least, the &quot;service&quot; command calls run_init i=
nternally, so<br>
doing &quot;service mysqld start&quot; should in theory start it up in the<=
br>system_r role. =A0If you&#39;re just running &quot;/etc/init.d/mysld sta=
rt&quot; it<br>won&#39;t transition.<br></blockquote>
<div>That would be great, but I am trying to use this as normal users on a =
system to which the root account is locked.=A0 As far as I know, run_init a=
lways asks for the root password.=A0 Is there a way to use it without havin=
g access to the root password?</div>

<div>=A0</div>
<div>BTW, I am using RHEL 5.3,=A0do you know if=A0service there calls run_i=
nit internally?</div>
<div>=A0</div>
<div>=A0 Thank you,</div>
<div>=A0 Larry</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><font color=3D"#888888"><br><br>=
--<br><br>Eamon Walsh<br>National Security Agency<br><br></font></blockquot=
e>
</div><br>

--00504501634bd736450477b9d810--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
