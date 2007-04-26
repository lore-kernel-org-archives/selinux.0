Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3QIVvMo024756
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 14:31:57 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3QIVuSH013715
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 18:31:56 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3QIVusK007925
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 14:31:56 -0400
Subject: Re: [POLICYREP PATCH] Add objset to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1177608900.3999.34.camel@code.and.org>
References: <20070426165756.7021.40274.stgit@localhost.localdomain>
	 <1177608900.3999.34.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 14:31:54 -0400
Message-Id: <1177612314.3405.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 13:35 -0400, James Antill wrote:
> On Thu, 2007-04-26 at 12:57 -0400, Karl MacMillan wrote:
> > Add the objset data structure to libsepol. Object sets behave similarly to
> > Python sets.
> [...]
> > +struct sepol_objset
> > +{
> > +       struct sepol_list *objs;
> > +       sepol_objset_cmp_t cmp;
> > +       unsigned int len;
> > +       char compliment;
> > +};
> > 
>  What is len for?

It's vestigial - removed.

> > 
> > +int sepol_objset_contains(struct sepol_handle *h, struct sepol_objset *s, void *obj)
> > +{
> > +	int ret;
> > +	struct sepol_iter *iter;
> > +
> > +	ret = sepol_objset_seek(h, s, &iter, obj);
> > +	if (ret == SEPOL_EEXIST) {
> > +		sepol_iter_free(h, iter);
> > +		return 1;
> > +	} else if (ret == SEPOL_ENOENT) {
> > +		sepol_iter_free(h, iter);
> > +		return 0;
> > +	} else if (ret == SEPOL_ITERSTOP) {
> > +		return 0;
> > +	}
> 
>  This should be:
> 
>        int ret;
>        struct sepol_iter *iter;
>        int found = !s->compliment;
> 
>        ret = sepol_objset_seek(h, s, &iter, obj);
>        if (ret == SEPOL_EEXIST) {
>                sepol_iter_free(h, iter);
>                return found;
>        } else if (ret == SEPOL_ENOENT) {
>                sepol_iter_free(h, iter);
>                return !found;
>        } else if (ret == SEPOL_ITERSTOP) {
>                return !found;
>        }
> 
> ...or something similar, no?

I was undecided - essentially, compliment is only useful when the set
represents a subset of a larger set. Unfortunately, we don't know what
is in that larger set. So, given the set { "bar", "baz" } that is
complimented, testing for "foo" is unknowable.

When I use the sets in the policy rep I do the only thing possible - the
caller interprets what compliment means. To do that I need to know what
is literally in the set. So unless someone objects I will leave as is
with a note in the docs.

>  Also C has switch, unlike python ;).
> 

I normally hate switches, but it definitely made the code easier to read
in this case.

> > +
> > +	return ret;
> > +}
> 
>  Having the iter errors bubble up the API like this sucks and will make
> eq/subset/etc. much more complicated :(.
> 

I know - suggestions about how to avoid this though?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
