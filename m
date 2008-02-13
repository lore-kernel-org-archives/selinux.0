Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1D2L3Dl002584
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 21:21:03 -0500
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1D2L238015640
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 02:21:02 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1D0oRHx004288
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 19:51:58 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1D0o9mU030733
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 19:50:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: CORBA and network labeling capabilities
Date: Tue, 12 Feb 2008 16:50:31 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm in the early stages of experimenting with CORBA (Orbix) and SELinux.
I've started with an example provided with Orbix where a simple client
communicates with a simple server using the Orbix naming service to
locate the server.

I've created 3 domains, orbix_t for the ORB processes (naming & locator
services, node daemon, etc), sample_client_orbix_client_server_t for the
client, and sample_server_orbix_client_server_t for the server.

For this simple example, I'm running all the processes (client, server,
and ORB) on a single host.

To get this to work, I need to provide the following allow rules for the
orbix_t domain (only the network specific rules are shown):

allow orbix_t self:tcp_socket { setopt read bind create accept write
getattr connect getopt listen shutdown};

allow orbix_t port_t:tcp_socket name_connect;
     (or)
corenet_tcp_connect_generic_port(orbix_t)

allow orbix_t unlabeled_t:packet { send recv };
     (or)
corenet_non_ipsec_sendrecv(orbix_t)

allow orbix_t node_type:tcp_socket node_bind;
     (or)
corenet_tcp_bind_all_nodes(orbix_t)


The necessary rules for the client and the server are nearly identical
to these.

The problem results from the fact that there are no rules associating
any of the 3 domains with each other. This means that if I have multiple
clients and servers, I can't set up rules to specify which clients can
communicate with which servers. I'm stuck with every client being able
to communicate with every server. (Actually, I could limit communication
by running the clients and servers on specified labeled ports, but this
eliminates any practical method of enforcing MLS constraints)

If the client and server were running on separate hosts, with an IPSec
tunnel set up between them, the functionality that I'm looking for is
provided with the IPSec security association object class:

allow sample_client_orbix_client_server_t
sample_server_orbix_client_server_t:association recvfrom;

Is there some way to get similar functionality when the processes are
running on the same host? (Can an IPSec tunnel can be created through
the loopback interface? Or is there a better way to do this?)

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
