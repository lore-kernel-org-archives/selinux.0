Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m990S9nF011097
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 20:28:09 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m990S97F017396
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 00:28:09 GMT
Message-ID: <48ED4FBC.4020303@redhat.com>
Date: Thu, 09 Oct 2008 10:26:36 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: Glenn Faden <Glenn.Faden@sun.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Maintaining SELinux Labels
References: <737og9$5vh3i@dmzms99902.na.baesystems.com>
In-Reply-To: <737og9$5vh3i@dmzms99902.na.baesystems.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> 
>> -----Original Message-----
>> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On
>> Behalf Of Glenn Faden
>> Sent: Wednesday, October 08, 2008 8:46 AM
>> To: Daniel J Walsh
>> Cc: Murray McAllister; SE Linux
>> Subject: Re: user guide drafts: Maintaining SELinux Labels
>>
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Murray McAllister wrote:
>>>
>>>> Hi,
>>>>
>>>> The following are the first few drafts of the "Maintaining SELinux
>>>> Labels" sections. Any comments and corrections are appreciated.
>>>>
>>>> Cheers.
>>>>
>>>> Copying Files and Directories
>>>>
>>>> When files and directories are copied, they inherit the SELinux
> context
>>>> of the parent directory they are copied to. This helps ensure files
> and
>>>> directories are labeled with the correct SELinux context after
> being
>>>> moved. The following example demonstrates copying a file from a
> user's
>>>> home directory to /var/www/html/, which is used by the Apache HTTP
>>>> Server. Since the file is copied, it inherits the correct SELinux
>> context:
>> Is this true when using MLS policy? Assuming the policy allows a
> subject
>> to create a file in a directory, shouldn't the newly created file's
>> SELinux context have the same sensitivity as the subject who wrote it?
> 
>> Or is the new file's type copied from the directory and the
> sensitivity
>> copied from the subject?
> 
> You are correct, the type is copied from the directory and the level is
> copied from the subject. It might also be worth mentioning that the type
> is copied from the directory as default behavior, which can be
> overridden with type_transition statements.
> 
>> --Glenn
I've changed the first paragraph. How about:

When files and directories are copied, they inherit the SELinux context 
of the parent directory they are copied to[1]. This helps ensure files 
and directories are labeled with the correct SELinux context after being 
copied. Also, when a file is copied over an existing file, the existing 
file's context is maintained. On systems running the MLS policy, when 
files are copied, they inherit the type from the parent directory they 
are being copied to, and the level from the process that copied them.

Is the last sentence, is "the level from the process that copied them" 
correct? Should it be "from the process or user that..."?

[1] By default, the type is copied from the parent directory. This 
behavior can be overridden by using type_transition statements in custom 
SELinux policies.

I've included an example at the end of the section to show copying a 
file over an existing one.

Thanks for your feedback.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
