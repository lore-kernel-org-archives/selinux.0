Subject: RE: [PATCH 0/2] new and improved range_transition statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AA32@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AA32@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:55:42 -0400
Message-Id: <1154357742.26550.86.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 10:23 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 

<snip>

> > - scoping fixes to allow permissions to be scoped. Ideally 
> > this would add enough scoping information to allow the 
> > relaxation of some of the ordering constraints.
> > 
> 
> Right, I don't know who/when this will get done
> 

I've made some good progress cleaning up the scoping storage and
management on top of the symtab_datum_t patches. I'll likely be able to
send a version without a format change soon that will have all of the
needed infrastructure for when the format change happens.

> > - fixing avrule_block to correctly represent what is possible 
> > (removing arbitrary branches)
> > 
> 
> That's a style change more than anything, no functional difference, very
> low priority
> 

Yep

> > - better handling of type->flavor (if needed)
> > 
> 
> ??
> 

I remembered some discussion about how this would be done when it was
added - doesn't look like anything needs to change so never mind.

> > - whatever is needed to support incremental linking
> > 
> 
> I'd like to get this in but that seems unlikely, it would be very nice
> to speed up linking and memory usage (which is currently very high). I
> don't think this will necessitate a format change but can't be sure.
> 

Right - I'm betting that there will be something needed.

> > Do you have anything else?
> >
> 
> That's all I know of, I'm not sure if any of these are going to go in
> anytime soon unless other people have time/ability. The most important
> thing is obviously permission scoping.
> 

Like I said I'm working on the scoping, but it is a low priority task
for me.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
