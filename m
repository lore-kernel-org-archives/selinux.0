Message-ID: <418A7862.9060807@redhat.com>
Date: Thu, 04 Nov 2004 13:43:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: I would like to move some of the port definitions out of the te files
 into a separate location.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have modified can_network to be able to accept ports that you can 
connect to.

So you can do a
can_network(local_login_t, `kerberos_port_t')

or

can_udp_network($1_t, `resolve_port_t')

The problem is that some of these ports are not defined unless the te 
file is included.  Thus net_contexts is
flooded with ifdef's.  The problem is that this is written from a daemon 
point of view.  IE if I am running the
kerberos daemon I want to name_bind to it so I define kerberos_port_t.  
As we more to the connect side, we
can lock down daemons to say that they can only connect to certain ports 
so we might need kerberos_port_t
defined even though our policy does not include kerberos.te.  I might 
want to lock down a daemon on targeted
to only be able to connect to port XYZ but do not want to support policy 
for XYZ daemon.

What do you think of moving most of the definitions to types/network.te 
or types/ports.te and allowing them to be used by all daemons.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
