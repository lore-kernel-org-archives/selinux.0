Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5QNsW0S010898
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 19:54:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5QNriss027608
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 23:53:45 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5QNrbhY027605
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 23:53:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dean Anderson <dean@av8.com>, selinux@tycho.nsa.gov
Subject: Re: abusive dnsbl's
Date: Fri, 27 Jun 2003 09:54:11 +1000
References: <Pine.LNX.4.44.0306261850530.14586-100000@vista.av8.net>
In-Reply-To: <Pine.LNX.4.44.0306261850530.14586-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306270954.11026.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Jun 2003 08:54, Dean Anderson wrote:
> Sorry, I have to send this to the list....

No you don't.  You can easily get yourself an account on hotmail.  No 
spam-blocking service blocks hotmail so you can guarantee that a message you 
send using hotmail will get received.

> You are using a revenge list for spam blocking.

No, I am using a list to stop spam being sent.

> There is no need to ever block open relays.

There is always a need to block open relays.  Spammers have been actively 
seeking and exploiting open relays for at least seven years now.  It is well 
documented how to make every mail server not be an open relay.  There is no 
excuse for having an open relay.

> First, only anti-spammer zealots abuse open relays
> sending commercial-looking but non-commercial abuse (type 3 abuse, by my
> taxonomy).

How do you know what type of spam your favourite open relay has been sending?  
Do you personally run the machine and read all mail that goes through it?

> And second, you can easilly block this abuse (and abuse of
> closed relays)  by looking at the IP addreses in the headers added by the
> relay.

Actually it's not easy with the way my mail server is setup.  While it is easy 
to just block the source IP address of the TCP connection.

Once I feel that my SE Linux work is complete I'll look into other areas, 
maybe including writing a mail server to stop spam.  Until that time I'll 
keep using the default feature set of Postfix.  There are indications that 
new versions of Postfix will allow doing more checks on headers including 
tracing the path of IP addresses, but until that's available I'll have to 
keep using the current setup.

Also the choice of anti-spam measures is not entirely up to me.  I get 
requests from other people on the machine to stop spam, I don't get 
complaints about non-spam being blocked.  Things are getting so bad that 
people have stated that they are willing to lose messages from potential 
customers if it means reducing the amount of spam!

> It is in your interest to block abuse of closed relays as well. Once you
> setup proper filters, the use of a relay (open or closed) doesn't have any
> benefit for the abuser.

I block known sources of spam, open or closed relays.

> You should be aware that the people running the so-called "open relay"
> blacklists have almost nothing to do with spam (except by sending it
> themselves).  These "blacklists" are the only sources of open relay
> scanning (as determined by logs tracing scanners and their deposit
> mailboxes), and their lists make it into commercial free relay and free
> proxy lists such as run by helllabs.com.ua and ghostsender.com.

I appreciate the work that they do.  In the early days there were a few 
occasions when they warned me about open relays that were running on my 
networks which allowed me to close them.

It's not as if the spammers can't probe the servers themselves.

> You would be much better off to block their sites, and prevent their
> scanning. However, you should also be aware that if you stop using their
> services, you will be spammed at a higher rate in revenge. So, you have to
> be prepared to deal with abuse detection and prevention.

No.  If you block their scans then they will probably conclude that you are 
running open relays and act accordingly.  ORBS used to maintain several lists 
so you could choose whether you wanted to receive mail from such sites.


PS  There are people on this list who have blocked some of my IP space with no 
valid reason and who took an excessive amount of time to remove the block.  
You will notice that I did not resort to using the list to discuss the 
matter.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
