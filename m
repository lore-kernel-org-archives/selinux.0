Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA26988
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 07:50:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA22729
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 11:48:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA22725 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 11:48:31 GMT
Date: Tue, 9 Jul 2002 07:49:43 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: JW <jw@centraltexasit.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Is make relabel suposed to be run from policy or or setfiles?
In-Reply-To: <200207082016.36223.jw@centraltexasit.com>
Message-ID: <Pine.GSO.4.33.0207090723320.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Jul 2002, JW wrote:

> /usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:inetd_var_log_t on line number 625
> /usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:initrc_runlevel_t on line number 669

The types listed above are not defined in the upstream .te files nor are
they used in the upstream .fc files.  So I'll assume that you are using a
customized policy other than the example policy.  It would be helpful to
explicitly identify what policy you are using.  In any event, the error is
quite simple:  you are using types in your .fc files that are not defined
in your .te files.

> I noticed a post from Russel suggested that make relabel should be run from selinux/setfiles/ not selinux/policy, but I'm not sure
> if that's correct or not.

That changed in the May 2nd release.  Prior to that release, the file
contexts configuration lived in the setfiles directory separately from the
policy and you ran 'make relabel' in the setfiles directory.  Since that
release, the file contexts configuration has lived under the policy
directory and you perform the 'make relabel' in the policy directory.

> ccs001:/usr/src/selinux/setfiles # make relabel
> chcon system_u:object_r:setfiles_exec_t /usr/local/selinux/bin/setfiles
> ccs001:/usr/src/selinux/setfiles #

This is not the 'make relabel' that you want.  The 'relabel' targets in
the setfiles, selopt, and utils Makefiles are selective relabels of
specific programs installed by those Makefiles, as opposed to a full
relabeling of the entire filesystem.  These targets are a convenience when
installing new versions of these particular programs on an existing
SELinux system so that you can do a 'make install relabel' of these
programs and end up with a newly installed program with the right security
context.  They are separate from the base 'install' target since they will
not work on a non-SELinux kernel for an initial install of SELinux.

> I'll also point out that step 17 (PATH changes) have to occur before you
> can run make relabel, because use is made of /usr/local/selinux/chcon

Not a problem.  The 'make relabel' that you want doesn't use chcon.

> Just out of curiosity, why do you have to be root to do that? I have no doubt that I've much to lera here :-) but considering that 'jw' is sysadm_* and 'root' is just user_*, I would think that jw would be the
> proper account to run make relabel under.

You need to be root to create and/or update the persistent label mappings
(if running on a non-SELinux kernel) and to traverse the entire
filesystem (whether running on a non-SELinux kernel or a SELinux kernel).
You can login as a normal user initially, but you need to su to root.
When running on a SELinux kernel, you also need to be in sysadm_r.

Keep in mind that the SELinux access controls are orthogonal to the Linux
access controls, and that both access controls must authorize an operation
in order for it to be performed.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
