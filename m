From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: Time to remove compat_net?
Date: Tue, 4 Sep 2007 07:38:53 -0400
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
References: <200708301607.42110.paul.moore@hp.com> <1188831746.2876.3.camel@localhost.localdomain> <46DCA8CB.4080402@manicmethod.com>
In-Reply-To: <46DCA8CB.4080402@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709040738.53733.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 03 September 2007 8:37:31 pm Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-08-30 at 16:33 -0400, Paul Moore wrote:
> >> On Thursday, August 30 2007 4:12:24 pm Stephen Smalley wrote:
> >>> On Thu, 2007-08-30 at 16:07 -0400, Paul Moore wrote:
> >>>> Does anyone have any objections to placing the compat_net code on the
> >>>> kernel's "feature removal schedule" (I'd go for removal in 2/2008, six
> >>>> months from now)?  SECMARK can do everything that the older compat_net
> >>>> controls can do, and it does it with less overhead and a cleaner
> >>>> implementation.
> >>>
> >>> I'd be happy to see it go (conditional checks considered harmful), but
> >>> a good starting point would be to get secmark turned on in Fedora (it
> >>> was still off last I looked) and verify that nothing breaks.
> >>>
> >>> We also don't have any tools capable of managing secmark today; with
> >>> the legacy controls, we could labels ports and netifs via semanage. 
> >>> Only secmark userland integration to date has been the basic iptables
> >>> command line support.
> >>
> >> Okay RedHat guys ... are there any plans to migrate semanage over to
> >> using the SECMARK controls?
> >
> > I have argued in the past that making semanage handle secmark is the
> > wrong approach. Basically - the whole point of using secmark is that you
> > get the full power of iptables. If we force updates through semanage
> > then you either a) recreate all of iptables in semanage or b) seriously
> > cripple the mechanism through a restricted interface.
>
> I completely agree with this.

I agree that does sound reasonable, but isn't there a concern about 
compatibility with semanage?  Should we provide minimal SECMARK functionality 
within semanage just so we can provide compatibility?  Or is the real blocker 
what you talked about below ...

> >>   If not, what do you need (besides patches to semanage) to
> >> make the transition?
> >
> > What more do you mean other than setting compat_net to 0?
>
> In the past we talked about solving some of the usability problems with
> secmark, namely that its difficult to manage the secmark rules
> separately from the normal rules without causing issues (like when
> running /etc/init.d/iptables stop makes all traffic turn unlabeled and
> stop working). One potential solution was to make a new table for
> secmark that would be managed differently, we never came to a consensus
> here though.

Is this the only reason why SECMARK is not garnering much use in 
distributions?  I suspect a new table would be acceptable upstream and I 
don't ever remember hearing much objection to it here; from what I can recall 
the only concern was if it was necessary.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
