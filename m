Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JFd4fI029612
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:39:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JFcxUG026150
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:38:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3JFcuqH003521
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:38:56 -0400
Subject: Re: [PATCH - policyrep] add objpool to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176958040.19144.70.camel@code.and.org>
References: <1176947838.20763.4.camel@localhost.localdomain>
	 <1176958040.19144.70.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 11:35:25 -0400
Message-Id: <1176996925.13683.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 00:47 -0400, James Antill wrote:
> On Wed, 2007-04-18 at 21:57 -0400, Karl MacMillan wrote:
> > Add a reference counted object pool data structure to libsepol. Object
> > pools allow the storage of reference counted pools of objects. This
> > allows, for example, for many data structures to reference a single copy
> > of an object (e.g., a string).
> 
>  As a general observation this makes me want to cry for the silent death
> of a common C string ADT. But everyone has to reinvent their own so...
> 

To be fair - this is more general than strings. Of course, if C string
handling were reasonable then I might not have done this.

> > +int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s)
> 
>  If this is going to be used a lot having only a single "destroy"
> function that also silently unref's everything it's managing seems
> "bad".

I'm only intending to use this in the new policyrep where the lifetime
of the object pool will be tied to the lifetime of the policy tree. I
could add a destroy function that just destroys the pool though. I'd
likely need to add a way to iterate over all of the objects in the pool
to make this generally useful.

>  One obvious problem this causes is that if sepol_objpool_free() returns
> in error you don't know if it's from the iter create (everything fine,
> try again) or from the sepol_iter_free (everything free'd already ...
> you are totally screwed). Luckily sepol_iter_free can't ever do that.
> 

I know - that is irritating me. I can look at some internal iterators
headers for stack allocation, but I don't think it will be pretty. I can
also add error codes that indicate retry. Any other suggestions?

> > +int sepol_objpool_add(struct sepol_handle *h, struct sepol_objpool *s, void **obj)
> 
>  One minor point here is that while (char *) can change to (void *),
> (char **) cannot change to (void **), legally. see:
> 
> http://c-faq.com/ptrs/genericpp.html
> 

Well that sucks. I'll change the function prototype. I'll need to do the
same thing for the iterators.

> ...having a real string ADT would do the right thing (cough) ... ok I'll
> shutup now.
> 
> > +{
> > +	int ret;
> > +	hashtab_ptr_t cur;
> > +	unsigned int *refcount;
> > +
> > +	refcount = malloc(sizeof(unsigned int));
> > +	if (refcount == NULL)
> > +		return SEPOL_ENOMEM;
> > +	*refcount = 1;
> > +
> > +	ret = hashtab_insert2(s->objs, *obj, refcount, &cur);
> 
>  hashtab_insert2() seems like a hack based on the fact you can't use the
> result of hashtab_search().
> 

Yep.

> > +	if (ret == SEPOL_OK) {
> 
>  This doesn't copy "*obj" and so assumes s->obj_free is used to free the
> input.
> 

Yes.

> > +		return 0;
> > +	} else if (ret == SEPOL_EEXIST) {
> > +		free(refcount);
> > +		s->obj_free(*obj);
> > +		*obj = cur->key;
> > +		refcount = cur->datum;
> > +		*refcount += 1;
> > +		return 0;
> 
>  This also assumes s->obj_free is the correct thing to use for the
> input.
> 

Yes - that is intentional to avoid additional copying. Are you pointing
out a problem, or just suggesting the constraint needs documentation?

> > +	} else {
> > +		free(refcount);
> > +		return ret;
> > +	}
> > +}
> [...]
> > +int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *s, void *obj)
> > +{
> > +	int ret;
> > +	unsigned int *refcount;
> > +	
> > +	refcount = hashtab_search(s->objs, obj);
> > +	if (refcount == NULL)
> > +		return SEPOL_ENOENT;
> > +	
> > +	(*refcount)--;
> > +	if (*refcount == 0) {
> > +		ret = hashtab_remove(s->objs, obj,
> > +				     sepol_objpool_hashtab_free, s);
> > +		if (ret != SEPOL_OK)
> > +			return ret;
> > +	}
> 
>  The only thing hashtab_remove() returns, apart from _OK, is _ENOENT ...
> which would mean it could be unref'd or not ... if hashtab_remove()
> could return it in this codepath.

Not certain what you mean. Generally, these APIs aren't thread safe so I
assume that the remove will succeed here. The error checking is for
future changes in the hashtab implementation.

>  Also if you fixed the hashtab_search followed by hashtab_insert
> problem, then this codepath could also benefit in the same way (or maybe
> just have hashtab_remove2 ;).
> 

Sure. The hashtab API needs some cleanup and encapsulation, but I
decided to leave it for another day.

I'll submit a new patch with the needed changes.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
