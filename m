From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Bill Laut <wlsel@verizon.net>, SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Date: Thu, 10 Jul 2003 12:20:41 +1000
References: <200307082303.22083.wlsel@verizon.net> <200307091926.30842.russell@coker.com.au> <200307091408.45581.wlsel@verizon.net>
In-Reply-To: <200307091408.45581.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307101220.41566.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jul 2003 04:08, Bill Laut wrote:
> > > The idea I had was to create a pseudo-device driver that leverages
> > > NetFilter
> >
> > Why not just write an application that uses libpcap (tcpdump
> > functionality)?
>
> Somewhat pragmatic but also personal aesthetic:  It seems to me that the
> shortest, simplist way to implement this functionality is to patch the TCP
> layer of the stack itself (and not NetFilter--my mistake) to divert all

Anything that involves significant kernel changes is unlikely to be the 
shortest simplest solution.

libpcap is something that you can get going in a day and which will result in 
nothing worse than the application itself segv'ing if there's a bug.  Kernel 
code will take significantly more time to write and has significantly greater 
potential to break things if there's a bug.

> Going this approach would also simplify obtaining the AVC messages, because
> avc could easily be patched as well to accomodate the driver's copying of
> any relevant security violations as avc prepares to send them to the
> logger. This would facilitate bundling all relevant attack data into one
> convenient file for analysis.

Yes, you can patch the SE code to handle denied messages in a different 
manner.

> As for the personal aesthetic, well, it's been awhile since I had a chance
> to do some kernel hacking, and this looked like a really cool hack.  :-)

There's lots of other useful kernel work that could be done if you are looking 
for kernel projects.

> While I'm thinking about it, is it possible to configure a domain wherein
> you can limit which ports a daemon is allowed to declare as TCP listeners
> and/or which UDP port numbers it is allowed to create?  That would useful
> for detecting BOs.

Yes, you can already do this through the name_bind access in the tcp_socket 
and udp_socket classes.  The default is that the can_network() macro (used by 
everything that accesses the network) grants access to bind to all ports that 
are not specifically mentioned in the policy.

It has been suggested that we change this and only allow certain domains to 
bind to all ports.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
