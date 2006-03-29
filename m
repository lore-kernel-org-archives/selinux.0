Subject: Re: ANN: Fedora Core 5 SELinux FAQ
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Stephen J. Smoogen" <smooge@gmail.com>
Cc: Chad Sellers <csellers@tresys.com>, fedora-selinux-list@redhat.com,
        SELinux@tycho.nsa.gov, selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <80d7e4090603290919j7fbe917ctb8e0fbd1e83a02d8@mail.gmail.com>
References: <4429E6B6.7040108@tresys.com>
	 <80d7e4090603290919j7fbe917ctb8e0fbd1e83a02d8@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 12:53:34 -0500
Message-Id: <1143654814.24555.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-29 at 10:19 -0700, Stephen J. Smoogen wrote:
> I am trying to go over the questions in here one by one.. as I need to
> work out what could be done for some systems where I work. I have one
> question so far:
> 
> Q: What about the strict policy? Does it even work?
>    [From the list at release time.. I thought strict policy was broken
> for Core.]

Yes, -strict in FC5 is broken at the moment, although there is ongoing
work to resolve the issues needed to get it working.  The breakage isn't
really anything to do with -strict per se, just fully modularized policy
(breaking down even the base policy into lots of individual modules).

> Q: What is the Reference Policy?
> 
>   [I found I am really confused by this answer.. if my muddled brain
> is getting this correct.. the Reference Policy is the base policy that
> the Fedora Core 5 targeted, strict, mls policies are based off of the
> Reference Policy.. or are there 2 sets of policies shipped with Fedora
> Core 5 some of which are based off of the old set and the others by
> the new set.]

Reference policy is the new source policy tree from which all policy
types (-strict, -targeted, -mls) are being built.  Previously, they were
being built from the NSA example policy source tree.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
