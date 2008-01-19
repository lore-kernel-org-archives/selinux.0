From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
Date: Fri, 18 Jan 2008 22:44:25 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
References: <20080117172246.341834342@hp.com> <200801180911.05879.paul.moore@hp.com> <1200667130.4595.45.camel@gorn>
In-Reply-To: <1200667130.4595.45.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801182244.26071.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 18 January 2008 9:38:50 am Christopher J. PeBenito wrote:
> On Fri, 2008-01-18 at 09:11 -0500, Paul Moore wrote:
> > On Friday 18 January 2008 8:32:07 am Christopher J. PeBenito wrote:
> > > I strongly agree with Stephen's suggestion.
> >
> > So, does the "strongly agree" position mean you won't accept the patch
> > adding both "flow" and "forward" permissions to the packet class?
>
> No, if I meant that, I would have said that.

Okay, just wanted to clarify.

I suppose I'm a little hyper sensitive to problems right now because the merge 
window for 2.6.25 is very close and I don't want there to be any known issues 
with the labeled networking code when the window opens.

> >   I'll reiterate my
> > belief that using "flow" instead of "forward" for the new permission
> > checks is a mistake which will cause more confusion in the long run than
> > the addition of two unused permissions.  However, you hold the key to the
> > policy and if changing the permissions to use "flow" is the only way for
> > us to enable the new network access controls then I have little choice.
>
> I'm not completely unreasonable :) Also that would be an abuse of power.

Yes, you're right - you are a very reasonable guy, despite all the crap Josh 
says about you when you're not around :)  Re-reading the text above I went a 
little crazy there, sorry about that.

> > > Do we have a strategy for eventually reclaiming these permissions if we
> > > don't reuse them right now?
> >
> > I'm not aware of one, but it is always possible that future work might
> > find a use for the packet "flow" permissions.  It's also highly doubtful
> > from where I sit now that we'll come even remotely close to hitting the
> > 32 permission limit in the packet class.
>
> I just don't like these rogue permissions filtering up to upstream.  One
> thing that I'm also looking ahead to is that explicit require blocks
> will be ignored by policyrep (requirements will be implicit).  So the
> hack that I had to add that requires all of the kernel object classes
> will also be going away, and only classes/perms actually being used will
> be required.

This sounds like a good idea, and I definitely owe you one, so if there is 
anything I can do to help (I see that Eric offered to) let me know.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
