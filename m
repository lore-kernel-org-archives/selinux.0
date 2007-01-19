Subject: Re: 2.6.19.2 Oops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Antoine Martin <antoine@nagafix.co.uk>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
In-Reply-To: <200701191048.30219.paul.moore@hp.com>
References: <45B09CFA.5070805@nagafix.co.uk>
	 <45B0C712.3090802@nagafix.co.uk> <45B0E782.9070102@nagafix.co.uk>
	 <200701191048.30219.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 10:49:41 -0500
Message-Id: <1169221781.22731.560.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-19 at 10:48 -0500, Paul Moore wrote:
> On Friday, January 19 2007 10:45 am, Antoine Martin wrote:
> > Disabling Netlabel did the trick.
> > Shouldn't that be sent to stable for 2.6.19.3? (it is a oops after all)
> 
> Yep, I'm working on a patch as I type this ...

Right, and to clarify - the patch is to fix the bug, not to disable
NetLabel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
