Subject: Re: Backwards compatibility (proposal for a new compat_net like
	flag)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708301602.27272.paul.moore@hp.com>
References: <200708301602.27272.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 16:07:44 -0400
Message-Id: <1188504464.26572.355.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 16:02 -0400, Paul Moore wrote:
> As you may have noticed there has been a _lot_ of discussion lately about the 
> labeled networking functionality in SELinux and how to both improve the 
> existing functionality as well as introduce new functionality to enable 
> SELinux to be used in more and more places.  Several different things were 
> debated including fallback peer labels, packet flow control, loopback 
> labeling, and the use of unified access checks for the different peer 
> labeling mechanisms (NetLabel, labeled IPsec).
> 
> While it should be possible to implement some of the new ideas while retaining 
> backwards compatibility (fallback labels, loopback labeling) some other ideas 
> would most likely introduce problems when used with older policy (packet flow 
> control, unified access checks).  Unfortunately, as discussed numerous times 
> before, we don't presently have a good way to select kernel behavior at 
> runtime and if we want to move forward with some of the new labeled 
> networking ideas we need a way to preserve the existing behavior.
> 
> To help solve this problem I'd like to propose we introduce a new tunable, 
> similar to the existing compat_net flag, but instead of it being a simple 
> boolean value I would like to implement it as an integer value.  This new 
> tunable, let's call it "select_net", would act as a versioning value for the 
> network access controls.  The existing behavior would be used when 
> select_net==0 and the new behavior would be used when select_net==1; if we 
> needed to introduce new checks in the future which could break compatibility 
> we only enable them when select_net==2.
> 
> Thoughts?  It's not perfect, I know, but I'd like to be able to start moving 
> forward with some of these labeled networking changes but the compatibility 
> concerns are crippling us ...

Why make it specific to the network access controls, vs. a general
versioning scheme for permission checks as discussed in the allow
unknown thread?  Also, decoupling it from the policy as a separate
selinuxfs setting is problematic - what we want is a way for a given
policy to select the right mode based on the checks it expects/requires.
The separate setting makes it more likely to be out of sync and means we
can't atomically change it and load new policy together.

BTW, the allow unknown patches could still be merged if we think they
would be useful; they are mostly just pending on some requested
cleanups.  They would at least avoid causing denials on new permission
checks until policy defines them, once policies are deployed with the
new flag.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
