Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61JKpX4013392
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 15:20:52 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n61JKZlM017095
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 19:20:35 GMT
Message-ID: <4A4BB6D9.6000805@manicmethod.com>
Date: Wed, 01 Jul 2009 15:19:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Christopher Pardy <cpardy@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
References: <4A4B656D.1030004@redhat.com> <4A4B874E.8020402@redhat.com>
In-Reply-To: <4A4B874E.8020402@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 07/01/2009 09:32 AM, Christopher Pardy wrote:
>> Creates a empty file disable_dontaudit in the polciy directory
>> (/etc/selinux/<policytype>). Checks for the existance of this file to
>> set the sepol disable don't audit upon handle creation. Also provides
>> the function "int semanage_get_disable_dontaudit()" which returns the
>> don't audit property of the current policy.
>>
>> Signed-off-by: Christopher Pardy <cpardy@redhat.com>
>
> Better version of patch.

Inline preferred.

Anyway, if this is going to be set by tools and not people it should be in the 
module store, not the root of the selinux config directory.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
