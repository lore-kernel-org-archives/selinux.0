Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATExAd0018168
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 09:59:11 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kATEwSwt016307
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 14:58:29 GMT
Subject: Re: [redhat-lspp] Re: labeled ipsec policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: redhat-lspp@redhat.com, jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1164660680.17737.459.camel@faith.austin.ibm.com>
References: <1163802623.17737.398.camel@faith.austin.ibm.com>
	 <1164118202.12234.24.camel@sgc>
	 <1164660680.17737.459.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 09:59:31 -0500
Message-Id: <1164812372.25344.41.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-27 at 14:51 -0600, Joy Latten wrote:
> On Tue, 2006-11-21 at 09:10 -0500, Christopher J. PeBenito wrote:
> > On Fri, 2006-11-17 at 16:30 -0600, Joy Latten wrote:
> > > The following policy enables labeled ipsec to run
> > > in enforcing mode. I configure labeled ipsec in sysadm_r role. 
> > > Thus the rules I needed were specific to this role.
> > [cut]
> > > Included are some interfaces, which I used in an xxxx.if
> > > file. Then, there are a bunch of rules which I used in a xxxx.te file
> > > These rules were just an example of what I needed
> > > to get ping, nc, and ssh to work with labeled ipsec. For my
> > > policy, I used the types unlabeled_t, passwd_t, and ipsec_spd_t.
> > > When using passwd_t, ipsec_spd_t or any other domain, please be 
> > > mindful of mls constraints. 
> > [cut]
> > > interface(`ipsec_set_label',`
> > > 	gen_require(`
> > > 		type sysadm_t;
> > > 	')
> > > 	
> > > 	allow sysadm_t $1:association setcontext; 
> > > ')
> > 
> > Interfaces are written from the perspective of the subject (except for a
> > few very specific cases), so the parameter should be the subject, not
> > the object.  Neglecting that, is this for sysadm_t instead of
> > ipsec_mgmt_t?  I suspect that we want to add an interface to the domain
> > module that allows setcontext on the domain attribute.
> 
> Yes, this was for sysadm_t. I had taken a look at the current ipsec.if,
> ipsec.te, ipsec.fc and userdomain.te files as well and had wondered why
> we were not executing ipsec in the ipsec domain. It seem that the policy
> in those files was more for pluto and its utilities than ipsec-tools'
> utilities. 
> 
> So should racoon and setkey, the ipsec-tools' utiltites, be run in the
> ipsec domain? Should the sysadm_r role only be allowed to configure
> ipsec?

I don't know all the little details of racoon and setkey, but I think
racoon would run in ipsec_t and setkey in ipsec_mgmt_t.  However, if the
policy is going to be overhauled, then racoon_t and setkey_t seem more
applicable.  Then we can just add aliases for compatibility.

For the non-MLS strict policy, sysadm should be able to run setkey.  For
MLS, I'd have to defer that to someone who knows if there are any
relevant LSPP requirements for this.

> > > interface(`ipsec_label_sa_pol',`	
> > > 	allow $1 $2:association polmatch;
> > > ')
> > 
> > Generally refpolicy would leave this as a raw rule these types are in
> > separate modules, in which case the interface would be in $2's module
> > and have a specific type instead of $2.
> 
> Ok, I think I understand what you mean. From what I can tell of the code
> for the "polmatch" permission, $2 will most likely always be the type of
> the security context in the ipsec policy. However, this could be set to
> anything by the sysadm. Should I setup a default? For example, assume
> labeled ipsec policy to have a type of ipsec_spd_t? Thus a sysadm who
> decides to use labels in his ipsec policy, by default could use
> ipsec_spd_t for the type and specify whatever he/she wants for the mls
> level. Then he/she would use the interface to say which domains he wants
> to allow to "polmatch" to this. Does this sound reasonable? If so, I'll
> make the change and also make sure this is documented.

I'm not very sure how users will use the SPD labeling.  I suspect that
they will be labeled with probably the other side's domain type.  For
example, if httpd_t and mozilla_t are connected, the SPD would be
mozilla_t on the http machine and httpd_t on the mozilla machine.

> > > interface(`ipsec_labels_send_recv',`		
> > > 	allow $1 self:association { recvfrom sendto };
> > > ')
> > 
> > This would be raw rule in refpolicy instead of an interface.
> 
> I am not too sure I understand. We need a rule allowing flow->sid to use
> SA's sid to send. SA's type as well as flow's type will be that of the
> socket. Thus it could be any application or daemon. Do I need to add
> this rule to every daemon/application as a raw rule?  For example, in 
> netutils.te, add this for ping?

In general, the network access needs to be specified in each of the
modules, just like all the socket, node, netif, etc already specified in
the modules.  For the send side, it also brings back to the question of
if the sendto check is needed, since it is always checked against self.
But that assumes there isn't a use case for being able to receive but
not send on labeled connections.  I don't have any strong indication
either way, except that netlabel only has a recvfrom check.

For the receive side, there is going to have to be an interface, for
example

interface(`apache_recvfrom',`
	allow $1 apache_t:association recvfrom;
')

and then you might see

apache_recvfrom(mozilla_t)

If the sendto check stays, we could conceivably add this to the above
interface:

	allow $1 self:association sendto;

> > > interface(`ipsec_tools_utilities',`
> > > 	gen_require(`
> > > 		type isakmp_port_t;
> > > 		type inaddr_any_node_t;
> > > 	')
> > > 
> > > 	# allow setkey and racoon to create and use a key socket.
> > > 	allow $1 self:key_socket { create read write setopt };
> > > 
> > > 	# allow racoon to use ISAKMP port
> > > 	allow $1 isakmp_port_t:udp_socket name_bind;
> > > 
> > > 	# allow racoon to use avc_has_perm in within_range() 
> > > 	# to determine if proposed SA "polmatches" to policy
> > > 	allow $1 self:netlink_selinux_socket { bind create read };
> > > 
> > > 	# I think this is so racoon can listen on an admin port.
> > > 	allow $1 inaddr_any_node_t:tcp_socket node_bind;
> > > 
> > > 	# to create, remove read lock in /var/racoon/
> > > 	ipsec_manage_pid($1)
> > > 
> > > 	# in grabmyaddrs() socket(PF_ROUTE...)
> > > 	allow $1 self:netlink_route_socket { create_netlink_socket_perms };
> > > ')
> > 
> > Again, why is this needed, instead of ipsec_mgmt_t?
> > 
> > I suspect that the ipsec policy needs to be overhauled because I believe
> > it was oriented towards the KAME ipsec implementation (pluto, et al) and
> > was augmented to work with racoon afterwards.
> 
> I think you are correct. 
> 
> Right now racoon and setkey use ipsec_exec_t domain. Is this ok or
> should it be ipsec_mgmt_t? Also, should I go ahead and make the
> modifications for racoon and setkey to run in the ipsec domain (either
> ipsec_exec_t or ipsec_mgmt_t) instead of sysadm_t domain ? I wouldn't
> mind making an attempt at it with your help and as long as I knew you
> would review it for me.

See my above comments.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
