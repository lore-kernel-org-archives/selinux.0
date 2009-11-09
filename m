MIME-Version: 1.0
In-Reply-To: <4AF4AFFC.9060505@tycho.nsa.gov>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
	 <4AF482CA.4090109@tycho.nsa.gov>
	 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
	 <20091106221120.GA4921@notebook3.grift.internal>
	 <4AF4AFFC.9060505@tycho.nsa.gov>
Date: Mon, 9 Nov 2009 12:54:46 -0800
Message-ID: <81092d890911091254g1b9616e6l54d352ab51610b07@mail.gmail.com>
Subject: Re: "security_compute_sid: invalid context" error when
	starting/stopping mysqld daemon
From: Larry Ross <selinux.larry@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov,
        paul@city-fan.org
Content-Type: multipart/alternative; boundary=001485e0e61e5ffc260477f66745
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001485e0e61e5ffc260477f66745
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Nov 6, 2009 at 3:23 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:

>  On 11/06/2009 05:11 PM, Dominick Grift wrote:
> > On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry Ross wrote:
> >
> >> On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh <ewalsh@tycho.nsa.gov>
> wrote:
> >>
> >>
> >>>  On 11/04/2009 06:57 PM, Larry Ross wrote:
> >>>
> >>>> I have two selinux users that need to be able to stop and start the
> >>>> mysql daemon, which is started by the initialization scripts.  When
> >>>> the daemon is stopped and started by the secadm_u user, it ends up in
> >>>> the context secadm_u:secadm_r:mysqld_t.  When it is stopped and
> >>>> started by the dbadm_u user, it ends up in the
> >>>> dbadm_u:dbadm_r:mysqld_t context.  When it is started by the init
> >>>> scripts it ends up in the system_u:system_r:mysqld_t domain.
> >>>>
> >>>> I would like it to alway end up in the system_r:mysqld_t domain, but
> >>>> can't seem to find any documentation that describes how to get that to
> >>>> work.
> >>>>
> >>>> If I add a role_transition rule to transition the role to system_r
> >>>> when the executable is run:
> >>>> role_transition sysadm_r mysqld_safe_exec_t system_r;
> >>>> role_transition dbadm_r  mysqld_safe_exec_t system_r;
> >>>> I end up getting these errors:
> >>>>
> >>>> Nov  4 15:41:36 localhost kernel: type=1401 audit(1257378096.775:46):
> >>>> security_compute_sid:  invalid context
> >>>> dbadm_u:system_r:mysqld_safe_t:s0 for
> >>>> scontext=dbadm_u:dbadm_r:initrc_t:s0
> >>>> tcontext=system_u:object_r:mysqld_safe_exec_t:s0 tclass=process
> >>>>
> >>>> I believe I have the rules that should allow this, but obviously I am
> >>>> missing something.
> >>>> role dbadm_r types mysqld_safe_t;
> >>>> role sysadm_r types mysqld_safe_t;
> >>>> role system_r types mysqld_safe_t;
> >>>> and this:
> >>>> allow initrc_t mysqld_safe_t : process transition ;
> >>>> which is what the "security_compute_sid" message looks like it is
> >>>>
> >>> missing.
> >>>
> >>>> Does anyone know where I can find a good description of how to get a
> >>>> service to transistion back into system_r when started by a user or
> >>>> have any idea what I am missing?
> >>>>
> >>>
> >>> The run_init program was designed to solve this problem, take a look at
> >>> the man page.
> >>>
> >>> On Fedora at least, the "service" command calls run_init internally, so
> >>> doing "service mysqld start" should in theory start it up in the
> >>> system_r role.  If you're just running "/etc/init.d/mysld start" it
> >>> won't transition.
> >>>
> >>>
> >> That would be great, but I am trying to use this as normal users on a
> system
> >> to which the root account is locked.  As far as I know, run_init always
> asks
> >> for the root password.  Is there a way to use it without having access
> to
> >> the root password?
> >>
> > I think you can use pam_rootok in /etc/pam.d/run_init. I dont know the
> details of the top of my head because i use Fedora and the policy that i
> posted earlier so that i automatically transition to initrc_t without
> run_init.
> >
>
>
> Yes, /etc/pam.d/run_init controls the password check done by run_init.
> Also, it only asks for the password of whatever user is running it, not
> always the root password.  The only reason it asks for a password is to
> verify that a human is present.
>
> "run_init id -Z" from sysadm_r should print out
> "system_u:system_r:initrc_t".  Other roles might need the following line
> of policy to be able to run run_init (using the example of staff):
>
> seutil_run_runinit(staff_t, staff_r)
>
> The policy snippet Dominick posted earlier also works.
>

