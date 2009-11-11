Message-ID: <4AFA094D.1030701@tycho.nsa.gov>
Date: Tue, 10 Nov 2009 19:46:05 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Larry Ross <selinux.larry@gmail.com>
CC: selinux@tycho.nsa.gov, Dominick Grift <domg472@gmail.com>
Subject: Re: "security_compute_sid: invalid context" error when 	starting/stopping
 mysqld daemon
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>	 <4AF482CA.4090109@tycho.nsa.gov>	 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>	 <20091106221120.GA4921@notebook3.grift.internal>	 <4AF4AFFC.9060505@tycho.nsa.gov>	 <81092d890911091254g1b9616e6l54d352ab51610b07@mail.gmail.com>	 <1257802044.31440.4.camel@localhost> <81092d890911101554u37233080q43523f3069b93a2e@mail.gmail.com>
In-Reply-To: <81092d890911101554u37233080q43523f3069b93a2e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/10/2009 06:54 PM, Larry Ross wrote:

[snip]
>
> I have seen this before, and I find it confusing, I get denials:
>  
> Nov 10 15:03:43 localhost kernel: type=1400 audit(1257894223.988:43):
> avc:  denied  { transition } for  pid=3799 comm="mysql"
> path="/usr/bin/mysqld_safe" dev=dm-1 ino=460035
> scontext=app_dbadm_u:app_dbadm_r:initrc_t:s0
> tcontext=app_dbadm_u:system_r:mysqld_safe_t:s0 tclass=process
> I run that denial through audit2allow and I get this:
> #============= initrc_t ==============
> allow initrc_t mysqld_safe_t:process transition;
> That rule is already present in the policy:
> allow initrc_t mysqld_safe_t:process transition;
> Can anyone tell me why this happens?  Am I missing something?  Is
> audit2allow confused?  Is the rule not being honored for some reason?


There are additional "constrain" statements in the policy that can
override allow rules.  They are in the "policy/constraints" file in the
policy source.  In this case, I think you are hitting the following
constraint:

constrain process { transition noatsecure siginh rlimitinh }
(
        r1 == r2 
        or ( t1 == can_change_process_role and t2 == process_user_target )
        or ( t1 == cron_source_domain and t2 == cron_job_domain )
        or ( t1 == can_system_change and r2 == system_r )
        or ( t1 == process_uncond_exempt )
);


Which says you can't transition unless the new role is the same as the
old role (first line) or your type meets one of four exceptions
(remaining lines).  audit2allow does get confused here because the AVC
message doesn't indicate that it's because of a constraint violation. 
This is a known problem.

In the denial above, the source context is initrc_t but running in the
app_dbadm_r role.  I think you want to already be in the system_r role
when you are running as initrc_t.  Which is what the last three lines of
Dominick's snippet do:

# When app_dbadm_t runs the mysql init script, change to initrc_t
init_labeled_script_domtrans(app_dbadm_t, mysqld_initrc_exec_t)

# Exempt app_dbadm_t from the role-change constraint (to system_r only)
domain_system_change_exemption(app_dbadm_t)

# When app_dbadm_r runs the mysqld init script, change to system_r:
role_transition app_dbadm_r mysqld_initrc_exec_t system_r;
allow app_dbadm_r system_r;


If you do have this policy in place, check the label on the
/etc/init.d/mysql script and make sure it corresponds to the one in the
policy.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
