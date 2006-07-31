MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/2] new and improved range_transition statements
Date: Mon, 31 Jul 2006 10:23:36 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AA32@exchange.columbia.tresys.com>
In-Reply-To: <1154355184.26550.58.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>,
        "SELinux List" <SELinux@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Mon, 2006-07-31 at 10:01 -0400, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
<snip?
> > 
> > I don't think any kernel format changes are planned so the kernel 
> > patch can go forward and we can branch off the userland for the 
> > changes you are talking about
> 
> The kernel change isn't useful without the format change 
> though. The current approach (which seems right) requires 
> both the kernel and module format change, correct?
> 

Eh? That doesn't mean they have to be merged at the exact same time,
kernel changes need to go in sooner to get backported to RHEL5 whereas
we have some time with userland changes.

> > (which ones are those btw?).
> > 
> 
> The ones that I can remember are:
> 
> - scoping fixes to allow permissions to be scoped. Ideally 
> this would add enough scoping information to allow the 
> relaxation of some of the ordering constraints.
> 

Right, I don't know who/when this will get done

> - fixing avrule_block to correctly represent what is possible 
> (removing arbitrary branches)
> 

That's a style change more than anything, no functional difference, very
low priority

> - better handling of type->flavor (if needed)
> 

??

> - whatever is needed to support incremental linking
> 

I'd like to get this in but that seems unlikely, it would be very nice
to speed up linking and memory usage (which is currently very high). I
don't think this will necessitate a format change but can't be sure.

> Do you have anything else?
>

That's all I know of, I'm not sure if any of these are going to go in
anytime soon unless other people have time/ability. The most important
thing is obviously permission scoping.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
