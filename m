From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Bill Laut <wlsel@verizon.net>, SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Date: Wed, 9 Jul 2003 19:26:30 +1000
References: <200307082303.22083.wlsel@verizon.net>
In-Reply-To: <200307082303.22083.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307091926.30842.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jul 2003 13:03, Bill Laut wrote:
> (1)  Once I finish cleaning up my gateway/router's policy, I would like to
> migrate my workstation to SELinux so that I can allow Mozilla to run
> Javascripting and/or plugins without the fear of my workstation being
> compromised.  In reading through the archive, it seems the only thing that
> needs to be modified is kdm.  Is this a correct assumption, or should I
> expect it to be more involved than that?

Currently there is no usable patch for kdm.  The reason for this is that the 
SE Linux header files do not compile in C++ mode (and kdm is mostly C++).  I 
have been meaning to solve this but haven't had time.

If you can get a basic program compiled in C++ mode (source named file.cpp) 
that can get it's process context and do an execve_secure() then that will be 
99% of the work necessary to get a SE patched kdm.

However kdm is not necessary to run KDE.  You can login at the console and run 
"exec startx", which is what I do now.

> The idea I had was to create a pseudo-device driver that leverages
> NetFilter

Why not just write an application that uses libpcap (tcpdump functionality)?

> to output all traffic from all TCP streams to a user-mode daemon
> that writes the packets for each stream into their own separate disk files

NB  Make sure you have SE Linux policy to make these files append-only.

> If, however, any security violations are reported they are recorded into
> the transcript file in sequence with the TCP packets, and then when the
> stream is closed the completed file is moved into a permanent directory for
> later analysis.

Sounds like an interesting research idea.  It would be intersting to see the 
results of this, it could even make a good paper for a conference such as 
OLS.  I think it would be good if you do this and publish the code under the 
GPL.  Even if you determine that it's not viable in the initial design form 
it will be a good contribution to the code base and a report on it will be a 
good contribution to the knowledge of network security.

If it has been done before with SE Linux then it hasn't been published.  It 
may have been done before with other MAC systems.


PS I didn't see any reference to honeypots in your message, although I guess 
any IDS technology could form part of a honeypot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
