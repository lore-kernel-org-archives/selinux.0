Subject: Re: [PATCH] selinux: convert type_val_to_struct to flex_array
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, rientjes@google.com,
        dave@linux.vnet.ibm.com
In-Reply-To: <1280949246.21957.213.camel@moss-pluto.epoch.ncsc.mil>
References: <20100803194452.22236.49318.stgit@paris.rdu.redhat.com>
	 <1280949246.21957.213.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 16:23:59 -0400
Message-ID: <1280953439.23348.25.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adding Dave and David, the two who seem to have ever touched
flex_arrays, to see if they have opinions.

On Wed, 2010-08-04 at 15:14 -0400, Stephen Smalley wrote:
> On Tue, 2010-08-03 at 15:44 -0400, Eric Paris wrote:
> > In rawhide type_val_to_struct will allocate 26848 bytes, an order 3
> > allocations.  While this hasn't been seen to fail it isn't outside the
> > realm of possibiliy on systems with severe memory fragmentation.  Convert
> > to flex_array so no allocation will ever be bigger than PAGE_SIZE.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/ss/policydb.c |   28 +++++++++++++++++++++-------
> >  security/selinux/ss/policydb.h |    2 +-
> >  security/selinux/ss/services.c |   17 ++++++++++++-----
> >  3 files changed, 34 insertions(+), 13 deletions(-)
> > 
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 4ca9b5c..b7ef93e 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -297,7 +297,11 @@ static int type_index(void *key, void *datum, void *datap)
> >  		    || typdatum->bounds > p->p_types.nprim)
> >  			return -EINVAL;
> >  		p->p_type_val_to_name[typdatum->value - 1] = key;
> > -		p->type_val_to_struct[typdatum->value - 1] = typdatum;
> > +		/* this flex array was all preallocated, this cannot fail */
> > +		if (flex_array_put_ptr(p->type_val_to_struct_array,
> > +				       typdatum->value - 1, typdatum,
> > +				       GFP_KERNEL | __GFP_ZERO))
> 
> Curious:  do we need to pass any gfp flag values if we are
> preallocating?  Can the flags here just be 0?

I wouldn't think we need to to pass anything since if we do any
allocations here something is truly screwed up.  We seem to be the first
users of the interface, so maybe others had a thought of the best way to
handle this?  What should to gfp flags be if we preallocated the whole
array?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
