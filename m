Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh
 <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux
 <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <201003261547.33226.paul.moore@hp.com>
References: <4BA7E4BF.1040002@redhat.com>
	 <201003251736.48820.paul.moore@hp.com>
	 <1269610923.2980.51.camel@dhcp231-113.rdu.redhat.com>
	 <201003261547.33226.paul.moore@hp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 14:29:24 -0400
Message-ID: <1269887364.2980.195.camel@dhcp231-113.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Radical idea incoming: it's going to take some work and require some
changes but I hope it might allow the networking controls to 'make
sense'.  We have 2 conflicting goals/requirements when it comes to
network controls.  1) Dan wants to reasonably write rules (which he
understands) which say that process A can talk to Process B.  2) The
kernel sees the socket as the end point not the process.  In the current
world we really only meet requirement #2 and #1 is
difficult/complex/inconsistent/fun/not fun/add term here.

We currently have 3 (well 4) completely separate labels involved in
networking.

task_struct label (label of the process)
struct socket label (via SOCKET_INODE())
struct sock label
struct skbuff secmark label (the 4th I'm sorta ignoring but I think
would work just fine).

I have heard mentioned how there might be a wish to unify and make the
struct socket and struct sock labels always the same.  I'm wondering if
it isn't a good idea the way it is.  We could intentionally use the
struct socket and the struct sock labels for different things.  We use
the struct socket label when making checks between the process and the
socket.  We use the struct sock label when making checks between 2
sockets and between skb's and sockets.

The struct socket labels would be 'created' or 'relabeled' based on the
available peer_sid information.  The struct sock labels would always
(I'm ignoring the possible inconsistencies of sockcreatecon()) be that
of the parent process.  Basically we end up with something like this:

Client Process:	Client Socket:	Client Sock:		Server Sock:	Server Socket:	Server Process:
C1		C1		C1			S2		S2		S2
[Client calls connect]					[Server call accept]
[The client struct socket is relabeled]			[new child socket below, I ignore original socket]
C1		S2		C1			S2		C1		S2

Now we have multiple types of checks wich I know off the top of my head
we want to deal with, namely:  {read/write:socket} {recv:peer}
{recv:packet} There are other like the node and netif checks I don't
know about.  Maybe I want a flag day and throw all those out.  Noone
uses them right?

In any case the process->socket checks like
read/write/connect/bind/listen/accept blah blah blah would all take
place between the process and the label on struct socket.  The inter
socket checks like recv and those in class packet would all be done
using the struct sock label.

All the directionality of the rule makes sense, all the rules make
intuitive sense.  Can this process write to this socket?  Can this type
of sockets rec packets from that type of socket?  Can this process read
from that type of socket and stuff like that?

I think it solves the problems Paul mentioned of being unable to
describe relationships between client/server communication and it solves
my problems of having rules mean the opposite of what they seem.

The biggest issue is that it involves the relabeling of struct socket of
the client side which we do not do today.  What do others think?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
