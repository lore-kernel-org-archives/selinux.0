Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4SN0GrT011694
	for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 19:00:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4SN0Fo9024476
	for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 23:00:16 GMT
Received: from lakemtao01.cox.net (lakemtao01.cox.net [68.1.17.244])
        by jazzband.ncsc.mil  with ESMTP id i4SN0EIp024470 for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 23:00:15 GMT
Message-ID: <40B67F41.6020309@snu.edu>
Date: Thu, 27 May 2004 18:52:33 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: "Dr. Eugene D. Myers" <edm@tycho.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil>
In-Reply-To: <BCDBA110.10B6A%edm@tycho.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> In NetTop, each virtual machine is assigned a specific type (for example,
> vm1_d) and the files that contain the virtual disks are assigned a different
> type (for example, vm1_t).  Each virtual machine type vmX_d (where X is an
> arbitrary number) can only access files (virtual disks) of type vmX_t.
> 
> The restriction means that each virtual machine can only access only its
> virtual disks.

on the slide entitled seperation it says that ACL's are used to protect 
the disk files so that rogue apps in a vm can't affect other vm's, 
additionally each vm's disk file is encrypted so that only the 'level' 
user can access it.

Obviously both of these things can be done with (SE)Linux but it appears 
  they thought about this already.

Joshua

> 
> In NetTop, the SELinux policy is written such that -->Only<-- only a VM can
> access a virtual disk and only its associated virtual disk.  No other
> process (including other VM's) have permission to access a VM's virtual
> disk.  This includes processes that execute with root permission.
> 
> This is a significant point.  In systems, where data separation is
> important, being able to show that data cannot flow (in this case from one
> VM to another, which can happen if a VM gains access to another VM's virtual
> disk) is an important property of a mandatory policy.  In the NetTop policy,
> the VMware virtual machines are isolated from the rest of the system and
> data flows into and out of a virtual machine, only if the policy allows it.
> 
> 
>>another hint is that they are focussing on network access so
>>presumably that means writing a special / modified VMware network
>>driver.
>>
>>
>>... anyway, what's this got to do with SE/Linux? :)
>>
>>no.
>>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
