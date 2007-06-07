Subject: Re: [PATCH 3/5] libselinux: add string<->value functions that use
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <46674C16.40005@tycho.nsa.gov>
References: <1181157090.6578.38.camel@sgc.columbia.tresys.com>
	 <46674C16.40005@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 12:19:33 +0000
Message-Id: <1181218773.6578.70.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 20:06 -0400, Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
> > Add new value->name, name->value functions that use object class discovery.
> > 
> > Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
> > 
> > ---
> >  libselinux/src/stringrep.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
[...]
> > +access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
> > +{
> > +	struct discover_class_node *node;
> > +
> > +	node = get_class_cache_entry_value(tclass);
> > +	if (node != NULL) {
> > +		size_t i;
> > +		for (i=0; i<MAXVECTORS && node->perms[i] != NULL; i++)
> > +			if (strcmp(node->perms[i],s) == 0)
> > +				return (1<<i);
> 
> I think if you fall off the end of this loop, you may want to flush the
> cache and try once more.  This would handle the case where the policy
> was reloaded with new permission bits added to the class.  This is a
> pretty obscure corner case so maybe it's not worth the effort.  But see
> comments about netlink below.

comments below

> > +	}
> > +
> > +	return 0;
> 
> Set errno to EINVAL, as mentioned earlier.

No, you can't do that, the value of EINVAL (22 on my machine) could
correspond to 3 real permissions.  access_vector_t is unsigned, so it
can't be negative.  Since access_vector_t is a vector, it makes sense
for it to be 0.

> > +}
> > +
> > +const char *security_class_to_string(security_class_t tclass)
> > +{
> > +	struct discover_class_node *node;
> > +
> > +	node = get_class_cache_entry_value(tclass);
> > +	if (node == NULL)
> > +		return NULL;
> > +	else
> > +		return node->name;
> > +}
> > +
> > +const char *security_av_perm_to_string(security_class_t tclass,
> > +				       access_vector_t av)
> > +{
> > +	struct discover_class_node *node;
> > +	size_t i;
> > +
> > +	node = get_class_cache_entry_value(tclass);
> > +	if (av && node)
> > +		for (i = 0; i<MAXVECTORS; i++)
> > +			if ((1<<i) & av)
> > +				return node->perms[i];
> 
> Likewise here, if you hit a NULL node->perms[i] you may want to flush
> the cache and try again.
> 
> Do we want to flush the cache when a netlink reload notification comes
> in?  I don't necessarily think that the kernel should allow a policy
> reload that moves or deletes classes and permissions.  But in theory
> (disregarding race conditions), this patchset along with use of the
> mapping support could allow a userspace object manager to keep working
> across a policy reload that does move things around and/or delete unused
> values.

This particular implementation is the simple version that assumes stable
classes and perms, which Steve asked me to send up.  If we assume they
can change, then we have to add locking since the netlink thread
flushing the cache while we're trying to build it would be bad :)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
