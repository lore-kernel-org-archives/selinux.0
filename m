Subject: Re: State of Debian SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil>
References: <20050917233111.GA17916@vnl.com>
	 <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil>
	 <20050920181039.GL16888@vnl.com>
	 <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 15:41:26 -0400
Message-Id: <1127418086.19487.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 16:14 -0400, Stephen Smalley wrote:
> On Tue, 2005-09-20 at 19:10 +0100, Dale Amon wrote:
> > Setting up selinux-policy-default (1.18-1) ...
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > libsepol.expand_avtab_insert: Type conflict!
> > Out of memory - unable to check assertions
> > Check assertions failed.
> > make: *** [/etc/selinux/policy/policy.20] Error 255
> <snip>
> > Suggestions?
> 
> Yes, send me (privately) a copy of the policy.conf file.

Just to follow-up on list, after receiving the policy.conf file in
question, I found that:

1) The erroneous output from checkpolicy above is corrected by the diff
I posted for libsepol (1.8->1.9.1) that was already in sourceforge CVS.
Note that checkpolicy has to be rebuilt to pick up the patched libsepol,
as it uses the static library.

2) With the libsepol fix applied and checkpolicy rebuilt, checkpolicy
then reports legitimate assertion failures on some conditional rules in
the policy.conf.  These particular assertion failures were due to the
etc_writer attribute on the kernel_t type being wrapped by an obsolete
ifdef leftover from when we were using compile-time tunables rather than
runtime policy booleans for nfs exports.  Older versions of checkpolicy
weren't checking the conditional rules against the assertions, so they
wouldn't report this failure.  The policy fix is to add the etc_writer
attribute unconditionally to the kernel_t type, and was already in
sourceforge CVS.

3) With the policy fix applied, checkpolicy successfully compiles the
policy.conf file.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
