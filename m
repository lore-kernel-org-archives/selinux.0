Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GGr8rT026369
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 12:53:08 -0400 (EDT)
Message-ID: <4149C4DD.9040802@redhat.com>
Date: Thu, 16 Sep 2004 12:52:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: hald fix
References: <200409162151.44819.russell@coker.com.au> <1095342276.30684.96.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1095342276.30684.96.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-09-16 at 07:51, Russell Coker wrote:
>  
>
>>The attached patch fixes a typo to make hald work with dbus and removes an 
>>unnecessary can_exec_any().
>>    
>>
>
>Are all helpers executed by hald now labeled with hald_exec_t?
>
>  
>
I don't think so.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
