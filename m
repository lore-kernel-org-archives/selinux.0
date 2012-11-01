Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA1Fwuav031370
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2012 11:58:56 -0400
Received: by mail-vb0-f53.google.com with SMTP id fc21so3260800vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Nov 2012 08:58:48 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Question about SELinux capability
Date: Thu, 01 Nov 2012 11:58:45 -0400
Message-ID: <3608707.WxASRDOVXr@sifl>
In-Reply-To: <CCB68FF3.23EA%thomas.moyer@ll.mit.edu>
References: <CCB68FF3.23EA%thomas.moyer@ll.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, October 31, 2012 08:24:21 AM Moyer, Thomas - 0668 - MITLL wrote:
> Yes. That is correct. What I am looking at though is a piece of hardware
> that does not use IP (or TCP and UDP for that matter). Instead, they
> implement their own protocol at the IP layer. So any traffic coming from
> the hardware (to the system that I am writing policy for) and any traffic
> being sent to that machine uses a raw socket to communicate (no IP at
> all). I briefly looked at ebtables, but it doesn't appear to have the same
> type of SECMARK support that I would use with iptables.

I think I misunderstood your original question; I thought you were interested 
in labeling the ethernet frames on the wire while it sounds like you are only 
interested in assigning labels to the network traffic once it has been 
received by the system - yes?

> I think the best solution that I have come up with is to label the network
> interface used to communicate with the hardware, and then only allow the
> domain being confined to create sockets and bind to that interface.

I assume you are talking about the ingress/egress controls?

If so, a word of caution, they *may* not catch non-IP traffic due to they way 
they are hooked into the network stack.  I'd be interested in hearing what 
happens in your case.

> >On Friday, October 26, 2012 04:08:15 PM Moyer, Thomas - 0668 - MITLL
> >
> >wrote:
> >> I am working with a piece of embedded hardware that uses raw ethernet
> >> frames to communicate with another (standard PC). Is it possible to apply
> >> SELinux labels to those ethernet frames like you can with IP packets
> >> using iptables and SECMARK?
> >
> >The secmark/iptables labels never leave the local system, they are
> >maintained only within the kernel and do not travel out over the wire.  If
> >you are interested in communicating security label over the network your
> >only options at present require an IP header at the very least.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
