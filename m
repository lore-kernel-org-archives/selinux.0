MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Clip] Unexpected role change from custom role back to user_r SOLVED
Date: Fri, 29 May 2009 13:38:10 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804C17431@AZ25EXM04.gddsi.com>
In-Reply-To: <001201c9df27$4e1dbc60$ea593520$@com>
References: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com> <1243446033.2752.19.camel@localhost.localdomain> <000901c9deff$a7c08a90$f7419fb0$@com> <FA8938DBA959E546BF6527F085F22FF804C16C93@AZ25EXM04.gddsi.com> <1243453645.2752.33.camel@localhost.localdomain> <FA8938DBA959E546BF6527F085F22FF804C16CEC@AZ25EXM04.gddsi.com> <001201c9df27$4e1dbc60$ea593520$@com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: "Brian Williams" <brian@bri3001.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <clip@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI

The file /etc/selinux/clip/seusers had permissions of 600.
This prevented libselinux from getting the correct selinux user.
The default user was used.

Thanks for all the suggestions.

Gary 

> -----Original Message-----
> From: Brian Williams [mailto:brian@bri3001.com] 
> Sent: Wednesday, May 27, 2009 5:00 PM
> To: West, Gary-P55389; 'Stephen Smalley'
> Cc: clip@oss1.tresys.com; selinux@tycho.nsa.gov
> Subject: RE: [Clip] Unexpected role change from custom role 
> back to user_r
> 
> > -----Original Message-----
> > From: West, Gary-P55389 [mailto:Gary.West@gdc4s.com]
> > Sent: Wednesday, May 27, 2009 4:45 PM
> > To: Stephen Smalley
> > Cc: Brian Williams; clip@oss1.tresys.com; selinux@tycho.nsa.gov
> > Subject: RE: [Clip] Unexpected role change from custom role back to 
> > user_r
> > 
> > I believe the selinux default context overrides the default context 
> > without the user.
> 
> The app_pso_u_default_contexts file should automagically 
> change to app_pso_u on the installed system, if that works 
> than any linux user that gets that SELinux user should get 
> the correct role.  If that fails I think it dumps to 
> default_contexts to try those next.  I am fairly sure it 
> doesn't just try user_r as a fallback, but it might.  So in 
> all, it checks 
> /etc/selinux/clip/contexts/users/SELinux_user_name, then 
> /etc/selinux/clip/contexts/default_contexts.  I am not 100% 
> on the order if that fails.  Honestly I find it easier to 
> just throw everything in default_contexts, I find it rare 
> that there is more than one role per SELinux user, at least 
> for logging in.
> 
> > 
> > While trying to generate logs. I have noticed that sometimes the 
> > processes come up with the correct selinux user (app_pso_u) and 
> > sometimes it comes up with user_u. It is consistant across 
> reboots but 
> > when ever I update a policy, it may or may not change.
> 
> Sounds odd, check semanage to see what users should be 
> picked. Also are the user_r logins getting user_u or 
> app_pso_u?  Also I normally use monolithic policy, if all of 
> your modules are in base why are you using modular?  Do you 
> intend on users adding modules on the fly or do you just want 
> to use semanage at runtime?
> 
> > 
> > The same policy rpm when loaded with the current policy 
> files removed 
> > before the install may produce different results.
> > 
> > I have several policy rpm files on the target. I am trying 
> to get some 
> > consistant results.
> > 
> 
> If you can do a build on the actual system, I'd suggest 
> trying that to rule out any rpm/time madness.  I am not 100% 
> clear what you mean by several policy RPMs. I do know that 
> sometimes you can run into the install process not 
> overwriting files that are currently on the system.  I 
> believe this is on purpose because if you want to update a 
> policy on RHEL and do a yum update, you might want it to keep 
> the current default_contexts and local_users since they might 
> be custom for the system.  It's just important to make sure 
> the files on the system are the ones that were supposed to 
> install, switching the policy name to something different 
> makes sure of that but is also a huge hassle.  Also I have 
> seen policy files not being overwritten because of timestamp 
> problems where the time on the build system was so far in the 
> past it always thought the files on the target system were 
> newer and didn't install them.
> 
> > Gary
> > 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Wednesday, May 27, 2009 12:47 PM
> > To: West, Gary-P55389
> > Cc: Brian Williams; clip@oss1.tresys.com; selinux@tycho.nsa.gov
> > Subject: RE: [Clip] Unexpected role change from custom role back to 
> > user_r
> > 
> > On Wed, 2009-05-27 at 12:44 -0700, West, Gary-P55389 wrote:
> > > System is mls
> > > System is currently in permissive mode Policy is modular but all 
> > > modules are in the base policy
> > >
> > > Files changed with custom role:
> > >
> > > src/config/appconfig-mls/default_type -------------------- 
> > > app_pso_r:app_pso_t
> > >
> > > src/config/appconfig-mls/default_contexts ----------------
> > > system_r:xdm_t:s0	user_r:user_t:s0 staff_r:staff_t:s0
> > > sysadm_r:sysadm_t:s0 unconfined_r:unconfined_t:s0 
> > > app_pso_r:app_pso_t:s0
> > 
> > Doesn't this cause you to still default to user_r (if the user is 
> > authorized for both user_r and app_pso_r), since user_r is listed 
> > first?
> > 
> > --
> > Stephen Smalley
> > National Security Agency
> 
> 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
