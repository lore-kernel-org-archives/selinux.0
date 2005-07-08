Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j68ERhgA021570
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 10:27:43 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j68EPJGt002547
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 14:25:20 GMT
Message-ID: <42CE8CCF.6000508@redhat.com>
Date: Fri, 08 Jul 2005 10:25:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: crond_t
References: <200507090004.57794.russell@coker.com.au>
In-Reply-To: <200507090004.57794.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>It seems that the domain crond_t needs the attribute privfd.  The number of 
>things that are run from cron jobs demands it.  A user of the rawhide policy 
>reported a problem running ping from a cron job on IRC.
>
>  
>
crond_t has privfd.

Are you talking about system_crond_t and friends?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
