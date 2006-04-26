Subject: Re: Labeling only policy and problems with booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin.torok@level7.ro>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net,
        marius@cs.utt.ro
In-Reply-To: <200604232258.14004.edwin.torok@level7.ro>
References: <200604021240.21290.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <200604172120.52193.edwin@gurde.com>
	 <200604232258.14004.edwin.torok@level7.ro>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Apr 2006 09:37:50 -0400
Message-Id: <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-04-23 at 22:58 +0300, Török Edwin wrote:
> I am trying to write a policy that does only labeling.
> I am asking for your opinion(s) before developing any further.
> 
> In particular I'm interesting in having sockets created by a process labeled 
> with that process's type. This is by default I assume.

Yes.

> Furthermore I want to do this:
> - The process's type shall be determined by the security context of the 
> program
> - launching the program should be possible from anywhere (by any other 
> program)
> 
> I started my policy based on the reference policy.
> So here it is the policy module:
> ----------
> policy_module(test_module,1.0)
> type myapp_exec_t;
> gen_require(`
>              type unlabeled_t;
>         ')
> files_type(myapp_exec_t)
> domain_type(myapp_t)
> unconfined_domain(myapp_t)
> domain_entry_file(myapp_t, myapp_exec_t)
> domain_auto_trans(unlabeled_t,myapp_exec_t,myapp_t)

No process should be running in unlabeled_t (a process might be
re-mapped to unlabeled_t if its type was removed from policy and policy
was reloaded while the process was still running, but this would quickly
lead to death for the process as it would lose access to its resources).

> domain_auto_trans(unconfined_t,myapp_exec_t,myapp_t)
> domain_auto_trans(initrc_t,myapp_exec_t,myapp_t)

Should be some higher level interface for running a program as a user
app and as a daemon, right?  You don't want to make direct references to
other modules' types if it can be avoided.

> libs_use_ld_so(myapp_t)
> libs_use_shared_libs(myapp_t)
> role system_r types myapp_t;
> role user_r types myapp_t;
> -------------
> I then label the program with myapp_exec_t.
> Good, now I want to restrict his:
> - There should be no way for a process to set its security context, 
> - policy loading and relabeling should be restricted to a single domain. 
> - If one enters enforcing mode, there should be no way back
> 
> So I remove the selinux_unconfined from unconfined_t, and I set the
> secure_mode_policyload at runtime.
> Here I got into a problem. Although I set the secure_mode (all 3 of them) to 
> 1, and verified that they are indeed set via /selinux/booleans, 
> I still could load policy. I even got avc granted messages.
> 
> This shouldn't be happening. I examined the generated base.conf manually, but 
> the only place where load_policy was allowed 
> was 'if(!secure_mode_policyload)'. I commented those lines out, rebuilt the 
> policy, and now I couldn't load a policy anymore. Ok this is what I wanted. 
> 
> But why didn't the booleans work? I tried setting their default values in 
> booleans.conf to true, and still the same result, they weren'
> t taken into consideration.

I think we need more details to see whether this is a bug or not.  What
version of refpolicy?  What version of checkpolicy?  There was a problem
with the boolean mapping at link time with the optionals-in-base changes
to refpolicy and certain versions of checkpolicy, but I think that has
been resolved in the current version (although optionals-in-base still
doesn't work properly, but that doesn't affect you as long as you are
building everything you need into base).

> (btw, I also ran into a make bug: 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=358903, I hope this booleans 
> problems isn't another build-tool related bug, if needed I can make the 
> compiled policy module available for analysis)

Yes, that would be helpful.

> I also thought of having an attribute fireflier_generated, and then create a 
> single rule to allow unconfined_t transition to fireflier_generated types, 
> and fireflier_generated_types -> unconfined_t. Would this be faster?

Originally, attributes were all expanded when policy was compiled, and
the kernel just dealt with the individual pairs.  But current kernels
and policies retain attributes in the rules when feasible, so the
representation is more compact if you use attributes in your rules.  So
you save memory that way.  Runtime processing itself is largely
unaffected, as the access vector cache provides most of the security
decisions, so security server computations are infrequent.

> Also since all programs will have unlabeled_t by default, there is no point to 
> do an initial relabeling, so either:
>  - mount -o context=unconfined_t
>  - do nothing, and the programs will get by default unlabeled_t, or file_t, 
> right?

Using unlabeled_t in this way is a bad idea; it is used internally for
various purposes to identity unlabeled entities or entities that have
become unlabeled due to label invalidation.

> One of the other goals is the ability to be able to boot the system in 
> enforcing mode, without any manual policy modifications. If all programs are 
> unconfined_t/default_t will this be possible?

If everything is unconfined, then naturally enforcing mode has no real
impact on behavior.

> I also thought of creating an even more minimal base policy, but I am not sure 
> what I should remove from there, without breaking anything (I've seen class, 
> inherit, constrain, sid, portcon, fs_xattr,... I think these are critical for 
> selinux policy work, aren't they?) Would a more minimal policy make selinux 
> work faster?

The flask definitions (classes, initial SIDs, access vectors) shouldn't
be disturbed, as they are generated into definitions that are built into
the kernel.  The fs_use definitions are fundamental and shouldn't be
modified except possibly to add new ones if appropriate for some
filesystem type that you are using.  Constraints do slow down processing
of the security server computation, but most security decisions are
provided by the AVC after the first such computation, so it isn't really
critical, and the constraints do provide important restrictions.  Object
context definitions like portcon, netifcon, etc. can be omitted if you
aren't truly using the SELinux network access controls.  Primarily, you
just want to minimize the TE rules for memory efficiency.

> Since all the programs that need access to the socket are running already (we 
> are generating policies on-the-fly), we can ask the user which programs he 
> wants to give access to the socket, and create a policy for that. Maybe 
> creating an attribute, and applying that attribute to those programs' types, 
> and create a "neverallow ~myattribute" rule for the socket access.

neverallow rules don't grant access; they just specify invariants that
should be checked when policy is compiled (or in the case of modules,
when policy is linked and expanded to kernel policy).

> The big issue here is creating a domain that is equivalent, because AFAIK 
> there is no inheritance for types in selinux (there is inheritance for 
> classes though right?).

Right, there is no inheritance for types.  Object classes have a
primitive inheritance mechanism for their permission sets, but it is
very limited.

> So one possible way of doing this would be using the tool sesearch to search 
> for all the transitions/allow/dontallow rules, and then do a replace of old 
> type with new type, watching out for this: not giving access to the socket to 
> other programs.
> Is there any other way of creating an equivalent type? (I want to create an 
> equivalent type, because I dont' want to change the user's policy much, I 
> only want the sockets to have a different label, for the purpose of iptables 
> match; as far as the selinux rules are concerned they should be identical to 
> the old type).

Hmmm...there used to be a clone statement in the language, but it was
ultimately dropped because the semantics were ambiguous and what you
usually want is not truly complete equivalence, just structural
parallel.  e.g. for the new type, you don't want to allow it access to
private/derived types of the old type - you want to allow it to access
its own private/derived types.  And you don't necessarily want to allow
the same relationships with ancestors and descendants.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
