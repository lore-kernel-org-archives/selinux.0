Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EE7K7C017783
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 10:07:20 -0400 (EDT)
Subject: Re: Latest Patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <4256D267.7050403@comcast.net>
References: <4256D267.7050403@comcast.net>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 10:04:37 -0400
Message-Id: <1113487477.6549.18.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

You didn't actually add anything to tunables.tun, so I added:
+# Do not allow sysadm_t to be in the security manager domain
+dnl define(`separate_secadm')
Feel free to change.

When I tested the policy, I couldn't newrole to secadm_r.  Steve found
that there was a bug in the newrole policy.  It needed the fowner
capability, so that was added.

Other then that, it seems to work as advertised.

On Fri, 2005-04-08 at 14:50 -0400, Daniel J Walsh wrote:
> This one needs to be reviewed.   I have added secadm_r:secadm_t
> 
> Basically I have created a new macro
> 
> security_manager_domain($1)
> 
> Which is called by sysadm and secadm
> 
> This domain has all the rules necessary for manipulating policy and 
> selinux objects.
> 
> It also adds an attribute secadmin, which is the only attribute allowed 
> to transition to checkpolicy_t, setfiles_t, load_policy_t
> 
> A tunable is built around allowing sysadm_t in this domain.   (Defaults 
> to sysadmin in this domain).
> 
> Also created a limited_user_role domain that is called by 
> full_user_role.  With all the allow rules required to get secadm_r to work.
> 
> I had to put the role secadm_r types XYZ types all over the place.  I 
> would be nice if the language made this easier.
> Right now we have role sysadm_r there also, so even if the transition is 
> not allowed the role rule is still there.  
> 
> A few strange rules allowing checkpolicy and load_policy to read 
> sysadm_tmp_t files has been removed.
> 
> I treated restorecon differently from the other policy files since I 
> could see where a sysadm might need access to this while
> setfiles is less likely.  We can argue this point.
> 
> Added a privsysmod attribute for any domain needing sys_module.  
> (kernel, howl, insmod and NetworkManager)
> 
> Changed admin_tty_type from a define to an attribute.  Made it easier to 
> add additional admin ttys in the future.
> 
> Some changes from Ivan are also here.
> 
> mudutil.te removed from targeted directory, since we are now using the 
> full modutil.te from strict.
> 
> I think we can tighten up the differentiation between sysadm_t and 
> secadm_t by removing sysadmfile from all of the policy files.
> 
> The rules in security_manager_domain add those rules back in.   
> limited_user_domain could also be a little tighter. 
> 
> Steve Grubb mentioned to me there is also a need, request for and 
> "auditadmin" role, so with some of these changes that would
> be pretty easy to implement.   Now just need to get libsepol_usermod 
> stuff done.
> 
> 
> Dan

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
