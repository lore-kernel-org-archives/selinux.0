Subject: Re: Real simple cache that removes most of the lookups in mcstrans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1147884995.3469.154.camel@code.and.org>
References: <446AFED3.9010800@redhat.com>
	 <1147879972.3469.139.camel@code.and.org>  <446B4D13.8080605@redhat.com>
	 <1147884995.3469.154.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:06:14 -0400
Message-Id: <1147885574.30789.358.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 12:56 -0400, James Antill wrote:
> On Wed, 2006-05-17 at 12:19 -0400, Daniel J Walsh wrote:
> 
> > Only reason strdup fails is ENOMEM.  With ENOMEM you are almost 
> > garanteed you are going to crash anyways.  gstrdup does a exit when it 
> > runs out of memory.
> > So we can messy up the code with a lot of checks that end up doing 
> > little.  Your choice.
> 
>  Well, it doesn't currently fail that way ... and it's relying on a side
> effect that sometimes happens.
>  Also the grep's I can see show the malloc/realloc/strdup failures being
> handled, so without bugs in the application layer ENOMEM doesn't
> currently mean a crash.
> 
>  I'd be happy to do the diffs to add an internal
> xstrdup()/xmalloc()/etc. which calls abort(), if that's the route we
> want to go. As you say, this would significantly reduce the failure
> paths ... although it might get libselinux banned from some
> applications.
>  I'll also volunteer to do an audit and add the failure paths, if we
> want to handle ENOMEM.

libselinux functions shouldn't crash or abort on ENOMEM, so I'd want
them handled properly prior to merging this patch.  A more general cache
would be nice too ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
