Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Date: Wed, 9 Jul 2003 14:08:45 -0400
References: <200307082303.22083.wlsel@verizon.net> <200307091926.30842.russell@coker.com.au>
In-Reply-To: <200307091926.30842.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200307091408.45581.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2003 05:26 am, Russell Coker wrote:
> On Wed, 9 Jul 2003 13:03, Bill Laut wrote:
> > (1)  Once I finish cleaning up my gateway/router's policy, [...]
>
> Currently there is no usable patch for kdm.  The reason for this is that
> the SE Linux header files do not compile in C++ mode (and kdm is mostly
> C++).  I have been meaning to solve this but haven't had time.
>
> If you can get a basic program compiled in C++ mode (source named file.cpp)
> that can get it's process context and do an execve_secure() then that will
> be 99% of the work necessary to get a SE patched kdm.
>

I copied Tom's patched xdm source code, and I will use it along with the 
SELinux's modified login program as a template for changing kdm.

>
> However kdm is not necessary to run KDE.  You can login at the console and
> run "exec startx", which is what I do now.
>

True, but that approach struck me as akin to an "invention in progress," as 
opposed to having a finished product.  Additionally, if SELinux ever hopes to 
be widely adopted into the desktop arena, this bit of xdm/kdm/gdm polishing 
has to be done because the end-user community will never accept having to 
type in "exec startx."  So, this is as good a time as any to get it out of 
the way.

>
> > The idea I had was to create a pseudo-device driver that leverages
> > NetFilter
>
> Why not just write an application that uses libpcap (tcpdump
> functionality)?
>

Somewhat pragmatic but also personal aesthetic:  It seems to me that the 
shortest, simplist way to implement this functionality is to patch the TCP 
layer of the stack itself (and not NetFilter--my mistake) to divert all 
packets into and out of the TCP layer through a device driver that copies 
each packet and then queues the copies to its associated "/dev/whatever" 
file, where a user-mode daemon is waiting to read the packets from 
/dev/whatever and write them to disk.

Going this approach would also simplify obtaining the AVC messages, because 
avc could easily be patched as well to accomodate the driver's copying of any 
relevant security violations as avc prepares to send them to the logger.  
This would facilitate bundling all relevant attack data into one convenient 
file for analysis.

(Or, for that matter, I could even send the security data to another PC that's 
a dedicated logger in order to keep it out of reach of the attacker--but now 
I'm getting ahead of myself.)

Also, since this is a first-order experimental project, rather than drag in 
other packages that might otherwise unduly "bloat" it at this stage, I would 
prefer to use an approach that's as straightforward and simple as possible.  
Once completed, and with its lessons learned, I can then look at extending 
the functionality into different directions.  *That* would be the time, imo, 
to consider perhaps embracing libpcap or prelude.

To use a colloquialism, "baby steps."

As for the personal aesthetic, well, it's been awhile since I had a chance to 
do some kernel hacking, and this looked like a really cool hack.  :-)

>
> > to output all traffic from all TCP streams to a user-mode daemon
> > that writes the packets for each stream into their own separate disk
> > files
>
> NB  Make sure you have SE Linux policy to make these files append-only.
>

Noted.  Thank you for the tip.

>
> > If, however, any security violations are reported they are recorded into
> > the transcript file in sequence with the TCP packets, and then when the
> > stream is closed the completed file is moved into a permanent directory
> > for later analysis.
>
> Sounds like an interesting research idea.  It would be intersting to see
> the results of this, it could even make a good paper for a conference such
> as OLS.  I think it would be good if you do this and publish the code under
> the GPL.  Even if you determine that it's not viable in the initial design
> form it will be a good contribution to the code base and a report on it
> will be a good contribution to the knowledge of network security.
>

It's these kinds of proposed tools that have the potential to make SELinux 
even more appealing to the server community, and in the process leverage 
SELinux to an even larger audience.  Namely, imagine offering them something 
that can not only summarily block the hackers, crackers and script kiddies, 
but can also identify -how- they compromised the daemon as quickly as the 
attackers can find its weaknesses.

While I'm thinking about it, is it possible to configure a domain wherein you 
can limit which ports a daemon is allowed to declare as TCP listeners and/or 
which UDP port numbers it is allowed to create?  That would useful for 
detecting BOs.

>
> If it has been done before with SE Linux then it hasn't been published.  It
> may have been done before with other MAC systems.
>

I'll begin this project sometime in early August, as I have committments for 
July.  Per your suggestion I will publish the code under the GPL via 
Sourceforge.

>
> PS I didn't see any reference to honeypots in your message, although I
> guess any IDS technology could form part of a honeypot.
>

You're right; the reference to honeypots was tangential.  What I was thinking 
of was an SELinux server which logs the attack but doesn't impede its 
progress, so that the attacker's ultimate objective can be determined along 
with the vector used to reach it, hence the reference to a honeypot.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
