Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QKtCFX022004
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 15:55:13 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QKuXPM021987
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 20:56:34 GMT
Message-ID: <45E3496E.8080605@redhat.com>
Date: Mon, 26 Feb 2007 15:56:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy patch for hal
References: <45DB27D7.7090604@redhat.com> <1172518334.22224.16.camel@sgc>
In-Reply-To: <1172518334.22224.16.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2007-02-20 at 11:54 -0500, Daniel J Walsh wrote:
>   
>> Hal now is changing the attributes of sound device and video devices so 
>> userswitching can happen.
>>
>> It reads and writes raw memory.
>>     
>
> This is disappointing.  With this and raw disk access, hal is basically
> unconfined.  Is there any chance we can figure out what these perms are
> tied to so they could potentially be made conditional?
>   
We are beginning to break it up, so some sub packages of hal (hal_acl) 
have different powers,  but the nature of the tool is going to give it 
lots of power.
>   
>> It has a new cache directory where it wants to store stuff.
>>
>> Needs to telinit to change runlevel.
>>
>>
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
