Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAJNkuuP011963
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 18:46:56 -0500
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAJNkD5T019129
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 23:46:13 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAJNl8EU010326
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 18:47:08 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAJNl8de329094
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 16:47:08 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAJNl7ct022515
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 16:47:07 -0700
Message-ID: <4560ECEE.5080500@us.ibm.com>
Date: Sun, 19 Nov 2006 17:46:54 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Mohammad Mahmoudi <mahmoudi1379@yahoo.com>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux meets lspp requirements
References: <20061118125240.28786.qmail@web50405.mail.yahoo.com>
In-Reply-To: <20061118125240.28786.qmail@web50405.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mohammad Mahmoudi wrote:
> Dear
> 
> Does SELinux meets LSPP requirements? if doesn't all,
> what requirements SELinux doesn't meet currently?

There is SELinux policy currently under develop that does meet LSPP 
requirements. If you are interested, there is an LSPP-specific mailing 
list hosted by Red Hat.

https://www.redhat.com/mailman/listinfo/redhat-lspp

In terms of SELinux policy, the MLS (Multi-Level Security) policy is 
aimed at meeting the requirements of LSPP.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
