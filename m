Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALENL9014567
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:14:23 -0500 (EST)
Message-ID: <420BCE5D.9040408@redhat.com>
Date: Thu, 10 Feb 2005 16:13:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: some policy patches
References: <200502032350.40924.russell@coker.com.au> <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Merged.  
>
>Except that a chunk in ssh.te and login.te reverted Dan's removal of
>ifdef(`automount.te' statements.  Was there a reason for this?
>
>On Thu, 2005-02-03 at 07:50, Russell Coker wrote:
>  
>
>>Nothing really exciting in this patch.  Just some minor fixes and sorting out 
>>some of the distro-specific stuff.
>>    
>>
automount.te statements break targeted policy and autofs is defined 
outside of automount.te so they should not be there.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
