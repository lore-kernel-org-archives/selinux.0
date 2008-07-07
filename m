Subject: Re: Adding local nodecon's through semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian Kuester <c.kuester@tarent.de>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <486CD88E.2000406@tarent.de>
References: <486CD88E.2000406@tarent.de>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 13:11:22 -0400
Message-Id: <1215450682.27975.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-03 at 15:47 +0200, Christian Kuester wrote:
> Hi List,
> 
> I had a small conversation with Stephen Smalley on the
> fedora-selinux-list about an easy way to add
> (local) nodecon's on a SELinux enabled system. As this is not
> implemented in semanage yet
> he gave me the advice to revive a discussion[1] on this list from 2006.
> It began because a patch against
> semanage was posted which enabled nodecon support. It seems that the
> patch never got commited
> because it didn't work as expected.
> 
> I writing because I would like to know if there's any chance to get that
> fully working. I played around
> with the patch and I could set labels to nodes and my SELinux seems to
> respect these settings.
> f.i
> # semanage node -t blacknetwork_node_t -a -p 0 -M 255.255.255.255
> 192.168.100.54
> $ ./socat -u TCP4-LISTEN:5555,bind=192.168.100.54,reuseaddr,fork -
> ...
> type=AVC msg=audit(1215085777.002:689775728): avc:  denied  { node_bind
> } for  pid=26627 comm="socat" saddr=192.168.100.54 src=5555
> scontext=user_u:user_r:exe_t:s0
> tcontext=system_u:object_r:blacknetwork_node_t:s0 tclass=tcp_socket
> 
> So, this seems to work. But I run into problems when I told semanage
> about the
> *actual* netmask of this node, which is 255.255.255.0. The tcontext
> string switched from
> "blacknetwork_node_t" to the generic "node_t".

Ok, this isn't actually a bug in the code at all.

The mask is not supposed to be the "netmask" of the host.  It is merely
the portion of the address that you wish to match against.  So you do
want it to be 255.255.255.255 if you want to match that exact address in
its entirety.

Specifying 255.255.255.0 means that you want to map the entire subnet to
that type.  But then you should only specify the prefix for the address,
i.e. 192.168.100.0, because the matching code does this:
	if (c->u.node.addr == (addr & c->u.node.mask))
		break;

It presumes that the specified address only has bits set within the
specified mask already.

Arguably semanage and checkpolicy should apply the mask to the address
as a precaution against misconfiguration by the user.  That's easy
enough to do.

Other tidbits on the semanage patch that I noticed:
- semanage node -l was broken, requires additional argument that has
been added to the list methods subsequently.  Also would be nice to
support locallist/-C option.
- semanage node -p option should take a string rather than an integer
and map it to the proper symbolic constant for ipv4/ipv6.

The ordering issue is a red herring at least for this example as the
sort is only applied to the local entries, and then they are merged to
the front of the policy-provided definitions.  Which may become an issue
down the road particularly if we move object contexts to modules. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
