Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Date: Thu, 10 Jul 2003 04:09:12 -0400
References: <200307082303.22083.wlsel@verizon.net> <200307091408.45581.wlsel@verizon.net> <200307101220.41566.russell@coker.com.au>
In-Reply-To: <200307101220.41566.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200307100409.12615.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2003 10:20 pm, Russell Coker wrote:
> On Thu, 10 Jul 2003 04:08, Bill Laut wrote:
> >
> > Somewhat pragmatic but also personal aesthetic:  It seems to me that the
> > shortest, simplist way to implement this functionality is to patch the
> > TCP layer of the stack itself (and not NetFilter--my mistake) to divert
> > all
>
> Anything that involves significant kernel changes is unlikely to be the
> shortest simplest solution.
>

The pseudo-device driver I'm envisioning is minimally invasive to the affected 
modules for the reasons you cite below.  Everything else is done outside of 
the kernel.  However, your recommendation of libpcap is noted and will be 
seriously considered.

>
> libpcap is something that you can get going in a day and which will result
> in nothing worse than the application itself segv'ing if there's a bug. 
> Kernel code will take significantly more time to write and has
> significantly greater potential to break things if there's a bug.
>

I understand the implications you raise here.  Once upon a time, almost a 
generation ago, I used to write multi-threaded telecommunications drivers for 
the VAX/VMS Operating System.  I fully appreciate the work involved.

>
> > As for the personal aesthetic, well, it's been awhile since I had a
> > chance to do some kernel hacking, and this looked like a really cool
> > hack.  :-)
>
> There's lots of other useful kernel work that could be done if you are
> looking for kernel projects.
>

Unfortunately, as an amateur cryptology enthusiast my plate is nearly full 
with some unrelated projects I'm engaged in.  As those near completion I may 
take you up on your offer.  Hopefully by then I'll be better acquainted with 
SELinux that I could seriously offer to help you with some kernel work.

>
> > While I'm thinking about it, is it possible to configure a domain wherein
> > you can limit which ports a daemon is allowed to declare as TCP listeners
> > and/or which UDP port numbers it is allowed to create?  That would useful
> > for detecting BOs.
>
> Yes, you can already do this through the name_bind access in the tcp_socket
> and udp_socket classes.  The default is that the can_network() macro (used
> by everything that accesses the network) grants access to bind to all ports
> that are not specifically mentioned in the policy.
>

Excellent.  I'm continually impressed with the thoroughness of SELinux.  You 
folks deserve to be proud of your accomplishment.

>
> It has been suggested that we change this and only allow certain domains to
> bind to all ports.
>

That would be prudent, especially for the daemons.  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