I get a syntax error when I try to use that snippet:

# make -f /usr/share/selinux/devel/Makefile
Compiling strict appmysql module
/usr/bin/checkmodule:  loading policy configuration from tmp/appmysql.tmp
appmysql.te:62:ERROR 'syntax error' at token 'init_labeled_script_domtrans'
on line 92695:
init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/appmysql.mod] Error 1
is init_labeled_script_domtrans defined for RHEL 5.3?  I see it used in the
files below:

/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/virt.if:
init_labeled_script_domtrans($1, virtd_initrc_exec_t)
/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/avahi.if:
init_labeled_script_domtrans($1, avahi_initrc_exec_t)
/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/spamassassin.if:
init_labeled_script_domtrans($1,spamd_script_exec_t)
but I don't see it defined anywhere.

  -- Larry


>
>
>
> >
> > BTW, I am using RHEL 5.3, do you know if service there calls run_init
> > internally?
>
> I was mistaken about this, as pointed out by Paul, service doesn't call
> run_init.
>
>
>
> --
>
> Eamon Walsh
> National Security Agency
>
>

--001485e0e61e5ffc260477f66745
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Nov 6, 2009 at 3:23 PM, Eamon Walsh <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:ewalsh@tycho.nsa.gov">ewalsh@tycho.nsa.=
gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On 11/06/2009 05:11 PM, Dominick Grift wrote:<br>&gt; On =
Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry Ross wrote:<br>&gt;<br>&gt;&gt=
; On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh &lt;<a href=3D"mailto:ewalsh=
@tycho.nsa.gov">ewalsh@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;&gt; =A0On 11/04/2009 06:57 PM, Larry Ross =
wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; I have two selinux users that ne=
ed to be able to stop and start the<br>&gt;&gt;&gt;&gt; mysql daemon, which=
 is started by the initialization scripts. =A0When<br>
&gt;&gt;&gt;&gt; the daemon is stopped and started by the secadm_u user, it=
 ends up in<br>&gt;&gt;&gt;&gt; the context secadm_u:secadm_r:mysqld_t. =A0=
When it is stopped and<br>&gt;&gt;&gt;&gt; started by the dbadm_u user, it =
ends up in the<br>
&gt;&gt;&gt;&gt; dbadm_u:dbadm_r:mysqld_t context. =A0When it is started by=
 the init<br>&gt;&gt;&gt;&gt; scripts it ends up in the system_u:system_r:m=
ysqld_t domain.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; I would like it to =
alway end up in the system_r:mysqld_t domain, but<br>
&gt;&gt;&gt;&gt; can&#39;t seem to find any documentation that describes ho=
w to get that to<br>&gt;&gt;&gt;&gt; work.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&=
gt;&gt; If I add a role_transition rule to transition the role to system_r<=
br>
&gt;&gt;&gt;&gt; when the executable is run:<br>&gt;&gt;&gt;&gt; role_trans=
ition sysadm_r mysqld_safe_exec_t system_r;<br>&gt;&gt;&gt;&gt; role_transi=
tion dbadm_r =A0mysqld_safe_exec_t system_r;<br>&gt;&gt;&gt;&gt; I end up g=
etting these errors:<br>
&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Nov =A04 15:41:36 localhost kernel: ty=
pe=3D1401 audit(1257378096.775:46):<br>&gt;&gt;&gt;&gt; security_compute_si=
d: =A0invalid context<br>&gt;&gt;&gt;&gt; dbadm_u:system_r:mysqld_safe_t:s0=
 for<br>
&gt;&gt;&gt;&gt; scontext=3Ddbadm_u:dbadm_r:initrc_t:s0<br>&gt;&gt;&gt;&gt;=
 tcontext=3Dsystem_u:object_r:mysqld_safe_exec_t:s0 tclass=3Dprocess<br>&gt=
