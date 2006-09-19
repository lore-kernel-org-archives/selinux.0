Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8JLJwVT024159
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 17:19:58 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8JLJ00H015191
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 21:19:01 GMT
Message-ID: <36282A1733C57546BE392885C0618592015730E5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Subject: RE: ipsec, netlabels, secmark- How about a little usability?
Date: Tue, 19 Sep 2006 17:19:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> We have been having some meetings to discuss how we can use 
> this stuff 
> in the real world (IE Non MLS), and I think the current 
> implementation 
> is coming up short.  The discussions I have seen have talked 
> about using 
> getpeercon to look at the other end of the connections, but 
> this is not 
> in the spirit of SELinux where modification of the 
> applications should 
> not be necessary to secure the environment.
> 

I would like to start off with a reference to the Labeled Networking Design
doc at http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2

While secmark as currently implemented upstream "marks" packets,
the secid reconciliation patches being considered for upstream
turn secmark contexts that are defined using iptables, into contexts
on the respective "flow control points". This is a significant shift
in the paradigm and the benefits will be obvious in the later part of
the discussion:

Example (INCOMING PACKETS):

iptables -t mangle -A INPUT -p tcp --dport 22 -m state --state NEW -j
SEL_SSHD
iptables -t mangle -A SEL_SSHD -j SECMARK --selctx
system_u:object_r:sshd_t:s0
iptables -t mangle -A SEL_SSHD -j ACCEPT

The above is really defining the context on an "entry point".

Any packets not labeled externally using labeled IPSec, or CIPSO and
"flowing in" thru that entry point will assume the "entry point" context,
but only by virtue of the packets coming in thru that "entry point".

So, what happens if an externally labeled packet (e.g.: Labeled IPSec)
comes in thru the above entry point? First of all, a check is made to
see if a packet so labeled using IPSec (unlabeled if no IPSec) can
"flow in" thru the "entry point". If it can, and if there's an
IPSec label on the packet, a transition sid is computed between the
"entry point" label and the IPSec label and the packet will be marked
with this transition sid. The transition label will either be the IPSec
label (default) or any other label as defined by SELinux policy transition
rules.

The socket is then checked for packet.recv access to the packet before
the socket can receive the packet.

Example (OUTGOING PACKETS):

iptables -t mangle -A OUTPUT -p tcp --dport 22 -m state --state NEW -j
SEL_SSH_CLIENT
iptables -t mangle -A SEL_SSH_CLIENT -j SECMARK --selctx
system_u:object_r:ssh_client_t:s0
iptables -t mangle -A SEL_SSH_CLIENT -j ACCEPT

The above is really defining the context on an "exit point".

A locally generated packet will normally assume the label of the socket.
Next,
a check is made to see if the packet can "flow out" thru IPSec (unlabeled if
not using Labeled IPSec). If the packet uses labeled IPSec, a transition sid
is computed between the socket label and the IPSec label. The transition
label
will be the IPSec label (default) or any other label as defined by SELinux
policy rules.

The packet is then checked for "flow out" access to the "exit point"
defined using iptables output rules above.

> 
> Lets look at some real world situations where having better 
> controls on 
> the network would work and someone explain to me how Joe Average 
> SysAdmin will set them up.

I will try to show elements of policy for the below example, but
turning it into something useable by Joe Average will obviously
involve integration and policy abstractions that are currently
outside the scope of this discussion. I will let "policy experts"
out there to weigh in here with suggestions and ideas.

PERFORMANCE:

There were some concerns about iptables performance. While
I haven't done any testing in this regard, I would think that it would
atleast compare to the "compat" case where the contexts are looked up on
the node, netif, port individually. Also, bear in mind that the labeling
rules for "entry" and "exit" points as shown above could be placed AFTER
all other normal iptables rules that could drop a packet, so I do not
understand why a packet now has to go thru 400 or so more rules than
otherwise,
before being dropped.

I would imagine that iptabels lookups would be much more efficient than
the current individual lookups on node/netif/port. Another optimizing factor
would be that INPUT/FORWARD rules could be used instead of PREROUTING to
delay jumping to the (CONN)SECMARK target(s). The idea is that labeling
could come AFTER all the drop checks. i.e. one could replace appropriate
ACCEPTs with a jump to the appropriate labeling chain that in turn would
call into (CONN)SECMARK, for example.

> 
> 
> 1.  By default httpd has to be able to talk to itself in order to do 
> gracefull shutdown,
> service httpd graceful.
> 
> So I end up adding a rule allowing httpd to name_connect to the 
> httpd_port_t.    But I really only want to allow this for 
> localhost.  IE 
> I don't want to allow my httpd to name_connect to other 
> machines httpd 
> ports?  I can't do this now.

1. Define "exit" and "entry" point contexts, rather the "connection" context
   (specifically an "outgoing connection") in this case:

iptables -t mangle -A POSTROUTING -o lo -p tcp --sport 80 --dport 80 -m
state --state NEW -j SEL_HTTPD2HTTPD
iptables -t mangle -A SEL_HTTPD2HTTPD -j SECMARK --selctx
system_u:object_r:httpd2httpd_t:s0
iptables -t mangle -A SEL_HTTPD2HTTPD -j CONNSECMARK --save
iptables -t mangle -A SEL_HTTPD2HTTPD -j ACCEPT

# Common rules which copy connection labels to established
# and related packets.
iptables -t mangle -A INPUT -m state --state ESTABLISHED,RELATED -j
CONNSECMARK --restore
iptables -t mangle -A OUTPUT -m state --state ESTABLISHED,RELATED -j
CONNSECMARK --restore

2. Allow the "httpd_t" packets to exit thru the "exit point"

allow httpd_t httpd2httpd_t:packet { flow_out };

NOTE: Packet goes over loopback at this time.

3. Packet didn't use IPSec, so it is "unlabeled" in that "external
    labeling" sense. Allow the non-IPSec packets thru the "entry point".

allow unlabeled_t httpd2httpd_t:packet { flow_in };

NOTE1: If using Labeled IPSec SAs, "unlabeled_t" above would be substituted
with the Type associated with the IPSec SAs here.

NOTE2: Packet is labeled with httpd2httpd_t at this point.

4. Finally, allow the httpd_t socket to receive the packets.

allow httpd_t httpd2http_t:packet { recv };

I applied sorta linear thinking in the above, but the rules could perhaps
be optimized into a smaller rule set particularly in conjunction with
rules for other services.

Anyone see any unintended flows in the above?

Also, since I happened to reuse secmark with a shift in paradigm, the
current naming might be a little bit awkward or even confusing.

I am not well versed in the current policy design as far as useability
is concerned but I would think that the above could be made "useable" for
Joe Average by doing some smart policy interfaces, etc. Policy guys, please
weigh in here.

> 
> 2.  I as a sysadm have setup a apache web site that allows 
> connections 
> from the outside and needs to connect to three mysql servers on my 
> internal network. So I need to allow it to connect to those three 
> machines on the internal network only.  How am I as the 
> Sysadm going to 
> set this up.

You would pretty much do the same as in the previous scenario except
you would also allow connection packets (NEW, ESTABLISHED, RELATED)
from httpd_t to those 3 servers (or a subset of these as can be defined
by standard iptables selection criteria) by defining appropriate
"connection contexts" (which encompass the entry and exit contexts
as described above).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
