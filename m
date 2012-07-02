Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q62Kivnm029761
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2012 16:44:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q62Kiurn012771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2012 16:44:56 -0400
Message-ID: <1341261893.28275.31.camel@localhost>
Subject: Re: [RFC PATCH v1 2/2] selinux: redefine a port definition to
 include the IP address
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
Date: Mon, 02 Jul 2012 16:44:53 -0400
In-Reply-To: <19165183.GrmqLaULYm@sifl>
References: <20120629202934.9075.1212.stgit@sifl>
	 <20120629202941.9075.7670.stgit@sifl> <1341254592.28275.11.camel@localhost>
	 <19165183.GrmqLaULYm@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-02 at 16:20 -0400, Paul Moore wrote:
> On Monday, July 02, 2012 02:43:12 PM Eric Paris wrote:
> > On Fri, 2012-06-29 at 16:29 -0400, Paul Moore wrote:

> or did you just think I was that 
> stupid ;)

I can't believe you figured that out!

> For the sake of quickness I copied the address related caching portions from 
> the netnode.c cache.  If we're going to include the netmask in the port cache 
> we should include it in the node cache.

Fair enough.  Maybe it would be a reasonable set of follow on patches.
Should be put in some statistic counters like we do on the hash tables
to see if what we have today works 'well' in the real world?  Not sure
what they'd look like...  Quite possibly any optimization would be
pointless...

> > > @@ -2147,7 +2147,19 @@ static int ocontext_read(struct policydb *p, struct
> > > policydb_compat_info *info,> 
> > >  				c->u.port.protocol = le32_to_cpu(buf[0]);
> > >  				c->u.port.low_port = le32_to_cpu(buf[1]);
> > >  				c->u.port.high_port = le32_to_cpu(buf[2]);
> > > 
> > > -				rc = context_read_and_validate(&c->context[0], p, fp);
> > > +				if (p->policyvers>=POLICYDB_VERSION_PORTADDR) {
> > > +					rc = next_entry(buf, fp, sizeof(u32));
> > > +					if (rc)
> > > +						goto out;
> > > +					c->u.port.node_present = 1;
> > > +					/* we only associate a node type with
> > > +					 * the port and not the full context
> > > +					 * so that we can define ports in
> > > +					 * policy modules */
> > > +					c->u.port.node_type=le32_to_cpu(buf[0]);
> > > +				}
> > > +				rc = context_read_and_validate(&c->context[0],
> > > +							       p, fp);
> > 
> > You are always reading a node type with the new policy version.  Fine.
> 
> Would you prefer it the other way?  I really don't care either way.

Not really, just thinking through things from top to bottom.  Trying to
consider everything from how the admin will want to use it, how the
policy writer will specify it, how the toolchain will handle it, etc...

> Having learned about all the restrictions due to policy modules I personally 
> am starting to lean back towards using the IP address directly, but I still 
> don't care too much about it either way.  

No, no 1000 times no.  Please don't duplicate things.  We define IP
addresses using semanage and nodes.  No matter what I believe the
solution is unaccountable if we have to define ip addr/mask in both
semanage for some stuff and in policy proper for other stuff...

> The main goal is to get an address 
> included in the port definition, how you define the address (direct or via a 
> node type) is akin to arguing about the color of the bike shed in my mind.

I led you very astray in our offline talk.  We already use a full
context in portcon records so we already can't use them in modules.  So
your original idea of using a full context instead of just a type is the
right thing to do.  Mapping IP<->context is the job of semanage (so
admins instead of policy writers can do it).  Please do not move that
job onto the policy author.  The policy author can't possibly know what
IP addresses/ranged are important.

You are on the right track for the placeholder value of SECINITSID_NODE.
Policy has the line:

sid node system_u:object_r:node_t:s0

So there would have to be some way to use that value as the placeholder
when writing out policy in userspace.  The kernel can remain blissfully
ignorant...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
