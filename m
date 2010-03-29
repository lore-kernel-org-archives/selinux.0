Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh
 <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux
 <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <201003251736.48820.paul.moore@hp.com>
References: <4BA7E4BF.1040002@redhat.com>
	 <1269542084.1031.52.camel@moss-pluto.epoch.ncsc.mil>
	 <1269542713.2980.14.camel@dhcp231-113.rdu.redhat.com>
	 <201003251736.48820.paul.moore@hp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 13:05:58 -0400
Message-ID: <1269882358.2980.151.camel@dhcp231-113.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[resending as tycho.nsa.gov bounced it the first time.  Paul already
responded so this is just for the archives]

Thanks Paul for laying things out in a dumbed down enough way for me to
grasp a couple things  :)   I now understand about 2% of what we are
trying to accomplish with network checks.  Next time I see you in person
you better be careful because I could use about 25 more of these lessons
to understand the fun/difficult/other parts of networking code. 

On Thu, 2010-03-25 at 17:36 -0400, Paul Moore wrote:
> Well, we 
> already have a label assigned to the client's socket and we don't want to 
> change that so we'll leave that alone

Why is this a given?  Seems to me there is a fundamental difference
between a socket before connect() and a socket after connect().  Much
the same as the (I think agreed upon) fundamental difference between a
socket before accept() and the 'child' socket we get after accept().

My original wish for how things would be labeled does lead to a very,
ummm, interesting, result.  What I wanted to see and thought was the
most logical was the following:

client process: client_t:s0:c1
server process: server_t:s0-s15:c0-c1023

both are going to have to create a socket with the socket() call right?
so we are going to end up with:

client_sock: client_t:s0:c1
server_sock: server_t:s0-s15:c0-c1023

Now we have calls to connect() and accept() respectively, correct?  My
original thought on how these socks should be labeled was that we should
now get

client_sock: server_t:s0-s15:c0-c1023
server_sock: client_t:s0:c1

Which clearly makes the most sense to everyone in how read/write rules
from the application to the socket should be written and allowed.  Each
side would need rules like:

allow client_t:s0:c1 server_t:s0-s15:c0-c1023:socket { read write }
allow server_t:s0-s15:c0-c1023 client_t:s0:c1:socket { read write }

Seems great, but you point out the logical next step which is the rules
between the sockets themselves which would be reversed (opps, bad news
for my world of making sense)  These checks are against what?  packet
and peer?

client writing to server would need rule with source server_t and target
client_t.  server writing to client would need rules with source
client_t and target server_t.  I can only see Dan's/policy writer's
complaints then.

I guess the solution to this odd reversal of meanings is the old
question you mentioned before and didn't want to bring up of: is the
socket the endpoint or is the application the end point?  As I was
around, but ignorant/ignored those discussions, why did we end up this
way?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
