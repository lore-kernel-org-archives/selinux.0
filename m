From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Backwards compatibility (proposal for a new compat_net like flag)
Date: Thu, 30 Aug 2007 16:30:11 -0400
Cc: selinux@tycho.nsa.gov
References: <200708301602.27272.paul.moore@hp.com> <1188504464.26572.355.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1188504464.26572.355.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708301630.11322.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 30 2007 4:07:44 pm Stephen Smalley wrote:
> On Thu, 2007-08-30 at 16:02 -0400, Paul Moore wrote:
> > Thoughts?  It's not perfect, I know, but I'd like to be able to start
> > moving forward with some of these labeled networking changes but the
> > compatibility concerns are crippling us ...
>
> Why make it specific to the network access controls, vs. a general
> versioning scheme for permission checks as discussed in the allow
> unknown thread?

Just trying to limit the impact.  I would much prefer to utilize an existing 
versioning scheme.

> Also, decoupling it from the policy as a separate 
> selinuxfs setting is problematic - what we want is a way for a given
> policy to select the right mode based on the checks it expects/requires.
> The separate setting makes it more likely to be out of sync and means we
> can't atomically change it and load new policy together.
>
> BTW, the allow unknown patches could still be merged if we think they
> would be useful; they are mostly just pending on some requested
> cleanups.  They would at least avoid causing denials on new permission
> checks until policy defines them, once policies are deployed with the
> new flag.

I'm open to suggestions.  

While the allow unknown class/perm patches would help in the case of new 
access checks it wouldn't help to "toggle" between different types of access 
checks in a way that a versioning scheme would (at least it wouldn't in it's 
current form).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
