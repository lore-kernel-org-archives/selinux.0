Subject: Re: /selinux/create + X windows = performance limiter
From: Eric Paris <eparis@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        ajax@redhat.com
In-Reply-To: <49A5C5A9.9070307@tycho.nsa.gov>
References: <1235595005.25352.29.camel@localhost.localdomain>
	 <1235596469.8900.4.camel@localhost.localdomain>
	 <49A5C5A9.9070307@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 17:29:56 -0500
Message-Id: <1235600996.25352.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-25 at 17:26 -0500, Eamon Walsh wrote:
> Stephen Smalley wrote:
> > On Wed, 2009-02-25 at 15:50 -0500, Eric Paris wrote:
> >   
> >> So the X people here at Red Hat complained the other day that they have
> >> to do an open, write, read, close very very often on /selinux/create.
> >> They'd like to cut the number of syscalls down.  Even if the open and
> >> close are fast, they are still syscalls that still take time and still
> >> provide maximum limits on the operations per second they can do.  (I
> >> think ajax said he was estimating it at 10000/sec, but I don't remember
> >> the math or even if it was reasonable)
> >>     
> > Wouldn't it be simpler and more efficient to just start caching the
> > results of security_compute_create in the AVC so that
> > avc_compute_create() will get most answers from the cache, just like
> > avc_has_perm()?
> >   
> 
> Yes, this is the way to go.  All of the compute_create calls made from
> the SELinux extension are done through the avc_compute_create() helper
> function in libselinux and a cache layer could be added to that function
> to avoid the call to security_compute_create_raw() which calls the
> filesystem, similar to how avc_has_perm_noaudit() works.  This has been
> proposed in the past just not implemented yet.

dang userspace. now I understand what sds meant.  Thanks, I'll take a
look at it.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
