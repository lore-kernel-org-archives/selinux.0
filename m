Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82FNerT000016
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:23:40 -0400 (EDT)
Message-ID: <41373AEE.1040206@redhat.com>
Date: Thu, 02 Sep 2004 11:23:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest Patches
References: <200408241818.40064.russell@coker.com.au>	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>	 <200408282346.05926.russell@coker.com.au>	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>	 <41371628.2020408@redhat.com> <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-09-02 at 08:46, Daniel J Walsh wrote:
>  
>
>>Include some stuff from Russell,
>>Critical patch for tmpfs to get udev on tmpfs working
>>    
>>
>
>You can't change fs_use in that manner; it will break the kernel's
>internal usage of tmpfs for shared memory.  The situation is similar to
>devpts; fs_use_trans will govern the initial setting of the inode
>context, then programs can explicitly set and get the context.  
>
>________________________________________________________________________
>  
>
We get a discretionary Access control error "Permission Denied" message 
on on a restorecon /dev without making this change
on bootup.  Everything seemed to be working ok Well at least to the 
point of booting the machine and logging in.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
