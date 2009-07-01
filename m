MIME-Version: 1.0
In-Reply-To: <1246455879.13464.144.camel@moss-pluto.epoch.ncsc.mil>
References: <200906301734.31986.paul.moore@hp.com>
	 <1246455879.13464.144.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 1 Jul 2009 11:01:06 -0400
Message-ID: <7e0fb38c0907010801n7516d4e3ib5f11716a0bf6293@mail.gmail.com>
Subject: Re: The problem with TUN/TAP devices
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 1, 2009 at 9:44 AM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
> On Tue, 2009-06-30 at 17:34 -0400, Paul Moore wrote:

> Wouldn't it be a bug if they didn't match?  So I'd add the sk_alloc()
> hook, set the label/SID for the sock there, and remove the setting of
> the sock label/SID from post_create.  And then just add a BUG_ON to
> post_create to assert that the inode SID should be the same as the sock
> SID and if they don't match something has gone wrong.
>

I've got a system all set up to test anything you want/have/need....
Maybe this afternoon I'll even give this suggestion a try just to see
what happens, the networking hooks are ummmm, special?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
