Subject: Re: [v2] [SELinux] Discussions about rbacsep
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Harry Ciao <qingtao.cao@windriver.com>, cpebenito@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1299852669.3432.22.camel@moss-pluto>
References: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
	 <1299852669.3432.22.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Mar 2011 14:04:20 -0500
Message-ID: <1299870260.16505.16.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-11 at 09:11 -0500, Stephen Smalley wrote:
> On Fri, 2011-03-11 at 15:20 +0800, Harry Ciao wrote:
> > Hi Stephen and Chris,
> > 
> > I have fixed the semantics of the role_transtion rule for the newly created files or dirs objects same as that for the process class. Since class-specific role_transition rules would be handled after TE rules, we could make use of checking if (newcontext.type == roletr->type) and (scontext->role == roletr->role) before setting newcontext.role = roletr->new_role;
> > 
> > Then in the refpolicy we could adopt Stephen's suggestion for the role_transition rule such as:
> > 	role_transition sysadm_r user_home_t sysadm_r;
> > 
> > But I think we could omit class in above rule, since such role_transition semantics only takes place when filedir == true, that is, when the new object is of file or dir class.
> 
> If we omit the class, then the above statement has two possible
> interpretations:
> 1) When a process in sysadm_r executes a program labeled user_home_t,
> the process transitions to sysadm_r (no effect in this case, but it
> would have an effect if the new role were something other than the old
> one), or
> 2) When a process creates a file in a directory labeled user_home_t,
> then the new file will be labeled with sysadm_r.
> 
> I'm concerned about that ambiguity in the meaning of the rule if we
> don't explicitly specify the class. Also, by not specifying the class,
> you keep us from re-using this mechanism for other object classes in a
> general manner.
> 
> I don't think that it would be too hard to add an optional class field
> to the role_transition statements; you can follow the model of what we
> did for range_transitions when we added the class field to it.  That
> does require a policy version bump and an updated checkpolicy/libsepol.
> 

Adding the class field and making the role_transition look like other
transition rules seem to me to be the right way to go.

> What would also be desirable would be a new policy construct that would
> allow us to specify the default labeling behavior for each component of
> the security context on a per-class basis, e.g.
> 	role_default file fromtarget;
> 	role_default process fromsource;
> 	user_default socket fromsource;
> 	...
> 

I like the idea, but something like "role_default_label_src" or
"role_label_src" would seem to be more descriptive to me.

> That would eliminate the need for the security_is_*_class functions and
> the special handling in the kernel for particular classes, and migrate
> all of this logic into the policy.  That however may be more than you
> are willing to take on at the present time.
> 

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
