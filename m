Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78HQiZo018125
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 13:26:44 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m78HQZvJ024966
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 17:26:35 GMT
Message-ID: <489C81D3.6080605@manicmethod.com>
Date: Fri, 08 Aug 2008 13:26:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Matt Anderson <mra@hp.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux policy and performance impacts
References: <489B81A4.9050007@hp.com> <alpine.LRH.1.10.0808080955290.22387@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808080955290.22387@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 7 Aug 2008, Matt Anderson wrote:
> 
>> I'm currently looking into the performance impact of SELinux.  Most of what I
>> have seen so far involve testing the system's performance with file creation,
>> open, and exec, but I was hoping to gather some more data before finalizing
>> any conclusions.
>>
>> I was wondering if anyone knows of any types of policy rules that when loaded
>> into the kernel are particularly detrimental to system performance.  My
>> understanding is that all policy rules are treated equally once they've been
>> compiled to binary, but I wanted to ask here first in order to confirm that.
> 
> Yes, all access rules are applied in a standard form with decisions cached 
> in the AVC.  There were some network permissions which had to do a full 
> policydb lookup on each packet to determine the label to use, but these 
> are also now cached (although will still incur some overhead).
> 

When the SS originally makes the decision (before its been cached) there is additional overhead on rules and types using attributes. Because of the avtab compression from version 20 the source and target types will be looked up in a reverse mapping to attribute, then each attribute will be looked up in the avtab to get the net access vector. More attributes (within reason) means less memory usage and more lookup overhead. For tests that repeat the same kinds of accesses over and over this overhead should be reduced to nothing by the AVC, however.

> Auditing will introduce overhead (not all accesses are audited).
> 
> Probably the best place to start to understand how this works is to look 
> at avc_has_perm() in the kernel code, and also look at /selinux/avc .
> 
> I suspect the largest overhead will be in the hook logic for various
> operations (e.g. look at the size of inode_doinit_with_dentry()) rather 
> than the AVC lookup.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
