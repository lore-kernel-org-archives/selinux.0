From: Paul Moore <paul.moore@hp.com>
To: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: MCS and default labels
Date: Wed, 30 Sep 2009 09:19:35 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, russell@coker.com.au,
        Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <200909291654.07458.paul.moore@hp.com> <f73f7ab80909292051m7f591868lbd86e5e948cdcd8a@mail.gmail.com>
In-Reply-To: <f73f7ab80909292051m7f591868lbd86e5e948cdcd8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200909300919.35275.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 September 2009 11:51:42 pm Kyle Moffett wrote:
> Basically, my end goal is to be able to have a network of Linux boxes
> (with the network itself being "s4", for example) and *guarantee*
> that:

Thanks for the clarification; I'm pretty sure we can get something working.
 
>  (A)  Any unlabelled data coming in off the network is treated by SELinux
>  is s4

You can either provide special handling for this in your application(s) or you 
can configure the kernel to return a static label for unlabeled traffic.  
Personally I think it would be easier to just configure the kernel to do it 
for you, but if you have a custom app, maybe not ...

 * http://paulmoore.livejournal.com/1758.html

>  (B)  No processes are allowed to communicate out the network
> unprotected unless they are exactly s4

It should be possible to configure the SPD and write policy such that the "no 
IPsec" SPD rule only matches traffic from "s4" labeled sockets, then all you 
need to do is add a catch-all SPD rule to wrap with ESP/AH (or drop) all 
traffic not explicitly specified in the SPD.

I haven't tried this personally, but I don't see any reason why it wouldn't 
work (and I would consider it a bug if it didn't).

>  (C)  Processes which are *not* s4 may communicate over the network
> only when protected by IPsec, and only if the IPsec connection is
> specifically negotiated using certificates/keys based on the level of
> the data being protected.

I think the tricky part here is the "... certificates/keys based on the level 
of the data ..." statement.  Is is sufficient to have one certificate per 
host/node as long as you have one SA per label?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
