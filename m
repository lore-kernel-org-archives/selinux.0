Message-ID: <413331AD.1080709@redhat.com>
Date: Mon, 30 Aug 2004 09:54:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest Diffs.
References: <412CAE6B.30006@redhat.com> <200408282246.20447.russell@coker.com.au>
In-Reply-To: <200408282246.20447.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thu, 26 Aug 2004 01:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>We now have named booleans working with named master updates.
>>
>>Added can_ypbind to lots of te files to support NIS environments.
>>    
>>
>
>If we are going to add can_ypbind() to every daemon domain then why not put it 
>in daemon_core_rules()?
>
>We don't want to have duplicate policy in all .te files, that makes it harder 
>to read and analyse, increases errors (both omitting needed access and 
>permitting unwanted access).
>
>  
>
I originally argued that can_ypbind should be part of can_network and 
should continue to be.
You have a boolean to turn off the ypbind, but if you run a network 
application on a ypbind served
machine you will hit many avc message about NIS.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
