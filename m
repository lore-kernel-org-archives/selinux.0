Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EKSZ7C021058
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 16:28:35 -0400 (EDT)
Received: from palrel13.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EKOnJd014413
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 20:24:49 GMT
Received: from mailrelay01.cac.cpqcorp.net (mailrelay01.cac.cpqcorp.net [16.47.132.152])
	by palrel13.hp.com (Postfix) with ESMTP id D0EA51C0441E
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 13:24:49 -0700 (PDT)
Received: from anw.zk3.dec.com (alpha.zk3.dec.com [16.140.128.4])
	by mailrelay01.cac.cpqcorp.net (Postfix) with ESMTP id B49A244E
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 13:24:48 -0700 (PDT)
Message-ID: <425ED188.3020008@hp.com>
Date: Thu, 14 Apr 2005 16:24:40 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: You mentioned somewhere there is a step by step guide	to	getting
 the MLS policy installed on a machine?
References: <41EC4682.8050807@trustedcs.com>	 <41F6D30D.9070904@trustedcs.com>	 <1106771757.23386.348.camel@moss-spartans.epoch.ncsc.mil>	 <42408CAB.4030007@redhat.com>	 <1111583468.21107.15.camel@moss-spartans.epoch.ncsc.mil>	 <424175DA.9040804@redhat.com> <1111586615.21107.60.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111586615.21107.60.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-03-23 at 08:57 -0500, Daniel J Walsh wrote:
> 
>>If I follow those instructions with the Current Rawhide kernel and the 
>>soon to be released selinux-policy-mls, can I get a SELinux/MLS machine
>>up and running or do I need addtional packages from TCS?
>  
> You should be able to get a basic system working without any further
> packages (I did).  But you will need to make the home directory and /tmp
> ranged (as mentioned in README.MLS) in order to allow access by multiple
> levels since the polyinstantiated directory support is not in the
> mainline kernel, and are likely to encounter various denials when trying
> to operate at multiple levels.  For a fully operational MLS system,
> there will have to be further userspace work.
> 

I just wanted to get some clarification here as the MLS README is a 
little vague in this area - assuming I have followed all of the install 
instructions in the README file, what we be the correct label to use for 
the mountpoints (one of the last steps in the install process), 
especially the pseudo filesystems such as /proc?

Thanks,

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
