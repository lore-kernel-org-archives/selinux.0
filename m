Subject: Firewall Policy - thoughts
From: Reino Wallin <reino@oribium.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 25 Apr 2002 18:17:07 +0200
Message-Id: <1019751428.27628.77.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Besides to provide a Makefile for easy setup, the next step in my work
with the firewall policy will be to refine the rules for interfaces and
nodes.

At this time my idea is to refine the type enforcement files so they,
without modification, can be used to set up the most common types, like:

	+ LAN/DMZ/Internet
	+ VPN gateway
	+ Corporate bastion host
	+ Home office, LAN/Internet
	+ A corporate firewall to separate departments

I figure it might be possible to set up the different types of firewalls
only by editing net_contexts if the type enforcement files are properly
written. When I know exactly what should be done, I will provide an
interactive script to do it.

Anyway, below are some examples how it might look like. They are not
complete, though.

---
network.te

	type node_admin_t, node_type;
	type node_dmz_t, node_type;
	type node_internal_t, node_type;
	type node_external_t, node_type;
	type node_extranet_t, node_type;
	type node_vpn_t, node_type;

	type netif_admin_t, netif_type;
	type netif_dmz_t, netif_type;
	type netif_external_t, netif_type;
	type netif_extranet_t, netif_type;
	type netif_internal_t, netif_type;
	type netif_vpn_t, netif_type;

	the analogous metmsg_type as well 

net_contexts

	eth0 system_u:object_r:netif_vpn_t system_u:object_r:netmsg_vpn_t
	eth1 system_u:object_r:netif_admin_t system_u:object_r:netmsg_admin_t
	eth2 system_u:object_r:netif_internal_t
system_u:object_r:netmsg_internal_t
	eth3 system_u:object_r:netif_dmz_t system_u:object_r:netmsg_dmz_t
	
generic.proxy.te

	# Allow the domain to initiate TCP connections 
	# on certain network interfaces.
	allow generic_proxy_t netif_dmz_t:tcp_socket { connectto };
	allow generic_proxy_t netif_external_t:tcp_socket { connectto };
	allow generic_proxy_t netif_extranet_t:tcp_socket { connectto };
	allow generic_proxy_t netif_vpn_t:tcp_socket { connectto };

	# Allow the domain to accept TCP connections 
	# on certain network interfaces.
	allow generic_proxy_t netif_admin_t:tcp_socket { acceptfrom };
	allow generic_proxy_t netif_dmz_t:tcp_socket { acceptfrom };
	allow generic_proxy_t netif_external_t:tcp_socket { acceptfrom };
	allow generic_proxy_t netif_extranet_t:tcp_socket { acceptfrom };
	allow generic_proxy_t netif_internal_t:tcp_socket { acceptfrom };
	allow generic_proxy_t netif_vpn_t:tcp_socket { acceptfrom };

	the analogous metmsg_type as well

	additional rules for the nodes

---

What do you think of this?

Reino




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