;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; I believe I have the rules that should al=
low this, but obviously I am<br>
&gt;&gt;&gt;&gt; missing something.<br>&gt;&gt;&gt;&gt; role dbadm_r types =
mysqld_safe_t;<br>&gt;&gt;&gt;&gt; role sysadm_r types mysqld_safe_t;<br>&g=
t;&gt;&gt;&gt; role system_r types mysqld_safe_t;<br>&gt;&gt;&gt;&gt; and t=
his:<br>
&gt;&gt;&gt;&gt; allow initrc_t mysqld_safe_t : process transition ;<br>&gt=
;&gt;&gt;&gt; which is what the &quot;security_compute_sid&quot; message lo=
oks like it is<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt; missing.<br>&gt;&gt;&gt;=
<br>
&gt;&gt;&gt;&gt; Does anyone know where I can find a good description of ho=
w to get a<br>&gt;&gt;&gt;&gt; service to transistion back into system_r wh=
en started by a user or<br>&gt;&gt;&gt;&gt; have any idea what I am missing=
?<br>
&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; The run_init program was d=
esigned to solve this problem, take a look at<br>&gt;&gt;&gt; the man page.=
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; On Fedora at least, the &quot;service&quot=
; command calls run_init internally, so<br>
&gt;&gt;&gt; doing &quot;service mysqld start&quot; should in theory start =
it up in the<br>&gt;&gt;&gt; system_r role. =A0If you&#39;re just running &=
quot;/etc/init.d/mysld start&quot; it<br>&gt;&gt;&gt; won&#39;t transition.=
<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt; That would be great, but I am tryi=
ng to use this as normal users on a system<br>&gt;&gt; to which the root ac=
count is locked. =A0As far as I know, run_init always asks<br>&gt;&gt; for =
the root password. =A0Is there a way to use it without having access to<br>
&gt;&gt; the root password?<br>&gt;&gt;<br>&gt; I think you can use pam_roo=
tok in /etc/pam.d/run_init. I dont know the details of the top of my head b=
ecause i use Fedora and the policy that i posted earlier so that i automati=
cally transition to initrc_t without run_init.<br>
&gt;<br><br><br></div></div>Yes, /etc/pam.d/run_init controls the password =
check done by run_init.<br>Also, it only asks for the password of whatever =
user is running it, not<br>always the root password. =A0The only reason it =
asks for a password is to<br>
verify that a human is present.<br><br>&quot;run_init id -Z&quot; from sysa=
dm_r should print out<br>&quot;system_u:system_r:initrc_t&quot;. =A0Other r=
oles might need the following line<br>of policy to be able to run run_init =
(using the example of staff):<br>
<br>seutil_run_runinit(staff_t, staff_r)<br><br>The policy snippet Dominick=
 posted earlier also works.<br></blockquote>
<div>=A0</div>
<div>I get a syntax error when I try to use that snippet:</div>
<div>=A0</div>
<div># make -f /usr/share/selinux/devel/Makefile<br>Compiling strict appmys=
ql module<br>/usr/bin/checkmodule:=A0 loading policy configuration from tmp=
/appmysql.tmp<br>appmysql.te:62:ERROR &#39;syntax error&#39; at token &#39;=
init_labeled_script_domtrans&#39; on line 92695:</div>

<div>init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)<br>/us=
r/bin/checkmodule:=A0 error(s) encountered while parsing configuration<br>m=
ake: *** [tmp/appmysql.mod] Error 1<br></div>
<div>is init_labeled_script_domtrans defined for RHEL 5.3?=A0 I see it used=
 in the files below:=A0</div>
<div>=A0</div>
<div>/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/virt.i=
f:=A0=A0=A0=A0=A0=A0=A0 init_labeled_script_domtrans($1, virtd_initrc_exec_=
t)<br>/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/avahi=
.if:=A0=A0=A0=A0=A0=A0 init_labeled_script_domtrans($1, avahi_initrc_exec_t=
)<br>
/usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/spamassassi=
n.if:=A0=A0=A0=A0=A0=A0=A0 init_labeled_script_domtrans($1,spamd_script_exe=
c_t)<br></div>
<div>but I don&#39;t see it defined anywhere.=A0 </div>
<div>=A0</div>
<div>=A0 -- Larry</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im"><br><br><br>&gt;<br>&gt; BTW, I am using RHEL 5.3, do you=
 know if service there calls run_init<br>&gt; internally?<br><br></div>I wa=
s mistaken about this, as pointed out by Paul, service doesn&#39;t call<br>
run_init.<br><font color=3D"#888888"><br><br><br>--<br></font>
<div>
<div></div>
<div class=3D"h5"><br>Eamon Walsh<br>National Security Agency<br><br></div>=
</div></blockquote></div><br>

--001485e0e61e5ffc260477f66745--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
