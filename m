Message-ID: <417FB917.8030109@redhat.com>
Date: Wed, 27 Oct 2004 11:04:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   sgrubb@redhat.com, Colin Walters <walters@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Limiting the power of can_network, improving the security of strict
 policy.
Content-Type: multipart/mixed;
 boundary="------------070004090909070708040909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070004090909070708040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We have been talking about ways of improving the security of strict 
policy.  So I have been working
to eliminate tunables and replace them with booleans.   So an 
administrator can easily turn them off.
(allow_ypbind and use_nfs_home_dirs defaulting to off as an example).

Also I have been working to eliminate the ncsd_ tunables by adding 
ncsd_client_domain to all daemons that need it.

Finally we are looking into limiting the power of can_network.  
Currently any daemon that has can_network can receive
and establish TCP/UDP connections.  The only thing not provided is 
name_bind.  I want to break this out to eliminate the
ability for daemons also to connect.  So an incoming only daemon, can 
not establish a connection back out.  To do this
I have modified create_socket_perms and eliminated the connect call.  I 
have added a connect_socket_perms which includes
the create_socket_perms.  This has caused many changes to be made in 
policy, and I am not sure if it was a good idea?

Also I modified can_network to take a second parameter of the type of 
the connection (udp or tcp).  This allows you to turn off tcp, connections
on a UDP application.  (I am not sure you can do this for a tcp only app 
if they are going to use name service.)

Is this a good idea or am I wasting my time?

Dan

--------------070004090909070708040909
Content-Type: text/plain;
 name="network_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="network_macros.te"

#################################
#
# can_network(domain)
#
# Permissions for accessing the network.
# See types/network.te for the network types.
# See net_contexts for security contexts for network entities.
#
define(`base_can_network',`
#
# Allow the domain to create and use $2 sockets.
# Other kinds of sockets must be separately authorized for use.
allow $1 self:$2_socket create_socket_perms;

#
# Allow the domain to send or receive using any network interface.
# netif_type is a type attribute for all network interface types.
#
allow $1 netif_type:netif { $2_send rawip_send };
allow $1 netif_type:netif { $2_recv rawip_recv };

#
# Allow the domain to send to or receive from any node.
# node_type is a type attribute for all node types.
#
allow $1 node_type:node { $2_send rawip_send };
allow $1 node_type:node { $2_recv rawip_recv };

#
# Allow the domain to send to or receive from any port.
# port_type is a type attribute for all port types.
#
allow $1 $3:{ $2_socket } { send_msg recv_msg };

# XXX Allow binding to any node type.  Remove once
# individual rules have been added to all domains that 
# bind sockets. 
allow $1 node_type: { $2_socket } node_bind;
')dnl end can_network definition

#################################
#
# can_network(domain)
#
# Permissions for accessing the network.
# See types/network.te for the network types.
# See net_contexts for security contexts for network entities.
#
define(`can_network',`

ifelse($2, `', `
base_can_network($1, udp, port_type)
base_can_network($1, tcp, port_type)
allow $1 self:tcp_socket { listen accept };
', `
ifelse($3, `', `
base_can_network($1, $2, $3)
', `
base_can_network($1, $2, port_type)
') dnl ifelse $3
ifelse($2, `tcp', `
allow $1 self:tcp_socket { listen accept };
')
')

#
# Allow the domain to send NFS client requests via the socket
# created by mount.
#
allow $1 mount_t:udp_socket rw_socket_perms;

#
# Allow access to network files including /etc/resolv.conf
#
allow $1 net_conf_t:file r_file_perms;
')dnl end can_network definition


--------------070004090909070708040909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
