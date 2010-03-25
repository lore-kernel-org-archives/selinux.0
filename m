Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2PG05PG014577
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 12:00:06 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2PG0W9q008457
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 16:00:33 GMT
Message-ID: <4BAB8874.3070206@redhat.com>
Date: Thu, 25 Mar 2010 11:59:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: These two patches allow restorecond to use same code as setfiles/restorecon.
References: <4B9A81E9.2000409@redhat.com> <1269532288.2750.1.camel@defiant>
In-Reply-To: <1269532288.2750.1.camel@defiant>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/25/2010 11:51 AM, Chris PeBenito wrote:
> On Fri, 2010-03-12 at 13:03 -0500, Daniel J Walsh wrote:
>    
>> First patch rearranges setfiles code separating out shared code into a
>> new c program called restore.c
>> This program will be linked against restorecond and setfiles.
>>
>> Second patch changes restorecond to use the separated out code and also
>> Allows restorecond to run as a user process, rather then as a system
>> service.  So it can run within the user session watching for file
>> creations in the homedir.
>>      
> Can it still run as a system process after this patch?
>
>    
Yes.

restorecond -u versus restorcond.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
