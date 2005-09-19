Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JNquNs023986
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 19:52:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JNmweY022654
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 23:48:59 GMT
Message-ID: <432F4F08.3080601@redhat.com>
Date: Mon, 19 Sep 2005 19:51:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: misc policy patches
References: <200509192101.04722.russell@coker.com.au> <432F1834.8080809@redhat.com> <200509200629.25197.russell@coker.com.au>
In-Reply-To: <200509200629.25197.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Tuesday 20 September 2005 05:57, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Russell Coker wrote:
>>    
>>
>>>The attached patch has a bunch of small changes that are fairly obvious
>>>(and the less obvious ones have comments).
>>>      
>>>
>>What is this for?
>>+allow mount_t named_conf_t:dir mounton;
>>    
>>
>
>This is for a chroot environment for BIND where an init script mounts /proc 
>inside the chroot.  The mount point gets labeled named_conf_t.
>
>Another possible solution to this is to have the mount point labeled as 
><<none>> (although we would still have problems with machines that already 
>have the mount point labeled).
>
>  
>
We have a mount_point attribute that would probably be better.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
