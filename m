Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JGF6Dc032516
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:15:06 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JGF4rk022230
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 16:15:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3JGF3fE026905
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:15:03 -0400
Subject: Re: [PATCH - policyrep] add objpool to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176998244.19144.87.camel@code.and.org>
References: <1176947838.20763.4.camel@localhost.localdomain>
	 <1176958040.19144.70.camel@code.and.org>
	 <1176996925.13683.29.camel@localhost.localdomain>
	 <1176998244.19144.87.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 12:11:26 -0400
Message-Id: <1176999086.13683.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 11:57 -0400, James Antill wrote:
> On Thu, 2007-04-19 at 11:35 -0400, Karl MacMillan wrote:
> > On Thu, 2007-04-19 at 00:47 -0400, James Antill wrote:
> > > On Wed, 2007-04-18 at 21:57 -0400, Karl MacMillan wrote:
> > > > +int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s)
> > > 
> > >  If this is going to be used a lot having only a single "destroy"
> > > function that also silently unref's everything it's managing seems
> > > "bad".
> > 
> > I'm only intending to use this in the new policyrep where the lifetime
> > of the object pool will be tied to the lifetime of the policy tree. I
> > could add a destroy function that just destroys the pool though. I'd
> > likely need to add a way to iterate over all of the objects in the pool
> > to make this generally useful.
> 
>  So, sepol_objpool_del() will never be called?

It is - as you make changes to the policy tree strings can be removed as
objects are. Actually, as you delete the policy tree the object pool
should empty. It is probably an error if there is anything left in the
pool when the root node in the tree is destroyed. Hmm - maybe I should
change this to add / remove and let the caller allocated and deallocate
all of the objects (see below for why that is inconvenient though).

>  If so it seems better to
> have it work like an APR memory pool or obstack etc. where you allocate
> a bunch of small objects but only remove the entire thing once.
> 

No - that is not quite the intended use.

> > > > +	if (ret == SEPOL_OK) {
> > > 
> > >  This doesn't copy "*obj" and so assumes s->obj_free is used to free the
> > > input.
> > 
> > Yes.
> > 
> > > > +		return 0;
> > > > +	} else if (ret == SEPOL_EEXIST) {
> > > > +		free(refcount);
> > > > +		s->obj_free(*obj);
> > > > +		*obj = cur->key;
> > > > +		refcount = cur->datum;
> > > > +		*refcount += 1;
> > > > +		return 0;
> > > 
> > >  This also assumes s->obj_free is the correct thing to use for the
> > > input.
> > 
> > Yes - that is intentional to avoid additional copying. Are you pointing
> > out a problem, or just suggesting the constraint needs documentation?
> 
>  I guess I just wonder why have the s->obj_free member at all, esp.
> given the examples used with strdup() ... I kind of assumed you expected
> input from strdup(), given the examples, and so was confused about the
> non-useage of free().

Ahh - but the objects can be arbitrary, so they might be structs that
need something more than free.

>  It also just seems wrong to have the member free function used for
> input ... but if you have a use case feel free to ignore me :).
> 

Well, the model I was thinking was that the caller was giving ownership
of the object to the pool. The advantage is that the caller simply calls
add and doesn't have to check return codes to see if their copy of the
object should be freed. Otherwise the caller would conditionally free
the object depending on whether another copy already existed. Object
deletion would have the same problem.

> > > > +	} else {
> > > > +		free(refcount);
> > > > +		return ret;
> > > > +	}
> > > > +}
> > > [...]
> > > > +int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *s, void *obj)
> > > > +{
> > > > +	int ret;
> > > > +	unsigned int *refcount;
> > > > +	
> > > > +	refcount = hashtab_search(s->objs, obj);
> > > > +	if (refcount == NULL)
> > > > +		return SEPOL_ENOENT;
> > > > +	
> > > > +	(*refcount)--;
> > > > +	if (*refcount == 0) {
> > > > +		ret = hashtab_remove(s->objs, obj,
> > > > +				     sepol_objpool_hashtab_free, s);
> > > > +		if (ret != SEPOL_OK)
> > > > +			return ret;
> > > > +	}
> > > 
> > >  The only thing hashtab_remove() returns, apart from _OK, is _ENOENT ...
> > > which would mean it could be unref'd or not ... if hashtab_remove()
> > > could return it in this codepath.
> > 
> > Not certain what you mean. Generally, these APIs aren't thread safe so I
> > assume that the remove will succeed here. The error checking is for
> > future changes in the hashtab implementation.
> 
>  Sorry, bad English on my part. My point was that I don't see how
> hashtab_remove() could ever return in error here (as you've already made
> sure it is there)

It shouldn't.

>  ... and even if it ever did return in error at some
> future point, you are leaking a reference count (*refcount == 0, but
> there is still one reference in the hashtab).
> 

If it did return an error you don't know whether you are leaking or not
- likely things are just screwed, which is why I punt and return the
error for the caller to figure out how to handle :) Eventually the
hashtab API can be fixed so that this is not an issue.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
