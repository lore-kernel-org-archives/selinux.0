MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Clip] Unexpected role change from custom role back to user_r
Date: Wed, 27 May 2009 12:44:38 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804C16C93@AZ25EXM04.gddsi.com>
In-Reply-To: <000901c9deff$a7c08a90$f7419fb0$@com>
References: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com> <1243446033.2752.19.camel@localhost.localdomain> <000901c9deff$a7c08a90$f7419fb0$@com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: "Brian Williams" <brian@bri3001.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <clip@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

System is mls
System is currently in permissive mode
Policy is modular but all modules are in the base policy

Files changed with custom role:

src/config/appconfig-mls/default_type --------------------
app_pso_r:app_pso_t

src/config/appconfig-mls/default_contexts ----------------
system_r:xdm_t:s0	user_r:user_t:s0 staff_r:staff_t:s0
sysadm_r:sysadm_t:s0 unconfined_r:unconfined_t:s0 app_pso_r:app_pso_t:s0

src/config/appconfig-mls/app_pso_u_default_contexts ------
system_r:xdm_t:s0	app_pso_r:app_pso_t:s0

src/policy/rolemap ---------------------------------------
app_pso_r app_pso app_pso_t

src/policy/users -----------------------------------------
gen_user(app_pso_u, app_pso, app_pso_r , s0, s0 - mls_systemhigh,
mcs_allcats)

src/policy/modules/app/app_pso.te ------------------------

policy_module(app_pso,1.0.0)

role app_pso_r;

userdom_unpriv_user_template(app_pso)
 
Working on logs I can send to mailing list

Gary West
-----Original Message-----
From: Brian Williams [mailto:brian@bri3001.com] 
Sent: Wednesday, May 27, 2009 12:17 PM
To: 'Stephen Smalley'; West, Gary-P55389
Cc: clip@oss1.tresys.com; selinux@tycho.nsa.gov
Subject: RE: [Clip] Unexpected role change from custom role back to
user_r

> -----Original Message-----
> From: clip-bounces@oss.tresys.com [mailto:clip-bounces@oss.tresys.com]
> On Behalf Of Stephen Smalley
> Sent: Wednesday, May 27, 2009 1:41 PM
> To: West, Gary-P55389
> Cc: clip@oss1.tresys.com; selinux@tycho.nsa.gov
> Subject: Re: [Clip] Unexpected role change from custom role back to 
> user_r
> 
> On Wed, 2009-05-27 at 10:23 -0700, West, Gary-P55389 wrote:
> > I have a custom SELinux policy (based on clip), user and role that 
> > will login through X windows. When the user logs in, see the 
> > USER_ROLE_CHANGE to the desired role. All X clients have the user_r 
> > and user_t and not the custom role and type shown in the 
> > USER_ROLE_CHANGE message. Can someone explain how this secondary 
> > role change would happen?
> 
> Not offhand.  Can you supply more details, please?
> 

Please include not only details on the policy but also the
default_contexts file.  This file tells X what roles and types to try
when users log in.  If a role is not in this file, there is a chance
that xdm (or whatever is logging you in) could not even try the custom
role and type because it is not in the list to try.  

> --
> Stephen Smalley
> National Security Agency
> 
> _______________________________________________
> Clip mailing list
> Clip@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/clip




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
