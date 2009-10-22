Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9MJCGS6029541
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 15:12:16 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9MJBKxY005872
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 19:11:21 GMT
Message-ID: <4AE0AE8C.8000801@manicmethod.com>
Date: Thu, 22 Oct 2009 15:12:12 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jeff Johnson <n3npq@mac.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RPM support for SELinux
References: <C7061E9C.AB85E%csellers@tresys.com> <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com>
In-Reply-To: <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeff Johnson wrote:
>
> On Oct 22, 2009, at 2:37 PM, Chad Sellers wrote:
>
>> I just wanted to let everyone know that we've submitted a patchset to add
>> more robust SELinux support to RPM4. You can view the patchset here:
>>
>> http://lists.rpm.org/pipermail/rpm-maint/2009-October/002561.html
>>
>> Note that these patches require running on the current trunk of
>> libselinux
>> and libsemanage.
>>
>> If you're interested in trying out the support or just looking at how it
>> works, we've put up a wiki page talking about it here:
>>
>> http://selinuxproject.org/page/RPM
>>
>> Comments are welcome.
>>
>
>
> Just a short reply:
>
> The patches will never be included @rpm5.org as is because
> you missed the abstraction (for packaging) and haven't tied
> various stray identifiers as in
> Type: mls targeted

These should never be "concrete" in RPM. These are identifiers that are 
created on end systems and forcing a specific set of them is a good way 
to make sure custom solutions won't use this feature in RPM.

> to anything concrete.
>
> There are other and deeper flaws within the highly unnormalized data
> within the *.bz2 policy blobs.
>

Well, you can normalize the data if you want but chances are the format 
will be changing from the current binary blob to a text file parseable 
only by high level compilers on the end systems in the near future.

> Equivalent functionality will be done @rpm5.org instead.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
