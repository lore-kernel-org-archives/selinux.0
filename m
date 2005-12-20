Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBKMlvXf010773
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2005 17:48:01 -0500 (EST)
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBKMlsul008348
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2005 22:47:55 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBKMilaR029472
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2005 17:44:47 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBKMhmfc118796
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2005 15:43:48 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBKMilOF013550
	for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2005 15:44:47 -0700
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: Adding audit messge to newrole
Date: Tue, 20 Dec 2005 16:39:17 -0600
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
In-Reply-To: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200512201639.18074.tinytim@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 20 December 2005 16:14, Steve G wrote:
> Hi,
> 
> I am attaching a patch that lets newrole send messages to the audit system. This
> patch needs review as it changes newrole to be setuid root. The patch drops
> capabilities very soon after startup. 

I'm lazy and would prefer something inline.  Oh and the patch seems to be empty... hrm.

-tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
