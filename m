MIME-Version: 1.0
In-Reply-To: <1257802044.31440.4.camel@localhost>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
	 <4AF482CA.4090109@tycho.nsa.gov>
	 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
	 <20091106221120.GA4921@notebook3.grift.internal>
	 <4AF4AFFC.9060505@tycho.nsa.gov>
	 <81092d890911091254g1b9616e6l54d352ab51610b07@mail.gmail.com>
	 <1257802044.31440.4.camel@localhost>
Date: Tue, 10 Nov 2009 15:54:25 -0800
Message-ID: <81092d890911101554u37233080q43523f3069b93a2e@mail.gmail.com>
Subject: Re: "security_compute_sid: invalid context" error when
	starting/stopping mysqld daemon
From: Larry Ross <selinux.larry@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Dominick Grift <domg472@gmail.com>,
        paul@city-fan.org
Content-Type: multipart/alternative; boundary=001485e9aa08b4232c04780d0763
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001485e9aa08b4232c04780d0763
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 9, 2009 at 1:27 PM, Dominick Grift <domg472@gmail.com> wrote:

>  On Mon, 2009-11-09 at 12:54 -0800, Larry Ross wrote:
> > On Fri, Nov 6, 2009 at 3:23 PM, Eamon Walsh <ewalsh@tycho.nsa.gov>
> > wrote:
> >
> >         On 11/06/2009 05:11 PM, Dominick Grift wrote:
> >         > On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry Ross wrote:
> >         >
> >         >> On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh
> >         <ewalsh@tycho.nsa.gov> wrote:
> >         >>
> >         >>
> >         >>>  On 11/04/2009 06:57 PM, Larry Ross wrote:
> >         >>>
> >         >>>> I have two selinux users that need to be able to stop and
> >         start the
> >         >>>> mysql daemon, which is started by the initialization
> >         scripts.  When
> >         >>>> the daemon is stopped and started by the secadm_u user,
> >         it ends up in
> >         >>>> the context secadm_u:secadm_r:mysqld_t.  When it is
> >         stopped and
> >         >>>> started by the dbadm_u user, it ends up in the
> >         >>>> dbadm_u:dbadm_r:mysqld_t context.  When it is started by
> >         the init
> >         >>>> scripts it ends up in the system_u:system_r:mysqld_t
> >         domain.
> >         >>>>
> >         >>>> I would like it to alway end up in the system_r:mysqld_t
> >         domain, but
> >         >>>> can't seem to find any documentation that describes how
> >         to get that to
> >         >>>> work.
> >         >>>>
> >         >>>> If I add a role_transition rule to transition the role to
> >         system_r
> >         >>>> when the executable is run:
> >         >>>> role_transition sysadm_r mysqld_safe_exec_t system_r;
> >         >>>> role_transition dbadm_r  mysqld_safe_exec_t system_r;
> >         >>>> I end up getting these errors:
> >         >>>>
> >         >>>> Nov  4 15:41:36 localhost kernel: type=1401
> >         audit(1257378096.775:46):
> >         >>>> security_compute_sid:  invalid context
> >         >>>> dbadm_u:system_r:mysqld_safe_t:s0 for
> >         >>>> scontext=dbadm_u:dbadm_r:initrc_t:s0
> >         >>>> tcontext=system_u:object_r:mysqld_safe_exec_t:s0
> >         tclass=process
> >         >>>>
> >         >>>> I believe I have the rules that should allow this, but
> >         obviously I am
> >         >>>> missing something.
> >         >>>> role dbadm_r types mysqld_safe_t;
> >         >>>> role sysadm_r types mysqld_safe_t;
> >         >>>> role system_r types mysqld_safe_t;
> >         >>>> and this:
> >         >>>> allow initrc_t mysqld_safe_t : process transition ;
> >         >>>> which is what the "security_compute_sid" message looks
> >         like it is
> >         >>>>
> >         >>> missing.
> >         >>>
> >         >>>> Does anyone know where I can find a good description of
> >         how to get a
> >         >>>> service to transistion back into system_r when started by
> >         a user or
> >         >>>> have any idea what I am missing?
> >         >>>>
> >         >>>
> >         >>> The run_init program was designed to solve this problem,
> >         take a look at
> >         >>> the man page.
> >         >>>
> >         >>> On Fedora at least, the "service" command calls run_init
> >         internally, so
> >         >>> doing "service mysqld start" should in theory start it up
> >         in the
> >         >>> system_r role.  If you're just running "/etc/init.d/mysld
> >         start" it
> >         >>> won't transition.
> >         >>>
> >         >>>
> >         >> That would be great, but I am trying to use this as normal
> >         users on a system
> >         >> to which the root account is locked.  As far as I know,
> >         run_init always asks
> >         >> for the root password.  Is there a way to use it without
> >         having access to
> >         >> the root password?
> >         >>
> >         > I think you can use pam_rootok in /etc/pam.d/run_init. I
> >         dont know the details of the top of my head because i use
> >         Fedora and the policy that i posted earlier so that i
> >         automatically transition to initrc_t without run_init.
> >         >
> >
> >
> >
> >         Yes, /etc/pam.d/run_init controls the password check done by
> >         run_init.
> >         Also, it only asks for the password of whatever user is
> >         running it, not
> >         always the root password.  The only reason it asks for a
> >         password is to
> >         verify that a human is present.
> >
> >         "run_init id -Z" from sysadm_r should print out
> >         "system_u:system_r:initrc_t".  Other roles might need the
> >         following line
> >         of policy to be able to run run_init (using the example of
> >         staff):
> >
> >         seutil_run_runinit(staff_t, staff_r)
> >
> >         The policy snippet Dominick posted earlier also works.
> >
> > I get a syntax error when I try to use that snippet:
> >
> > # make -f /usr/share/selinux/devel/Makefile
> > Compiling strict appmysql module
> > /usr/bin/checkmodule:  loading policy configuration from
> > tmp/appmysql.tmp
> > appmysql.te:62:ERROR 'syntax error' at token
> > 'init_labeled_script_domtrans' on line 92695:
> > init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)
> > /usr/bin/checkmodule:  error(s) encountered while parsing
> > configuration
> > make: *** [tmp/appmysql.mod] Error 1
> >
> > is init_labeled_script_domtrans defined for RHEL 5.3?  I see it used
> > in the files below:
> >
> > /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/virt.if:
>        init_labeled_script_domtrans($1, virtd_initrc_exec_t)
> > /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/avahi.if:
>       init_labeled_script_domtrans($1, avahi_initrc_exec_t)
> >
> /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/spamassassin.if:
>        init_labeled_script_domtrans($1,spamd_script_exec_t)
> >
> > but I don't see it defined anywhere.
>
> If it is there then it should be defined in init.if.
>
> You could simply add this to your mysqladm interface file:
>
> ########################################
> ## <summary>
> ##      Transition to the init script domain
> ##      on a specified labeled init script.
> ## </summary>
> ## <param name="domain">
> ##      <summary>
> ##      Domain allowed access.
> ##      </summary>
> ## </param>
> ## <param name="init_script_file">
> ##      <summary>
> ##      Labeled init script file.
> ##      </summary>
> ## </param>
> #
> interface(`init_labeled_script_domtrans',`
>        gen_require(`
>                type initrc_t;
>        ')
>
>        domtrans_pattern($1, $2, initrc_t)
>        files_search_etc($1)
> ')
>
> That should atleast make it work for that module. Hopefully the other
> policy in the snippit is supported.
>

I have seen this before, and I find it confusing, I get denials:

Nov 10 15:03:43 localhost kernel: type=1400 audit(1257894223.988:43): avc:
denied  { transition } for  pid=3799 comm="mysql"
path="/usr/bin/mysqld_safe" dev=dm-1 ino=460035
scontext=app_dbadm_u:app_dbadm_r:initrc_t:s0
tcontext=app_dbadm_u:system_r:mysqld_safe_t:s0 tclass=process
I run that denial through audit2allow and I get this:
#============= initrc_t ==============
allow initrc_t mysqld_safe_t:process transition;
That rule is already present in the policy:
allow initrc_t mysqld_safe_t:process transition;
Can anyone tell me why this happens?  Am I missing something?  Is
audit2allow confused?  Is the rule not being honored for some reason?

  -- Larry




>  >   -- Larry
> >
> >
> >
> >
> >         >
> >         > BTW, I am using RHEL 5.3, do you know if service there calls
> >         run_init
> >         > internally?
> >
> >
> >         I was mistaken about this, as pointed out by Paul, service
> >         doesn't call
> >         run_init.
> >
> >
> >
> >         --
> >
> >
> >         Eamon Walsh
> >         National Security Agency
> >
> >
> >
>
>
>

--001485e9aa08b4232c04780d0763
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Nov 9, 2009 at 1:27 PM, Dominick Grift <=
span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">domg472@gmail.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Mon, 2009-11-09 at 12:54 -0800, Larry Ross wrote:<br>&=
gt; On Fri, Nov 6, 2009 at 3:23 PM, Eamon Walsh &lt;<a href=3D"mailto:ewals=
h@tycho.nsa.gov">ewalsh@tycho.nsa.gov</a>&gt;<br>&gt; wrote:<br>&gt;<br>&gt=
; =A0 =A0 =A0 =A0 On 11/06/2009 05:11 PM, Dominick Grift wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry R=
oss wrote:<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt; On=
 Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh<br>&gt; =A0 =A0 =A0 =A0 &lt;<a h=
ref=3D"mailto:ewalsh@tycho.nsa.gov">ewalsh@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>&gt; =A0 =
=A0 =A0 =A0 &gt;&gt;&gt; =A0On 11/04/2009 06:57 PM, Larry Ross wrote:<br>&g=
t; =A0 =A0 =A0 =A0 &gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; I =
have two selinux users that need to be able to stop and<br>
&gt; =A0 =A0 =A0 =A0 start the<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; mys=
ql daemon, which is started by the initialization<br>&gt; =A0 =A0 =A0 =A0 s=
cripts. =A0When<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; the daemon is stop=
ped and started by the secadm_u user,<br>
&gt; =A0 =A0 =A0 =A0 it ends up in<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;=
 the context secadm_u:secadm_r:mysqld_t. =A0When it is<br>&gt; =A0 =A0 =A0 =
=A0 stopped and<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; started by the dba=
dm_u user, it ends up in the<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; dbadm_u:dbadm_r:mysqld_t context. =A0=
When it is started by<br>&gt; =A0 =A0 =A0 =A0 the init<br>&gt; =A0 =A0 =A0 =
=A0 &gt;&gt;&gt;&gt; scripts it ends up in the system_u:system_r:mysqld_t<b=
r>&gt; =A0 =A0 =A0 =A0 domain.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&=
gt; I would like it to alway end up in the system_r:mysqld_t<br>&gt; =A0 =
=A0 =A0 =A0 domain, but<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; can&#39;t =
seem to find any documentation that describes how<br>
&gt; =A0 =A0 =A0 =A0 to get that to<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt=
; work.<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &g=
t;&gt;&gt;&gt; If I add a role_transition rule to transition the role to<br=
>&gt; =A0 =A0 =A0 =A0 system_r<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; whe=
n the executable is run:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; role_transition sysadm_r mysqld_safe_=
exec_t system_r;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; role_transition d=
badm_r =A0mysqld_safe_exec_t system_r;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;=
&gt; I end up getting these errors:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&=
gt; Nov =A04 15:41:36 localhost kernel: type=3D1401<br>&gt; =A0 =A0 =A0 =A0=
 audit(1257378096.775:46):<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; securit=
y_compute_sid: =A0invalid context<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; dbadm_u:system_r:mysqld_safe_t:s0 for=
<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; scontext=3Ddbadm_u:dbadm_r:initrc=
_t:s0<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; tcontext=3Dsystem_u:object_r=
:mysqld_safe_exec_t:s0<br>
&gt; =A0 =A0 =A0 =A0 tclass=3Dprocess<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&=
gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; I believe I have the rules tha=
t should allow this, but<br>&gt; =A0 =A0 =A0 =A0 obviously I am<br>&gt; =A0=
 =A0 =A0 =A0 &gt;&gt;&gt;&gt; missing something.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; role dbadm_r types mysqld_safe_t;<br>=
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; role sysadm_r types mysqld_safe_t;<br=
>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; role system_r types mysqld_safe_t;<b=
r>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; and this:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; allow initrc_t mysqld_safe_t : proces=
s transition ;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; which is what the &=
quot;security_compute_sid&quot; message looks<br>&gt; =A0 =A0 =A0 =A0 like =
it is<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt; missing.<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;=
&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; Does anyone know where I can =
find a good description of<br>&gt; =A0 =A0 =A0 =A0 how to get a<br>&gt; =A0=
 =A0 =A0 =A0 &gt;&gt;&gt;&gt; service to transistion back into system_r whe=
n started by<br>
&gt; =A0 =A0 =A0 =A0 a user or<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt; hav=
e any idea what I am missing?<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;&gt;<br>&=
gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt; The r=
un_init program was designed to solve this problem,<br>
&gt; =A0 =A0 =A0 =A0 take a look at<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt; th=
e man page.<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &g=
t;&gt;&gt; On Fedora at least, the &quot;service&quot; command calls run_in=
it<br>&gt; =A0 =A0 =A0 =A0 internally, so<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt; doing &quot;service mysqld start&quot; sh=
ould in theory start it up<br>&gt; =A0 =A0 =A0 =A0 in the<br>&gt; =A0 =A0 =
=A0 =A0 &gt;&gt;&gt; system_r role. =A0If you&#39;re just running &quot;/et=
c/init.d/mysld<br>&gt; =A0 =A0 =A0 =A0 start&quot; it<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt; won&#39;t transition.<br>&gt; =A0 =A0 =A0=
 =A0 &gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;&gt;&gt;<br>&gt; =A0 =A0 =A0 =
=A0 &gt;&gt; That would be great, but I am trying to use this as normal<br>=
&gt; =A0 =A0 =A0 =A0 users on a system<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; to which the root account is locked. =A0As fa=
r as I know,<br>&gt; =A0 =A0 =A0 =A0 run_init always asks<br>&gt; =A0 =A0 =
=A0 =A0 &gt;&gt; for the root password. =A0Is there a way to use it without=
<br>&gt; =A0 =A0 =A0 =A0 having access to<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; the root password?<br>&gt; =A0 =A0 =A0 =A0 &g=
t;&gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; I think you can use pam_rootok in /etc/=
pam.d/run_init. I<br>&gt; =A0 =A0 =A0 =A0 dont know the details of the top =
of my head because i use<br>
&gt; =A0 =A0 =A0 =A0 Fedora and the policy that i posted earlier so that i<=
br>&gt; =A0 =A0 =A0 =A0 automatically transition to initrc_t without run_in=
it.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =
=A0 =A0 Yes, /etc/pam.d/run_init controls the password check done by<br>
&gt; =A0 =A0 =A0 =A0 run_init.<br>&gt; =A0 =A0 =A0 =A0 Also, it only asks f=
or the password of whatever user is<br>&gt; =A0 =A0 =A0 =A0 running it, not=
<br>&gt; =A0 =A0 =A0 =A0 always the root password. =A0The only reason it as=
ks for a<br>&gt; =A0 =A0 =A0 =A0 password is to<br>
&gt; =A0 =A0 =A0 =A0 verify that a human is present.<br>&gt;<br>&gt; =A0 =
=A0 =A0 =A0 &quot;run_init id -Z&quot; from sysadm_r should print out<br>&g=
t; =A0 =A0 =A0 =A0 &quot;system_u:system_r:initrc_t&quot;. =A0Other roles m=
ight need the<br>&gt; =A0 =A0 =A0 =A0 following line<br>
&gt; =A0 =A0 =A0 =A0 of policy to be able to run run_init (using the exampl=
e of<br>&gt; =A0 =A0 =A0 =A0 staff):<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 seutil=
_run_runinit(staff_t, staff_r)<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 The policy s=
nippet Dominick posted earlier also works.<br>
&gt;<br>&gt; I get a syntax error when I try to use that snippet:<br>&gt;<b=
r>&gt; # make -f /usr/share/selinux/devel/Makefile<br>&gt; Compiling strict=
 appmysql module<br>&gt; /usr/bin/checkmodule: =A0loading policy configurat=
ion from<br>
&gt; tmp/appmysql.tmp<br>&gt; appmysql.te:62:ERROR &#39;syntax error&#39; a=
t token<br>&gt; &#39;init_labeled_script_domtrans&#39; on line 92695:<br>&g=
t; init_labeled_script_domtrans(mysqld_safe_t, mysqld_safe_exec_t)<br>&gt; =
/usr/bin/checkmodule: =A0error(s) encountered while parsing<br>
&gt; configuration<br>&gt; make: *** [tmp/appmysql.mod] Error 1<br>&gt;<br>=
&gt; is init_labeled_script_domtrans defined for RHEL 5.3? =A0I see it used=
<br>&gt; in the files below:<br>&gt;<br>&gt; /usr/src/redhat/BUILD/serefpol=
icy-2.4.6/policy/modules/services/virt.if: =A0 =A0 =A0 =A0init_labeled_scri=
pt_domtrans($1, virtd_initrc_exec_t)<br>
&gt; /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/avahi.=
if: =A0 =A0 =A0 init_labeled_script_domtrans($1, avahi_initrc_exec_t)<br>&g=
t; /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/spamassa=
ssin.if: =A0 =A0 =A0 =A0init_labeled_script_domtrans($1,spamd_script_exec_t=
)<br>
&gt;<br>&gt; but I don&#39;t see it defined anywhere.<br><br></div></div>If=
 it is there then it should be defined in init.if.<br><br>You could simply =
add this to your mysqladm interface file:<br><br>##########################=
##############<br>
## &lt;summary&gt;<br>## =A0 =A0 =A0Transition to the init script domain<br=
>## =A0 =A0 =A0on a specified labeled init script.<br>## &lt;/summary&gt;<b=
r>## &lt;param name=3D&quot;domain&quot;&gt;<br>## =A0 =A0 =A0&lt;summary&g=
t;<br>## =A0 =A0 =A0Domain allowed access.<br>
## =A0 =A0 =A0&lt;/summary&gt;<br>## &lt;/param&gt;<br>## &lt;param name=3D=
&quot;init_script_file&quot;&gt;<br>## =A0 =A0 =A0&lt;summary&gt;<br>## =A0=
 =A0 =A0Labeled init script file.<br>## =A0 =A0 =A0&lt;/summary&gt;<br>## &=
lt;/param&gt;<br>#<br>
interface(`init_labeled_script_domtrans&#39;,`<br>=A0 =A0 =A0 =A0gen_requir=
e(`<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type initrc_t;<br>=A0 =A0 =A0 =A0&#39=
;)<br><br>=A0 =A0 =A0 =A0domtrans_pattern($1, $2, initrc_t)<br>=A0 =A0 =A0 =
=A0files_search_etc($1)<br>&#39;)<br><br>That should atleast make it work f=
or that module. Hopefully the other<br>
policy in the snippit is supported.<br></blockquote>
<div>=A0</div>
<div>I have seen this before, and I find it confusing, I get denials:</div>
<div>=A0</div>
<div>Nov 10 15:03:43 localhost kernel: type=3D1400 audit(1257894223.988:43)=
: avc:=A0 denied=A0 { transition } for=A0 pid=3D3799 comm=3D&quot;mysql&quo=
t; path=3D&quot;/usr/bin/mysqld_safe&quot; dev=3Ddm-1 ino=3D460035 scontext=
=3Dapp_dbadm_u:app_dbadm_r:initrc_t:s0 tcontext=3Dapp_dbadm_u:system_r:mysq=
ld_safe_t:s0 tclass=3Dprocess<br>
</div>
<div>I run that denial through audit2allow and I get this:</div>
<div>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D initrc_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>allow initrc_t mysqld_safe_t:process transition=
;<br></div>
<div>That rule is already present in the policy:</div>
<div>allow initrc_t mysqld_safe_t:process transition;<br></div>
<div>Can anyone tell me why this happens?=A0 Am I missing something?=A0 Is =
audit2allow confused?=A0 Is the rule not being honored for some reason?</di=
v>
<div>=A0</div>
<div>=A0 -- Larry</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class=3D"h5">&gt; =A0 -- Larry<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;=
 =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; BTW, I am using RHEL 5.3=
, do you know if service there calls<br>&gt; =A0 =A0 =A0 =A0 run_init<br>&g=
t; =A0 =A0 =A0 =A0 &gt; internally?<br>
&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 I was mistaken about this, as pointed =
out by Paul, service<br>&gt; =A0 =A0 =A0 =A0 doesn&#39;t call<br>&gt; =A0 =
=A0 =A0 =A0 run_init.<br>&gt;<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 --<br=
>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 Eamon Walsh<br>
&gt; =A0 =A0 =A0 =A0 National Security Agency<br>&gt;<br>&gt;<br>&gt;<br><b=
r><br></div></div></blockquote></div><br>

--001485e9aa08b4232c04780d0763--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
