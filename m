Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kALE91sA001902
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 09:09:01 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kALE8KKX004436
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 14:08:20 GMT
Subject: Re: labeled ipsec policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <1163802623.17737.398.camel@faith.austin.ibm.com>
References: <1163802623.17737.398.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 09:10:02 -0500
Message-Id: <1164118202.12234.24.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-17 at 16:30 -0600, Joy Latten wrote:
> The following policy enables labeled ipsec to run
> in enforcing mode. I configure labeled ipsec in sysadm_r role. 
> Thus the rules I needed were specific to this role.
[cut]
> Included are some interfaces, which I used in an xxxx.if
> file. Then, there are a bunch of rules which I used in a xxxx.te file
> These rules were just an example of what I needed
> to get ping, nc, and ssh to work with labeled ipsec. For my
> policy, I used the types unlabeled_t, passwd_t, and ipsec_spd_t.
> When using passwd_t, ipsec_spd_t or any other domain, please be 
> mindful of mls constraints. 
[cut]

> interface(`ipsec_set_label',`
> 	gen_require(`
> 		type sysadm_t;
> 	')
> 	
> 	allow sysadm_t $1:association setcontext; 
> ')

Interfaces are written from the perspective of the subject (except for a
few very specific cases), so the parameter should be the subject, not
the object.  Neglecting that, is this for sysadm_t instead of
ipsec_mgmt_t?  I suspect that we want to add an interface to the domain
module that allows setcontext on the domain attribute.

> interface(`ipsec_label_sa_pol',`	
> 	allow $1 $2:association polmatch;
> ')

Generally refpolicy would leave this as a raw rule these types are in
separate modules, in which case the interface would be in $2's module
and have a specific type instead of $2.

> interface(`ipsec_labels_send_recv',`		
> 	allow $1 self:association { recvfrom sendto };
> ')

This would be raw rule in refpolicy instead of an interface.

> interface(`ipsec_tools_utilities',`
> 	gen_require(`
> 		type isakmp_port_t;
> 		type inaddr_any_node_t;
> 	')
> 
> 	# allow setkey and racoon to create and use a key socket.
> 	allow $1 self:key_socket { create read write setopt };
> 
> 	# allow racoon to use ISAKMP port
> 	allow $1 isakmp_port_t:udp_socket name_bind;
> 
> 	# allow racoon to use avc_has_perm in within_range() 
> 	# to determine if proposed SA "polmatches" to policy
> 	allow $1 self:netlink_selinux_socket { bind create read };
> 
> 	# I think this is so racoon can listen on an admin port.
> 	allow $1 inaddr_any_node_t:tcp_socket node_bind;
> 
> 	# to create, remove read lock in /var/racoon/
> 	ipsec_manage_pid($1)
> 
> 	# in grabmyaddrs() socket(PF_ROUTE...)
> 	allow $1 self:netlink_route_socket { create_netlink_socket_perms };
> ')

Again, why is this needed, instead of ipsec_mgmt_t?

I suspect that the ipsec policy needs to be overhauled because I believe
it was oriented towards the KAME ipsec implementation (pluto, et al) and
was augmented to work with racoon afterwards.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
