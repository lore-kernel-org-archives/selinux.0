MIME-Version: 1.0
In-Reply-To: <4AFA094D.1030701@tycho.nsa.gov>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
	 <4AF482CA.4090109@tycho.nsa.gov>
	 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
	 <20091106221120.GA4921@notebook3.grift.internal>
	 <4AF4AFFC.9060505@tycho.nsa.gov>
	 <81092d890911091254g1b9616e6l54d352ab51610b07@mail.gmail.com>
	 <1257802044.31440.4.camel@localhost>
	 <81092d890911101554u37233080q43523f3069b93a2e@mail.gmail.com>
	 <4AFA094D.1030701@tycho.nsa.gov>
Date: Wed, 11 Nov 2009 16:59:54 -0800
Message-ID: <81092d890911111659h316fe643y65ade32d09253a02@mail.gmail.com>
Subject: Re: "security_compute_sid: invalid context" error when
	starting/stopping mysqld daemon
From: Larry Ross <selinux.larry@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Dominick Grift <domg472@gmail.com>
Content-Type: multipart/alternative; boundary=0016368e2fe8bbe6ef0478220fb5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016368e2fe8bbe6ef0478220fb5
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 10, 2009 at 4:46 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:

> On 11/10/2009 06:54 PM, Larry Ross wrote:
>
> [snip]
> >
> > I have seen this before, and I find it confusing, I get denials:
> >
> > Nov 10 15:03:43 localhost kernel: type=1400 audit(1257894223.988:43):
> > avc:  denied  { transition } for  pid=3799 comm="mysql"
> > path="/usr/bin/mysqld_safe" dev=dm-1 ino=460035
> > scontext=app_dbadm_u:app_dbadm_r:initrc_t:s0
> > tcontext=app_dbadm_u:system_r:mysqld_safe_t:s0 tclass=process
> > I run that denial through audit2allow and I get this:
> > #============= initrc_t ==============
> > allow initrc_t mysqld_safe_t:process transition;
> > That rule is already present in the policy:
> > allow initrc_t mysqld_safe_t:process transition;
> > Can anyone tell me why this happens?  Am I missing something?  Is
> > audit2allow confused?  Is the rule not being honored for some reason?
>
>
> There are additional "constrain" statements in the policy that can
> override allow rules.  They are in the "policy/constraints" file in the
> policy source.  In this case, I think you are hitting the following
> constraint:
>
> constrain process { transition noatsecure siginh rlimitinh }
> (
>        r1 == r2
>        or ( t1 == can_change_process_role and t2 == process_user_target )
>        or ( t1 == cron_source_domain and t2 == cron_job_domain )
>        or ( t1 == can_system_change and r2 == system_r )
>        or ( t1 == process_uncond_exempt )
> );
>
>
> Which says you can't transition unless the new role is the same as the
> old role (first line) or your type meets one of four exceptions
> (remaining lines).  audit2allow does get confused here because the AVC
> message doesn't indicate that it's because of a constraint violation.
> This is a known problem.
>

 Eamon,
  Thank you for this, it helps a lot.


>
> In the denial above, the source context is initrc_t but running in the
> app_dbadm_r role.  I think you want to already be in the system_r role
> when you are running as initrc_t.  Which is what the last three lines of
> Dominick's snippet do:
>
> # When app_dbadm_t runs the mysql init script, change to initrc_t
> init_labeled_script_domtrans(app_dbadm_t, mysqld_initrc_exec_t)
>

I had this wrong I had this instead (obviously I misunderstood the arguments
to that interface):
init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)



> # Exempt app_dbadm_t from the role-change constraint (to system_r only)
> domain_system_change_exemption(app_dbadm_t)
>
> # When app_dbadm_r runs the mysqld init script, change to system_r:
> role_transition app_dbadm_r mysqld_initrc_exec_t system_r;
> allow app_dbadm_r system_r;
>

Found it.  I had written rules to transition into the initrc_t domain type
when executing files with the type initrc_exec_t.  This was happening before
the execution of mysqld_safe.

So the timeline was:
service mysql start
- calls /etc/init.d/mysql
  (initrc_exec_t, causes transition into initrc_t)
- calls /usr/bin/mysqld_safe
  (mysqld_safe_exec_t, causes transition into mysqld_safe_t, attempts to
transition into system_r and fails)
so it had tranisitoned into the initrc domain before getting to where
I thought the problem was.

  Thank you everyone for your insight, I learned a lot.
  Larry



>
>
> If you do have this policy in place, check the label on the
> /etc/init.d/mysql script and make sure it corresponds to the one in the
> policy.


>
> --
>
> Eamon Walsh
> National Security Agency
>
>

