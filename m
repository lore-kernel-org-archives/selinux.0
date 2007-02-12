Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1CGcfM0021001
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 11:38:41 -0500
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1CGdpvD003328
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 16:39:52 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1CGdpYb021723
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 11:39:51 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1CGdogu459062
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 09:39:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1CGdnq2026426
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 09:39:49 -0700
Message-ID: <45D09836.5060007@us.ibm.com>
Date: Mon, 12 Feb 2007 10:39:18 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: su and context
References: <45CDEDEE.4050205@gmail.com>
In-Reply-To: <45CDEDEE.4050205@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> Why doesn't my context change when I 'su' to a different user?

I'm pretty sure su isn't SELinux aware like newrole is -- not 
investigated the source enough to save 100%, but pretty sure.

Is there a reason why you would want it to affect your context?

DAC and MAC are not intended to be related I thought.

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
