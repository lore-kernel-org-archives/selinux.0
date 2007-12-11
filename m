Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBKNjgv009905
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 15:23:45 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBBKNjEe001511
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 20:23:45 GMT
Subject: Re: Network flow controls and subj/obj ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200712111202.20074.paul.moore@hp.com>
References: <200712111202.20074.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 15:23:22 -0500
Message-Id: <1197404602.12626.185.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-11 at 12:02 -0500, Paul Moore wrote:
> After a discussion with Venkat last week we decided that it was probably best 
> if I took responsibility for the flow control patches and ported/cleaned them 
> up for inclusion in the labeled networking patches for 2.6.25.  In the course 
> of doing so I ran across the problem of subject/object "ordering" (probably 
> not the best term, but it's all I can think of right now).  In both the "flow 
> in" and "flow out" cases I'm tempted to use the packet's peer label as the 
> object just for the sake of consistency and the ability to use the new "peer" 
> object class for all network peer label access checks.  However, I wanted to 
> make sure that is what everyone had in mind from a conceptual point of view.  
> See the two simple policy examples below:
> 
>  * Packet "flows" into the system, peer label is the object
> 
>    allow netif_t peerlbl_t:peer flow_in;
> 
>  * Packet "flows" out of the system, peer label is the object
> 
>    allow netif_t peerlbl_t:peer flow_out;

Can you give an example for the forwarding case?  Also, how about in the
non-labeled networking case?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