--0016368e2fe8bbe6ef0478220fb5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Tue, Nov 10, 2009 at 4:46 PM, Eamon Walsh <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:ewalsh@tycho.nsa.gov">ewalsh@tycho.nsa=
.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On 11/10/2009 06:54 PM, Larry Ro=
ss wrote:<br><br>[snip]<br>
<div class=3D"im">&gt;<br>&gt; I have seen this before, and I find it confu=
sing, I get denials:<br>&gt;<br>&gt; Nov 10 15:03:43 localhost kernel: type=
=3D1400 audit(1257894223.988:43):<br>&gt; avc: =A0denied =A0{ transition } =
for =A0pid=3D3799 comm=3D&quot;mysql&quot;<br>
&gt; path=3D&quot;/usr/bin/mysqld_safe&quot; dev=3Ddm-1 ino=3D460035<br>&gt=
; scontext=3Dapp_dbadm_u:app_dbadm_r:initrc_t:s0<br>&gt; tcontext=3Dapp_dba=
dm_u:system_r:mysqld_safe_t:s0 tclass=3Dprocess<br>&gt; I run that denial t=
hrough audit2allow and I get this:<br>
&gt; #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D initrc_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt; allow initrc_t mysqld_safe_t:process trans=
ition;<br>&gt; That rule is already present in the policy:<br>&gt; allow in=
itrc_t mysqld_safe_t:process transition;<br>&gt; Can anyone tell me why thi=
s happens? =A0Am I missing something? =A0Is<br>
&gt; audit2allow confused? =A0Is the rule not being honored for some reason=
?<br><br><br></div>There are additional &quot;constrain&quot; statements in=
 the policy that can<br>override allow rules. =A0They are in the &quot;poli=
cy/constraints&quot; file in the<br>
policy source. =A0In this case, I think you are hitting the following<br>co=
nstraint:<br><br>constrain process { transition noatsecure siginh rlimitinh=
 }<br>(<br>=A0 =A0 =A0 =A0r1 =3D=3D r2<br>=A0 =A0 =A0 =A0or ( t1 =3D=3D can=
_change_process_role and t2 =3D=3D process_user_target )<br>
=A0 =A0 =A0 =A0or ( t1 =3D=3D cron_source_domain and t2 =3D=3D cron_job_dom=
ain )<br>=A0 =A0 =A0 =A0or ( t1 =3D=3D can_system_change and r2 =3D=3D syst=
em_r )<br>=A0 =A0 =A0 =A0or ( t1 =3D=3D process_uncond_exempt )<br>);<br><b=
r><br>Which says you can&#39;t transition unless the new role is the same a=
s the<br>
old role (first line) or your type meets one of four exceptions<br>(remaini=
ng lines). =A0audit2allow does get confused here because the AVC<br>message=
 doesn&#39;t indicate that it&#39;s because of a constraint violation.<br>
This is a known problem.<br></blockquote>
<div>=A0</div>
<div>
<div>Eamon,</div>
<div>=A0 Thank you for this, it helps a lot.</div></div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>In the denial above, the sou=
rce context is initrc_t but running in the<br>app_dbadm_r role. =A0I think =
you want to already be in the system_r role<br>
when you are running as initrc_t. =A0Which is what the last three lines of<=
br>Dominick&#39;s snippet do:<br><br># When app_dbadm_t runs the mysql init=
 script, change to initrc_t<br>init_labeled_script_domtrans(app_dbadm_t, my=
sqld_initrc_exec_t)<br>
</blockquote>
<div>
<div>=A0</div>
<div>I had this wrong I had this instead (obviously I misunderstood the arg=
uments to that interface):</div>
<div>init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)</div>
<div>=A0</div>
<div>=A0</div></div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"># Exempt app_dbadm_t from the ro=
le-change constraint (to system_r only)<br>domain_system_change_exemption(a=
pp_dbadm_t)<br>
<br># When app_dbadm_r runs the mysqld init script, change to system_r:<br>=
role_transition app_dbadm_r mysqld_initrc_exec_t system_r;<br>allow app_dba=
dm_r system_r;<br></blockquote>
<div>
<div>=A0</div>
<div>Found it.=A0 I had written rules to transition into the initrc_t domai=
n type when executing files with the type initrc_exec_t.=A0 This was happen=
ing before the execution of mysqld_safe.</div>
<div>=A0</div>
<div>So the timeline was:</div>
<div>service mysql start </div>
<div>- calls /etc/init.d/mysql </div>
<div>=A0=A0(initrc_exec_t, causes transition into initrc_t) </div>
<div>- calls /usr/bin/mysqld_safe </div>
<div>=A0 (mysqld_safe_exec_t, causes transition into mysqld_safe_t, attempt=
s to transition into system_r and fails)</div>
<div>so it had tranisitoned into the initrc domain before getting to=A0wher=
e I=A0thought the problem was.</div>
<div>=A0</div>
<div>=A0 Thank you everyone for your insight, I learned a lot.=A0</div>
<div>=A0 Larry</div>
<div>=A0</div></div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br><br>If you do have this poli=
cy in place, check the label on the<br>/etc/init.d/mysql script and make su=
re it corresponds to the one in the<br>
policy.</blockquote>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><font color=3D"#888888"><br><br>=
--<br></font>
<div>
<div></div>
<div class=3D"h5"><br>Eamon Walsh<br>National Security Agency<br><br></div>=
</div></blockquote></div><br>

--0016368e2fe8bbe6ef0478220fb5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
