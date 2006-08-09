MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2 take 2] userland support for new range_transitionstatements
Date: Wed, 9 Aug 2006 11:39:44 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AED9@exchange.columbia.tresys.com>
In-Reply-To: <1155136425.942.35.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Wed, 2006-08-09 at 10:06 -0500, Darrel Goeddel wrote:
> > Joshua Brindle wrote:
> 
> <snip>
> 
> 
> I very much prefer the structures. Using the string requires 
> all users of libsepol to parse the string - currently we push 
> all parsing to checkpolicy and sepol includes a structured, 
> semantic representation of the data.
> 

At this point I prefer the structures to but I disagree with your
justification, policydb is owned by libsepol, no user of libsepol should
be parsing the string (which would only exist in the linked copy, other
out-of-tree users like apol only operate on the expanded copy).


> > 2) how to handle mls requirements.
> > 
> >      My preference at this point would be to require each 
> component separately.
> >      (e.g.  s1:c0,c4.c10,c30 would have:
> >          Require {
> >              sens s1;
> >              cats c0, c4, c10, c30;
> >          }
> >      That should work just fine for the current format.  
> Making a requirement
> >      on the whole range seems to require too many extra 
> changes for little
> >      benefit IMO.
> > 
> 
> I agree.
> 

That's fine, and easier to accomplish since there are already sens and
cats tables in every avrule_decl block, the logic to require them can be
easily copied from other symbols.

> > That said, punting would not be a huge problem if we can 
> get updates 
> > into FC RHEL when the userspace work for modular support is 
> complete.  
> > This is desired either way, but I was concerned that a 
> format change 
> > may may people more wary about the update, even though it would be 
> > completely backwards compatible.  The only real drawback to not 
> > getting the format tweaked now is that it will introduce more "if 
> > (version < MOD_POLICYDB...)" into the code.  Unfortunately, 
> resources and time are limited as far as I can see...
> > 
> 
> It would definitely be better to get the support in now, but 
> I think that we are in real danger of missing already.
> 

Refpolicy needs this support badly, right now all range_transitions are
moved into base breaking encapsulation since modules don't support them.



I vote for doing the structured semantic representation, getting
everything merged so that it makes it in for sure and then working on
the module changes (which should be very small but something unexpected
might pop out). That way the new range_trans are available and hopefully
the module support gets in after that.

One other thing, since there is now a unit test suite in libsepol I'd
like to see some unit tests for the new structures, I know there is a
time crunch right now but I think they should be written as soon as they
can be.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
