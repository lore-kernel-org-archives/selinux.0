Subject: Firewall Policy
From: Reino Wallin <reino@oribium.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-TQqlifQhqN5ahAiPeQvO"
Date: 12 Mar 2002 01:57:30 +0100
Message-Id: <1015894650.23617.1464.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-TQqlifQhqN5ahAiPeQvO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I just posted a new release of my policy scripts for an application
layer firewall. The scripts can be found at 
http://www.oribium.com/selinux/
This release is pretty much better then the initial one. They are not
yet ready for a production environment though. 

I have a few suggestions to improve the example policy as well. 

named_t: 

To make the nameserver to work as a slave server, we may consider to
grant write permissions to named_conf_t:dir and named_conf:file: 

inetd_t: 

If we allow inetd to setuid, then it will be more flexible, and the 
daemons can run as non root.

It seems the following line is needed on my machine, but I haven't
actually checked this up more in detail. 

allow system_crond_t var_lib_rpm_t:dir { add_name remove_name write }; 

I have modified the network.te, and net_contexts, to allow multiple
NIC's and IPSEC features. Patches are enclosed. This will allow a more
fine grained control as well. 

I think most policy developers will use the example policy as a starting
point for their work. I suggest that all new policy scripts for domains
should contain all the required networking capabilities, so we don't
have to grant full networking rights to all domains anymore. 

As far as I can understand there is no need to grant an ftpuser or a
popuser the right to change role, neither to have access to a shell. It
seems appealing, just to grant a very limited set of rights to the
default user, and add a few more user types, like a shell user and a
trusted user. Am I wrong here? I am figuring to add a few new user types
to my firewall policy. Please let me know your thoughts, and I may put
something together that suits the example policy as well.

-- 
Reino Wallin, Oribium Labs
reino@oribium.com

--=-TQqlifQhqN5ahAiPeQvO
Content-Disposition: attachment; filename=net_contexts.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

6c6,7
< #
---
> # Modified by Reino Wallin <reino@oribium.com>
> # Multi NIC, and IPSEC features
20a22,24
> tcp 9873 system_u:object_r:http_port_t
> tcp 9874 system_u:object_r:telnet_port_t
> tcp 9875 system_u:object_r:ftp_port_t
32c36,39
<=20
---
> eth2 system_u:object_r:netif_eth2_t system_u:object_r:netmsg_eth2_t
> ipsec0 system_u:object_r:netif_ipsec0_t system_u:object_r:netmsg_ipsec0_t
> ipsec1 system_u:object_r:netif_ipsec1_t system_u:object_r:netmsg_ipsec1_t
> ipsec2 system_u:object_r:netif_ipsec2_t system_u:object_r:netmsg_ipsec2_t
48c55
< 10.33.1.2 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nfs_t
---
> 192.168.2.32 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nf=
s_t

--=-TQqlifQhqN5ahAiPeQvO
Content-Disposition: attachment; filename=network.te.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

4c4,5
<=20
---
> # Modified by Reino Wallin <reino@oribium.com>
> # Multi NIC, and IPSEC features
50a52
> type netif_eth2_t, netif_type;
51a54,56
> type netif_ipsec0_t, netif_type;
> type netif_ipsec1_t, netif_type;
> type netif_ipsec2_t, netif_type;
60a66
> type netmsg_eth2_t, netmsg_type;
62c68,70
<=20
---
> type netmsg_ipsec0_t, netmsg_type;
> type netmsg_ipsec1_t, netmsg_type;
> type netmsg_ipsec2_t, netmsg_type;
92a101
> allow netmsg_eth2_t node_t:node { tcp_recv udp_recv rawip_recv };
94a104,106
> allow netmsg_ipsec0_t node_t:node { tcp_recv udp_recv rawip_recv };
> allow netmsg_ipsec1_t node_t:node { tcp_recv udp_recv rawip_recv };
> allow netmsg_ipsec2_t node_t:node { tcp_recv udp_recv rawip_recv };

--=-TQqlifQhqN5ahAiPeQvO--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
