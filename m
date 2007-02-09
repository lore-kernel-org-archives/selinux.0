Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19JBj9F003280
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 14:11:45 -0500
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l19JCs8v017866
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 19:12:54 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l19JCs5J012301
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 14:12:54 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l19JCneV472874
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 12:12:53 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l19JCn8a015499
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 12:12:49 -0700
Message-ID: <45CCC7B0.6080109@us.ibm.com>
Date: Fri, 09 Feb 2007 13:12:48 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Greger <boss@gregerhaga.net>
CC: selinux@tycho.nsa.gov
Subject: Re: how to enable se linux for my app?
References: <20070209185428.M24608@gregerhaga.net>
In-Reply-To: <20070209185428.M24608@gregerhaga.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greger wrote:
> well just a quickie:
> I wrote an application, but can not run the linux executable nor libraries
> when selinux is activated. what command should i use to "include" the
> libraries and executable under selinux?

Its most likely a type enforcement issue. Your application need not be 
"SELinux aware" for it to execute at all. However, it must be labeled 
appropriately in the file system, with a type that is executable (e.g. 
bin_t). Common library types are lib_t and shlib_t.

What policy are you using (strict/targeted/custom)?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
