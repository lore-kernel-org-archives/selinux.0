Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA05110
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 05:53:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA07924
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:53:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA07920
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:53:02 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AAFC692461
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 19:53:15 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 54B5F18B
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 11:53:01 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: IGMP being blocked
Date: Thu, 13 Jun 2002 11:53:00 +0200
MIME-Version: 1.0
Message-Id: <20020613095301.54B5F18B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { rawip_send } for  saddr=213.84.71.248 daddr=224.0.1.41 
netif=ppp0 scontext=system_u:object_r:unlabeled_t 
tcontext=system_u:object_r:netif_t tclass=netif

avc:  denied  { rawip_send } for  saddr=213.84.71.248 daddr=224.0.1.41 
netif=ppp0 scontext=system_u:object_r:unlabeled_t 
tcontext=system_u:object_r:node_t tclass=node

I am seeing the above in my logs regularly on a server that I have just 
upgraded to the latest LSM with IPSec (which I have not enabled).

It seems that IGMP code is being run as unlabeled_t.

Any ideas on what to do with this?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
