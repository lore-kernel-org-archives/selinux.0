Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92FKVmg013580
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 11:20:32 -0400
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92FJMgt018674
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 15:19:22 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k92FKV16020768
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 11:20:31 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k92FKTRn129530
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 11:20:31 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k92FKSsF005500
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 11:20:29 -0400
Message-ID: <45212E39.9080105@us.ibm.com>
Date: Mon, 02 Oct 2006 10:20:25 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Default Mikefile in /usr/share/selinux/devel not nice
References: <451D8C2F.9040901@us.ibm.com> <1159590751.12161.10.camel@gorn.pebenito.net>
In-Reply-To: <1159590751.12161.10.camel@gorn.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito wrote:
> On Fri, 2006-09-29 at 16:12 -0500, Michael C Thompson wrote:
>> I just discovered a nasty surprise waiting for me in the default 
>> Makefile provided by selinux-policy-devel.
>>
>> Basically, the Makefile produces, on an MLS system, a TYPE value of 
>> mls-msc (this is due to the SELINUXTYPE=mls line in 
>> /etc/selinux/config). This will not 'enable_mls' for the M4FLAGS, 
>> because the Makefile in /usr/share/selinux/devel/include/ does a 
>> findstring for '-mls'.
>>
>> Dan Walsh has suggested a fix for the default Makefile, but I'm 
>> wondering why we can't just change 
>> /usr/share/selinux/devel/include/Makefile to do a $(findstring 
>> mls,$TYPE)) instead, since its not unreasonable to think that TYPE=mls 
>> makes sense.
> 
> There is some confusion here, the SELINUXTYPE is not the same as TYPE in
> refpolicy, it is NAME in refpolicy.  The TYPE of the Redhat MLS policy
> is strict-mls.  TYPE=mls does not make sense, since it does not specify
> if the policy is strict or targeted.

Are there flags (like 'enable_mls') in the policy which require this 
delineation?

Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
