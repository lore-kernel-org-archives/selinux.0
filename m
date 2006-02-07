Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k17DXqXf022650
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 08:33:52 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k17DWXxN020613
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 13:32:33 GMT
Message-ID: <43E8A1C8.9020407@redhat.com>
Date: Tue, 07 Feb 2006 08:34:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: MCS policy patch
References: <200602040118.10784.russell@coker.com.au> <1139267067.13925.27.camel@sgc> <200602071419.13087.russell@coker.com.au> <200602072259.16871.russell@coker.com.au>
In-Reply-To: <200602072259.16871.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> My previous message was unclear.
>
> On Tuesday 07 February 2006 14:19, Russell Coker <russell@coker.com.au> wrote:
>   
>>> We can't have these hardcoded types.  What we need is similar to how the
>>> mls constraints are handled.  Attributes and interfaces need to be added
>>> to the mls module, then the above domains would use the interfaces to
>>> gain these attributes.
>>>       
>> Actually I never planned to have it like that.  But the lack of support for
>> range transition statements outside the base module prevents me from doing
>> what I want.
>>     
>
> What I want to do is to have the init scripts run at SystemHigh and have a 
> range transition for every daemon that doesn't need such access (most 
> daemons), doing this without range_transition in all modules would be a gross 
> hack.  Also I am considering having some daemons such as Postfix run with 
> some processes at SystemHigh and some at s0.
>
> Another thing, I think that a default user login should not have SystemHigh, 
> maybe s0:c0.c127.  The reason is that the administrator will add accounts, 
> have a running system with files labelled on disk and in backup storage, and 
> THEN they will decide that they want one particular account to have more 
> access than the default.  This will be a major PITA if every account already 
> has all the categories.  If we make the default level be s0:c0.c127 then that 
> still gives plenty of levels to choose from (it shouldn't restrict real use 
> of the system) and it allows adding new users with more access than the 
> default.
>
> This one only just occurred to me, but it's something that I think is quite 
> important to be in FC5T3 to avoid the current situation propagating too far.
>
>   
Default users login with s0.  They have no categories.  This information 
is gathered  via the seusers interface.
If the admin wants to give a user access to categories he will need to 
use semanage to give this access.

By default all processes should run at s0, currently we have no way to 
change this level that a daemon will run at.
Correct?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
