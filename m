Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05678
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 08:24:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA13736
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 12:23:51 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id MAA13732
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 12:23:50 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: IGMP being blocked
Date: Thu, 13 Jun 2002 08:23:50 -0400
Message-ID: <000b01c212d5$2cf08750$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020613095301.54B5F18B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Yes this LOOKS like multicast addresses.  You can disable them by either
turning that feature off or adding a few lines of code

"$IPTABLES" -A INPUT -d 224.0.0.0/4 -J DROP

Would be interesting to see the log that iptables give in this case (to
further know what's going on here)

Ed

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Russell Coker
> Sent: Thursday, June 13, 2002 5:53 AM
> To: SE Linux
> Subject: IGMP being blocked
> 
> 
> avc:  denied  { rawip_send } for  saddr=213.84.71.248 
> daddr=224.0.1.41 
> netif=ppp0 scontext=system_u:object_r:unlabeled_t 
> tcontext=system_u:object_r:netif_t tclass=netif
> 
> avc:  denied  { rawip_send } for  saddr=213.84.71.248 
> daddr=224.0.1.41 
> netif=ppp0 scontext=system_u:object_r:unlabeled_t 
> tcontext=system_u:object_r:node_t tclass=node
> 
> I am seeing the above in my logs regularly on a server that I 
> have just 
> upgraded to the latest LSM with IPSec (which I have not enabled).
> 
> It seems that IGMP code is being run as unlabeled_t.
> 
> Any ideas on what to do with this?
> 
> -- 
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in 
> your address-book so that WHEN you get a virus it won't use 
> my address in the
> >From field.
> 
> --
> You have received this message because you are subscribed to 
> the selinux list. If you no longer wish to subscribe, send 
> mail to majordomo@tycho.nsa.gov with the words "unsubscribe 
> selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
