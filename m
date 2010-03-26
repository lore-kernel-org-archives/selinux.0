From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Fri, 26 Mar 2010 15:47:33 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
References: <4BA7E4BF.1040002@redhat.com> <201003251736.48820.paul.moore@hp.com> <1269610923.2980.51.camel@dhcp231-113.rdu.redhat.com>
In-Reply-To: <1269610923.2980.51.camel@dhcp231-113.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003261547.33226.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 March 2010 09:42:03 am Eric Paris wrote:
> Thanks Paul for laying things out in a dumbed down enough way for me to
> grasp a couple things  :)   I now understand about 2% of what we are
> trying to accomplish with network checks.  Next time I see you in person
> you better be careful because I could use about 25 more of these lessons
> to understand the fun/difficult/other parts of networking code.

 :)

> On Thu, 2010-03-25 at 17:36 -0400, Paul Moore wrote:
> > Well, we
> > already have a label assigned to the client's socket and we don't want to
> > change that so we'll leave that alone
> 
> Why is this a given?  Seems to me there is a fundamental difference
> between a socket before connect() and a socket after connect().  Much
> the same as the (I think agreed upon) fundamental difference between a
> socket before accept() and the 'child' socket we get after accept().

The key different between the client side socket, created with socket() and 
connected via connect(), and the server side child socket, created with 
accept() is that we don't know the label of the other end when the client 
socket is created whereas we know the label of the other end when the server 
side child socket is created.

We could _relabel_ the client side socket on connect but that could be ugly 
and would likely be frowned upon by the security die-hards.  We would probably 
also want to limit it to stream sockets as you can't really disconnect them, 
although you can disconnect connected datagram sockets.

> My original wish for how things would be labeled does lead to a very,
> ummm, interesting, result.  What I wanted to see and thought was the
> most logical was the following:
> 
> client process: client_t:s0:c1
> server process: server_t:s0-s15:c0-c1023
> 
> both are going to have to create a socket with the socket() call right?
> so we are going to end up with:
> 
> client_sock: client_t:s0:c1
> server_sock: server_t:s0-s15:c0-c1023
> 
> Now we have calls to connect() and accept() respectively, correct?  My
> original thought on how these socks should be labeled was that we should
> now get
> 
> client_sock: server_t:s0-s15:c0-c1023
> server_sock: client_t:s0:c1

A point of clarification: I think you mean "server_child_socket" above, not 
the original listening server socket.

> Which clearly makes the most sense to everyone in how read/write rules
> from the application to the socket should be written and allowed.

Well, in one direction anyway; I think you are assuming a one way data flow 
here.  Think about what happens when the client socket receives data from the 
server socket?  What about when the server socket receives data from the 
client socket?

> Each side would need rules like:
> 
> allow client_t:s0:c1 server_t:s0-s15:c0-c1023:socket { read write }
> allow server_t:s0-s15:c0-c1023 client_t:s0:c1:socket { read write }
> 
> Seems great, but you point out the logical next step which is the rules
> between the sockets themselves which would be reversed (opps, bad news
> for my world of making sense)  These checks are against what?  packet
> and peer?

Okay, you got the point about bi-directional traffic.

Quick and dirty pseudo-policy example (some of the classes/perms may not be 
100%) for app "foo" talking to app "bar" over the network (ignores 
ingress/egress and secmark controls):

 # let foo_t act as a basic network client for sockets it creates
 allow foo_t self:socket { create connect read write }

 # let bar_t act as a basic network server for sockets it creates
 allow bar_t self:socket { create listen accept read write }

 # let bar_t receive network traffic from foo_t
 allow bar_t foo_t:peer { recv }

> I guess the solution to this odd reversal of meanings is the old
> question you mentioned before and didn't want to bring up of: is the
> socket the endpoint or is the application the end point?  As I was
> around, but ignorant/ignored those discussions, why did we end up this
> way?

Well, this is the way it was when I got here so I can't say for certain but I 
believe it comes down to the fact that sockets, like any other file 
descriptor, can get passed around from application to application and you want 
to be sure that have the right access controls in place to prevent traffic 
going somewhere it shouldn't if a socket is passed to an app with a different 
label.  By enforcing access controls when data is queued to a socket as well 
as later when it is read from the socket we can ensure data doesn't go 
somewhere it shouldn't.

I think it also makes the implementation on Linux a little easier too :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
