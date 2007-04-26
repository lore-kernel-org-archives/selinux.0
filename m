Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3QGxAVU017985
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 12:59:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3QGx9SH022394
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 16:59:09 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3QGx8cZ005263
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 12:59:08 -0400
Subject: Re: [POLICYREP PATCH] Add objset to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1177544534.3999.22.camel@code.and.org>
References: <20070425215822.16055.18880.stgit@localhost.localdomain>
	 <1177544534.3999.22.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 12:59:08 -0400
Message-Id: <1177606748.3405.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 19:42 -0400, James Antill wrote:
> On Wed, 2007-04-25 at 17:58 -0400, Karl MacMillan wrote:
> > Add the objset data structure to libsepol. Object sets behave similarly to
> > Python sets.
> 
>  Umm, From: http://docs.python.org/lib/types-set.html
> 
>         A set object is an unordered collection of immutable values.
> 
> ...AIUI this will be an ordered collection of mutable values, though
> documented to maybe be unordered at some point?
> 

Hmm - I have been assuming that the values are immutable. If they change
then the ordering and uniqueness may be lost.

> > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > ---
> > 
> >  libsepol/include/sepol/objset.h |  169 +++++++++++++++++++++++++++++++++++++++
> >  libsepol/src/objset.c           |  154 ++++++++++++++++++++++++++++++++++++
> 
>  One thing I thought when reviewing Josh's mamoth patch is that it might
> be nice for review to post the unit tests seperately and mark them
> clearly. Just a thought.
> 

Ok.

> > diff --git a/libsepol/src/objset.c b/libsepol/src/objset.c
> > new file mode 100644
> > index 0000000..7b86e6b
> > --- /dev/null
> > +++ b/libsepol/src/objset.c
> > @@ -0,0 +1,154 @@
> > +struct sepol_objset
> > +{
> > +	struct sepol_list *objs;
> > +	sepol_objset_cmp_t cmp;
> > +	unsigned int len;
> > +	char compliment;
> > +};
> > +
> > +int sepol_objset_create(struct sepol_handle *h, struct sepol_objset **set,
> > +			sepol_objset_cmp_t cmp)
> > +{
> > +	int ret;
> > +
> > +	*set = calloc(1, sizeof(struct sepol_objset));
> > +	if (*set == NULL)
> > +		return SEPOL_ENOMEM;
> > +
> > +	(*set)->cmp = cmp;
> > +
> > +	ret = sepol_list_create(h, &(*set)->objs);
> > +	if (ret < 0) {
> > +		free(set);
> 
>  This should be free(*set).
> 

Good catch (as usual).

> > +		return ret;
> > +	}
> > +	
> > +	return SEPOL_OK;
> > +}
> > +
> > +int sepol_objset_add(struct sepol_handle *h, struct sepol_objset *s, void *obj)
> > +{
> > +	int ret, ret2, cmp;
> > +	struct sepol_iter *iter;
> > +	void *cur;
> > +
> > +	ret = sepol_iter_create(h, &iter);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sepol_list_begin(h, s->objs, iter);
> > +	sepol_foreach(h, ret, cur, iter) {
> > +		cmp = s->cmp(s, cur, obj);
> > +		if (cmp == 0) {
> > +			ret = SEPOL_EEXIST;
> > +			goto out;
> > +		} else if (cmp > 0) {
> > +			ret = sepol_list_insert(h, s->objs, iter, obj);
> > +			goto out;
> > +		}
> 
>  This implies an ordering, so you can't for Eg. add some elements and
> then change the cmp function.
> 

Yes - perhaps I should remove objset_set_cmp?

> > +	}
> > +	if (ret != SEPOL_ITERSTOP) {
> > +		ERR(h, "iteration ended abnormally");
> > +		goto out;
> > +	}
> > +	ret = sepol_list_append(h, s->objs, obj);
> > +out:
> > +	ret2 = sepol_iter_free(h, iter);
> > +	if (ret2 != SEPOL_OK) {
> > +		ERR(h, "error freeing iterator");
> > +		return ret2;
> > +	}
> 
>  I think it's much more likely that you want to know ret and not ret2
> here, if ret==SEPOL_EEXIST etc.
> 

Yeah - a previous version had just ignored errors from freeing the
iterator. Does that seem more reasonable? These errors on iterator
freeing are really irritating.

> > +	return ret;
> > +}
> > +
> > +int sepol_objset_del(struct sepol_handle *h, struct sepol_objset *s, void *obj)
> > +{
> > +	int ret, ret2, cmp;
> > +	struct sepol_iter *iter;
> > +	void *cur;
> > +
> > +	ret = sepol_iter_create(h, &iter);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sepol_list_begin(h, s->objs, iter);
> > +	sepol_foreach(h, ret, cur, iter) {
> > +		cmp = s->cmp(s, cur, obj);
> > +		if (cmp == 0) {
> > +			ret = sepol_list_del(h, s->objs, iter);
> > +			goto out;
> > +		}
> > +	}
> > +	if (ret == SEPOL_ITERSTOP)
> > +		ret = SEPOL_ENOENT;
> 
>  You aren't using the ordering here, why is that?
> 

No idea - fixed.

> > +		
> > +out:
> > +	ret2 = sepol_iter_free(h, iter);
> > +	if (ret2 != SEPOL_OK)
> > +		return ret2;
> 
>  Dito. Also no ERR() call?
> 
> > +	return ret;	
> > +}
> > +void sepol_objset_set_compliment(struct sepol_objset *s, char compliment)
> > +{
> > +	s->compliment = compliment;
> > +}
> > +
> > +char sepol_objset_get_compliement(struct sepol_objset *s)
> > +{
> > +	return s->compliment;
> > +}
> 
>  Spillink not soo god?;)
> 

Oops.

>  Also if you are going to add these, I think you want at least
> sepol_objset_contains_obj() which does the right thing.
> 

Added - and refactored a bit. At some future date subset, union, and
other set operations should be added.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
