Subject: Re: [PATCH 2/2 take 2] userland support for new range_transition
	statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <44D9FA0B.2000902@trustedcs.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
	 <1155128956.942.2.camel@localhost.localdomain>
	 <44D9E3A4.6010109@tresys.com>  <44D9FA0B.2000902@trustedcs.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:13:45 -0400
Message-Id: <1155136425.942.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-09 at 10:06 -0500, Darrel Goeddel wrote:
> Joshua Brindle wrote:

<snip>

> > 
> > I think we are close on the semantic representation, punting on it now 
> > means 2 module format changes, I'd much prefer something that is usable 
> > now and won't need an explicit format change later, even if it isn't 
> > perfect.
> 
> Getting modules to work sure would be nice...  I originally wanted to get
> the format good enough to support this so we could get module support with
> only logic changes later on.  It was my understanding that we would not have
> to change the format for the mls requirements because we already have the
> symbol tables in there.  What do people think are the front runners for
> changes on the following 2 issues:
> 
> 1) how to represent the mls component in the range_trans_rule_t (as well
>    as the range and level in user_datum_t).
> 
>      I'm still leaning toward the string method.  I haven't had the
>      opportunity to try this, but my assumption is that it would work nicely.
>      This method would only need further work for checking requirements
>      (symbols only).  The linked struct method would require mappings as well.
>      I'm not sure how much that involves, but I assume it can't be that bad
>      because everything else does it.  I'd love to see prototypes of both if
>      anyone has a few extra cycles ;)
> 

I very much prefer the structures. Using the string requires all users
of libsepol to parse the string - currently we push all parsing to
checkpolicy and sepol includes a structured, semantic representation of
the data.

> 2) how to handle mls requirements.
> 
>      My preference at this point would be to require each component separately.
>      (e.g.  s1:c0,c4.c10,c30 would have:
>          Require {
>              sens s1;
>              cats c0, c4, c10, c30;
>          }
>      That should work just fine for the current format.  Making a requirement
>      on the whole range seems to require too many extra changes for little
>      benefit IMO.
> 

I agree.

> That said, punting would not be a huge problem if we can get updates into FC
> RHEL when the userspace work for modular support is complete.  This is desired
> either way, but I was concerned that a format change may may people more wary
> about the update, even though it would be completely backwards compatible.  The
> only real drawback to not getting the format tweaked now is that it will
> introduce more "if (version < MOD_POLICYDB...)" into the code.  Unfortunately,
> resources and time are limited as far as I can see...
> 

It would definitely be better to get the support in now, but I think
that we are in real danger of missing already.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
