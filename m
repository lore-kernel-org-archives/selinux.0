Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BDGpY6020622
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 09:16:51 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BDGmp1012073
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:16:49 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Wed, 11 Apr 2007 09:16:29 -0400
Cc: John Wan <J.Wan@mbs.edu>, selinux@tycho.nsa.gov
References: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local> <200704102246.57141.paul.moore@hp.com> <461C4EC5.7080907@manicmethod.com>
In-Reply-To: <461C4EC5.7080907@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704110916.30573.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 10 2007 10:58:13 pm Joshua Brindle wrote:
> >> I'd love to see your suggestions on solving the forwarding problem, I
> >> suppose those are forthcoming? :)
> >
> > Right now you'll have to make do with the discussion from the developer's
> > summit and my lovely emails ;)  The patches will be forthcoming but I
> > need to wrap up some loose ends on another project right now ..
>
> for some reason I don't remember a design being discussed at the summit,
> I'm probably just forgetting. This is not secpoint based right?

It was discussed but towards the end of the day in the networking discussion 
block.  See the notes that Stephen posted a while ago.

The idea is to create a new iptables "target" (probably the wrong term, but 
I'm not an iptables expert ... yet) which had an assigned label, you would 
then create iptables rules which would match certain traffic to 
that "target".  The packets which hit the "target" would have an access check 
similar to the following:

 allow <target_label> <external_packet_label> : class perm;

So it's very similar to the secpoint (or whatever it was being called) idea.  
Also, just to re-iterate this - I HAVE NO PLANS TO MERGE THE INTERNAL AND 
EXTERNAL LABELS.  The original intent is to only provide support for 
external, i.e. NetLabel and labeled IPsec, labeling mechanisms; if we decide 
to provide support for internal labeling mechanisms like SECMARK we will do 
so in parallel with additional access checks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
