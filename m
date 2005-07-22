Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MBu0gA004499
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 07:56:00 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MBoSKk011472
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:50:28 GMT
Subject: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <42E0310B.5070404@tresys.com>
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
	 <1121978850.15334.2.camel@celtics.boston.redhat.com>
	 <42E00E51.7050001@tresys.com>
	 <1121979985.15334.5.camel@celtics.boston.redhat.com>
	 <42E0105F.9030607@tresys.com>
	 <1121981131.15334.13.camel@celtics.boston.redhat.com>
	 <42E0310B.5070404@tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 07:53:26 -0400
Message-Id: <1122033206.19625.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 19:34 -0400, Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
> 
> >>I don't think thats such a great idea. Really alot of the meat of the 
> >>define_* functions has already moved to declare_symbol. The stuff that 
> >>is remaining is really parser specific such as handling where things can 
> >>be declared, handling multiple declarations, etc. It serves no purpose 
> >>to generalize this code as it really is about how to parse the policy 
> >>and not how to build up these structures.
> >>    
> >>
> >
> >How can I add te_avtab rules to policy at the moment, without
> >using checkpolicy?
> >  
> >
> All the te_avtab code has been removed from checkpolicy for the modules. 
> In fact, aside from checking type transition conflicts, checkpolicy 
> doesn't add any rules at all to the avtab, this is done at expand time.
> 
> further, avtab_insert, avtab_search, etc have always been in libsepol, 
> in avtab.c

static avtab_ptr_t
   avtab_insert_node(avtab_t *h, int hvalue, avtab_ptr_t prev,
avtab_key_t *key, avtab_datum_t *datum)


This is not the high level API that I am looking for.
A caller of this function would not know, or care, what prev is,
or what the format of a datum is, or what table this would go into.

------

Let me get to the point - we have iptables, which configures netfilter.
Then we have policy, which configures selinux. That's two configuration
systems, and having two configuration systems is not good - you have to 
go change both to get anything to work. Furthermore, iptables has
a superior configuration system from a user's point of view, because
it's easier to work with than writing policy in m4 macros.

So, what do we do about that? Dan is suggesting we might integrate
iptables with policy, and have it automatically generate some rules,
pertaining to interfaces, ports, etc... we can now query sepol
for the port label, and query sepol for the interface label. 

I'm not sure how this should be done, or whether this should be done,
but it merits further discussion. Should modules play a role into
this...is it a good idea...etc.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
