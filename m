Subject: Policy question
From: Reino Wallin <reino@oribium.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 02 May 2002 12:11:14 +0200
Message-Id: <1020334278.21391.92.camel@matilda>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have defined a few nodes as well as a few interfaces in network.te,
and net_contexts.

In the te files for the standalone proxies (http and generic) the
following will do:

# Allow the domain to send to any node.
allow http_proxy_t node_type:node { tcp_send tcp_recv };

However, the same approach doesn't work in the inetd.te. Avc error
messages appears, and the following rules are supposed to be added.

# Allow the domain to send to any node.
allow inetd_t node_admin_t:node { tcp_send tcp_recv };
allow inetd_t node_dmz_t:node { tcp_send tcp_recv };
allow inetd_t node_vpn_t:node { tcp_send tcp_recv };
allow inetd_t node_internal_t:node { tcp_send tcp_recv };
allow inetd_t node_external_t:node { tcp_send tcp_recv };

If I add theese rules, then also the proxies that is executed from the
inetd works fine in enforcing mode.

Why are theese fine grained rules needed in the inetd.te but not in the
other te files?

Reino



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
