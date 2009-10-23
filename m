Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9NDMDm3019944
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 09:22:14 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9NDLJc0019348
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 13:21:20 GMT
Message-ID: <4AE1AE02.6070702@manicmethod.com>
Date: Fri, 23 Oct 2009 09:22:10 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jeff Johnson <n3npq@mac.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RPM support for SELinux
References: <C7061E9C.AB85E%csellers@tresys.com> <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com> <4AE0AE8C.8000801@manicmethod.com> <41960C97-411F-4D37-9F71-9EE3AADEE8CF@mac.com>
In-Reply-To: <41960C97-411F-4D37-9F71-9EE3AADEE8CF@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeff Johnson wrote:
>
> On Oct 22, 2009, at 3:12 PM, Joshua Brindle wrote:
>
>> Jeff Johnson wrote:
>>>
>>> On Oct 22, 2009, at 2:37 PM, Chad Sellers wrote:
>>>
>>>> I just wanted to let everyone know that we've submitted a patchset
>>>> to add
>>>> more robust SELinux support to RPM4. You can view the patchset here:
>>>>
>>>> http://lists.rpm.org/pipermail/rpm-maint/2009-October/002561.html
>>>>
>>>> Note that these patches require running on the current trunk of
>>>> libselinux
>>>> and libsemanage.
>>>>
>>>> If you're interested in trying out the support or just looking at
>>>> how it
>>>> works, we've put up a wiki page talking about it here:
>>>>
>>>> http://selinuxproject.org/page/RPM
>>>>
>>>> Comments are welcome.
>>>>
>>>
>>>
>>> Just a short reply:
>>>
>>> The patches will never be included @rpm5.org as is because
>>> you missed the abstraction (for packaging) and haven't tied
>>> various stray identifiers as in
>>> Type: mls targeted
>>
>> These should never be "concrete" in RPM. These are identifiers that
>> are created on end systems and forcing a specific set of them is a
>> good way to make sure custom solutions won't use this feature in RPM.
>>
>
> The bz2 blobs need to be verifiable even if opaque.
>
> And the tagging (which you've chosen to add to *.rpm) needs
> to be verifiable as being accurate, however that is arranged.
>
> The fundamental design flaw is that you are choosing to distribute
> security sensitive policy tagging without any visible means (other than
> what
> is provided by bzip2) that the blob's are, in fact, what they are supposed
> to be.
>
> The claimed purpose of this patch set (by you) is so that rpm can be
> labeled
> as "untrusted". I haven't any problem whatsoever with RPM being labeled
> "untrusted". Just that you cannot send "trusted" data through an
> "untrusted"
> channel without any means of verification and expect anything other than
> Sh*t happens.
>

That is not the purpose of this patchset, and it was never claimed to be 
the purpose of this patchset.

The purpose of this patchset is to start integrating policy support into 
RPM, and for RPM to remain completely trusted. I did say that we have an 
ultimate goal of breaking RPM up into pieces so we could remove trust 
from the main parts, and to eventually be able to run RPM in different 
security domains depending on different aspects of the RPM (where it 
came from, who signed it, who is running RPM, etc) but that is not 
something this patch set can accomplish and indeed is a long term goal.

We can't very well go off for a long time and come back with a patchset 
that completely changes the architecture of RPM, we are doing this 
development in the open and therefore each individual patch set along 
the way brings us closer, it doesn't completely solve the problem.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
