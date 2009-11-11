Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAB9lepo021537
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 04:47:40 -0500
Received: from fg-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAB9ndAG022797
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 09:49:40 GMT
Received: by fg-out-1718.google.com with SMTP id l26so321035fgb.12
        for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 01:47:38 -0800 (PST)
Subject: Re: "security_compute_sid: invalid context" error when
 starting/stopping mysqld daemon
From: Dominick Grift <domg472@gmail.com>
To: Larry Ross <selinux.larry@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1257931946.3022.6.camel@localhost>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
	 <4AF482CA.4090109@tycho.nsa.gov>
	 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
	 <20091106221120.GA4921@notebook3.grift.internal>
	 <4AF4AFFC.9060505@tycho.nsa.gov>
	 <81092d890911091254g1b9616e6l54d352ab51610b07@mail.gmail.com>
	 <1257802044.31440.4.camel@localhost>
	 <81092d890911101554u37233080q43523f3069b93a2e@mail.gmail.com>
	 <1257931946.3022.6.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Nov 2009 10:47:36 +0100
Message-Id: <1257932856.3022.14.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-11-11 at 10:32 +0100, Dominick Grift wrote:
> On Tue, 2009-11-10 at 15:54 -0800, Larry Ross wrote:
> > On Mon, Nov 9, 2009 at 1:27 PM, Dominick Grift <domg472@gmail.com>
> > wrote:
> >         
> >         On Mon, 2009-11-09 at 12:54 -0800, Larry Ross wrote:
> >         > On Fri, Nov 6, 2009 at 3:23 PM, Eamon Walsh
> >         <ewalsh@tycho.nsa.gov>
> >         > wrote:
> >         >
> >         >         On 11/06/2009 05:11 PM, Dominick Grift wrote:
> >         >         > On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry
> >         Ross wrote:
> >         >         >
> >         >         >> On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh
> >         >         <ewalsh@tycho.nsa.gov> wrote:
> >         >         >>
> >         >         >>
> >         >         >>>  On 11/04/2009 06:57 PM, Larry Ross wrote:
> >         >         >>>
> >         >         >>>> I have two selinux users that need to be able
> >         to stop and
> >         >         start the
> >         >         >>>> mysql daemon, which is started by the
> >         initialization
> >         >         scripts.  When
> >         >         >>>> the daemon is stopped and started by the
> >         secadm_u user,
> >         >         it ends up in
> >         >         >>>> the context secadm_u:secadm_r:mysqld_t.  When
> >         it is
> >         >         stopped and
> >         >         >>>> started by the dbadm_u user, it ends up in the
> >         >         >>>> dbadm_u:dbadm_r:mysqld_t context.  When it is
> >         started by
> >         >         the init
> >         >         >>>> scripts it ends up in the
> >         system_u:system_r:mysqld_t
> >         >         domain.
> >         >         >>>>
> >         >         >>>> I would like it to alway end up in the
> >         system_r:mysqld_t
> >         >         domain, but
> >         >         >>>> can't seem to find any documentation that
> >         describes how
> >         >         to get that to
> >         >         >>>> work.
> >         >         >>>>
> >         >         >>>> If I add a role_transition rule to transition
> >         the role to
> >         >         system_r
> >         >         >>>> when the executable is run:
> >         >         >>>> role_transition sysadm_r mysqld_safe_exec_t
> >         system_r;
> >         >         >>>> role_transition dbadm_r  mysqld_safe_exec_t
> >         system_r;
> >         >         >>>> I end up getting these errors:
> >         >         >>>>
> >         >         >>>> Nov  4 15:41:36 localhost kernel: type=1401
> >         >         audit(1257378096.775:46):
> >         >         >>>> security_compute_sid:  invalid context
> >         >         >>>> dbadm_u:system_r:mysqld_safe_t:s0 for
> >         >         >>>> scontext=dbadm_u:dbadm_r:initrc_t:s0
> >         >         >>>>
> >         tcontext=system_u:object_r:mysqld_safe_exec_t:s0
> >         >         tclass=process
> >         >         >>>>
> >         >         >>>> I believe I have the rules that should allow
> >         this, but
> >         >         obviously I am
> >         >         >>>> missing something.
> >         >         >>>> role dbadm_r types mysqld_safe_t;
> >         >         >>>> role sysadm_r types mysqld_safe_t;
> >         >         >>>> role system_r types mysqld_safe_t;
> >         >         >>>> and this:
> >         >         >>>> allow initrc_t mysqld_safe_t : process
> >         transition ;
> >         >         >>>> which is what the "security_compute_sid"
> >         message looks
> >         >         like it is
> >         >         >>>>
> >         >         >>> missing.
> >         >         >>>
> >         >         >>>> Does anyone know where I can find a good
> >         description of
> >         >         how to get a
> >         >         >>>> service to transistion back into system_r when
> >         started by
> >         >         a user or
> >         >         >>>> have any idea what I am missing?
> >         >         >>>>
> >         >         >>>
> >         >         >>> The run_init program was designed to solve this
> >         problem,
> >         >         take a look at
> >         >         >>> the man page.
> >         >         >>>
> >         >         >>> On Fedora at least, the "service" command calls
> >         run_init
> >         >         internally, so
> >         >         >>> doing "service mysqld start" should in theory
> >         start it up
> >         >         in the
> >         >         >>> system_r role.  If you're just running
> >         "/etc/init.d/mysld
> >         >         start" it
> >         >         >>> won't transition.
> >         >         >>>
> >         >         >>>
> >         >         >> That would be great, but I am trying to use this
> >         as normal
> >         >         users on a system
> >         >         >> to which the root account is locked.  As far as I
> >         know,
> >         >         run_init always asks
> >         >         >> for the root password.  Is there a way to use it
> >         without
> >         >         having access to
> >         >         >> the root password?
> >         >         >>
> >         >         > I think you can use pam_rootok
> >         in /etc/pam.d/run_init. I
> >         >         dont know the details of the top of my head because
> >         i use
> >         >         Fedora and the policy that i posted earlier so that
> >         i
> >         >         automatically transition to initrc_t without
> >         run_init.
> >         >         >
> >         >
> >         >
> >         >
> >         >         Yes, /etc/pam.d/run_init controls the password check
> >         done by
> >         >         run_init.
> >         >         Also, it only asks for the password of whatever user
> >         is
> >         >         running it, not
> >         >         always the root password.  The only reason it asks
> >         for a
> >         >         password is to
> >         >         verify that a human is present.
> >         >
> >         >         "run_init id -Z" from sysadm_r should print out
> >         >         "system_u:system_r:initrc_t".  Other roles might
> >         need the
> >         >         following line
> >         >         of policy to be able to run run_init (using the
> >         example of
> >         >         staff):
> >         >
> >         >         seutil_run_runinit(staff_t, staff_r)
> >         >
> >         >         The policy snippet Dominick posted earlier also
> >         works.
> >         >
> >         > I get a syntax error when I try to use that snippet:
> >         >
> >         > # make -f /usr/share/selinux/devel/Makefile
> >         > Compiling strict appmysql module
> >         > /usr/bin/checkmodule:  loading policy configuration from
> >         > tmp/appmysql.tmp
> >         > appmysql.te:62:ERROR 'syntax error' at token
> >         > 'init_labeled_script_domtrans' on line 92695:
> >         > init_labeled_script_domtrans(mysqld_safe_t,
> >         mysqld_safe_exec_t)
> >         > /usr/bin/checkmodule:  error(s) encountered while parsing
> >         > configuration
> >         > make: *** [tmp/appmysql.mod] Error 1
> >         >
> >         > is init_labeled_script_domtrans defined for RHEL 5.3?  I see
> >         it used
> >         > in the files below:
> >         >
> >         > /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/virt.if:        init_labeled_script_domtrans($1, virtd_initrc_exec_t)
> >         > /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/avahi.if:       init_labeled_script_domtrans($1, avahi_initrc_exec_t)
> >         > /usr/src/redhat/BUILD/serefpolicy-2.4.6/policy/modules/services/spamassassin.if:        init_labeled_script_domtrans($1,spamd_script_exec_t)
> >         >
> >         > but I don't see it defined anywhere.
> >         
> >         
> >         If it is there then it should be defined in init.if.
> >         
> >         You could simply add this to your mysqladm interface file:
> >         
> >         ########################################
> >         ## <summary>
> >         ##      Transition to the init script domain
> >         ##      on a specified labeled init script.
> >         ## </summary>
> >         ## <param name="domain">
> >         ##      <summary>
> >         ##      Domain allowed access.
> >         ##      </summary>
> >         ## </param>
> >         ## <param name="init_script_file">
> >         ##      <summary>
> >         ##      Labeled init script file.
> >         ##      </summary>
> >         ## </param>
> >         #
> >         interface(`init_labeled_script_domtrans',`
> >                gen_require(`
> >                        type initrc_t;
> >                ')
> >         
> >                domtrans_pattern($1, $2, initrc_t)
> >                files_search_etc($1)
> >         ')
> >         
> >         That should atleast make it work for that module. Hopefully
> >         the other
> >         policy in the snippit is supported.
> >  
> > I have seen this before, and I find it confusing, I get denials:
> >  
> > Nov 10 15:03:43 localhost kernel: type=1400 audit(1257894223.988:43):
> > avc:  denied  { transition } for  pid=3799 comm="mysql"
> > path="/usr/bin/mysqld_safe" dev=dm-1 ino=460035
> > scontext=app_dbadm_u:app_dbadm_r:initrc_t:s0
> > tcontext=app_dbadm_u:system_r:mysqld_safe_t:s0 tclass=process
> > 
> > I run that denial through audit2allow and I get this:
> > #============= initrc_t ==============
> > allow initrc_t mysqld_safe_t:process transition;
> > 
> > That rule is already present in the policy:
> > allow initrc_t mysqld_safe_t:process transition;
> > 
> > Can anyone tell me why this happens?  Am I missing something?  Is
> > audit2allow confused?  Is the rule not being honored for some reason?
> 
> Look for a SELINUX_ERR line. Are there any in your audit.log?
> 
> It may (or may not) be because you need might need: allow app_dbadm_r
> system_r;
> 

Also make sure that you map system_r to your selinux user (app_dbadm_u)

example:

semanage user -m -L s0 -r s0 -R "staff_r system_r app_dbadm_r" -P user
app_dbadm_u

> >  
> >   -- Larry
> >  
> >  
> >  
> >         >   -- Larry
> >         >
> >         >
> >         >
> >         >
> >         >         >
> >         >         > BTW, I am using RHEL 5.3, do you know if service
> >         there calls
> >         >         run_init
> >         >         > internally?
> >         >
> >         >
> >         >         I was mistaken about this, as pointed out by Paul,
> >         service
> >         >         doesn't call
> >         >         run_init.
> >         >
> >         >
> >         >
> >         >         --
> >         >
> >         >
> >         >         Eamon Walsh
> >         >         National Security Agency
> >         >
> >         >
> >         >
> >         
> >         
> >         
> > 
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
