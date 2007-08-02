From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown classes and perms
Date: Thu, 2 Aug 2007 14:43:26 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Karl MacMillan <kmacmillan@mentalrootkit.com>
References: <1185983352.3673.16.camel@localhost.localdomain> <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil> <1186075512.4405.34.camel@localhost.localdomain>
In-Reply-To: <1186075512.4405.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708021443.26314.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 2 2007 1:25:12 pm Eric Paris wrote:
> Maybe instead a versioning scheme?  Every security check comes with a
> 'version.'  Every time we add/change a security check we add one to the
> 'version' for that check.  If the policy handed to the kernel has a
> 'version' less than the value we get from the security hook call coded
> in kernel we can just allow it?   Maybe that could be a solution to the
> issue I am addressing now along with things like this netlabel change?
> It certainly would have to touch a whole lot of stuff and might be a
> pain to keep up with.  Lets say I move a security hook around in a
> function, I need to decide if the version need to be bumped on that hook
> or not.  Not impossible, but not pretty.  Also probably means a policy
> version update, which in turn breaks the discussion which we have
> ongoing above....

While I'm not an expert on the policy aspects of this discussion and how the 
kernel and userspace objects managers interact I think at some point we are 
going to need something like what Eric proposes above.  With the requirement 
that new kernels must not regress when using old policy we are going to run 
into issues as we move forward and add new permission checks.  While I don't 
think we've seen it yet, it is reasonable to think that this problem will 
expand into userspace as we develop more and more userspace object managers 
such a X, CUPS, Postgres, etc.

I know the changes aren't likely to be pretty, I'm kinda cringing at the 
thought actually, but I think it's a necessary evil for the long term 
survivability of SELinux.  At least that's what I took away from Eric and 
Stephen's comments on this thread and I tend to agree.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
