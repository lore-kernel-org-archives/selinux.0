Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9MJhwPN000495
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 15:43:58 -0400
Received: from asmtpout026.mac.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9MJh3xY018004
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 19:43:03 GMT
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Received: from falmouth.jbj.org
 (cpe-069-134-024-120.nc.res.rr.com [69.134.24.120])
 by asmtp026.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KRX008INLG72A40@asmtp026.mac.com> for
 selinux@tycho.nsa.gov; Thu, 22 Oct 2009 12:43:21 -0700 (PDT)
Subject: Re: RPM support for SELinux
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <4AE0AE8C.8000801@manicmethod.com>
Date: Thu, 22 Oct 2009 15:43:18 -0400
Cc: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <41960C97-411F-4D37-9F71-9EE3AADEE8CF@mac.com>
References: <C7061E9C.AB85E%csellers@tresys.com>
 <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com>
 <4AE0AE8C.8000801@manicmethod.com>
To: Joshua Brindle <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 22, 2009, at 3:12 PM, Joshua Brindle wrote:

> Jeff Johnson wrote:
>>
>> On Oct 22, 2009, at 2:37 PM, Chad Sellers wrote:
>>
>>> I just wanted to let everyone know that we've submitted a patchset  
>>> to add
>>> more robust SELinux support to RPM4. You can view the patchset here:
>>>
>>> http://lists.rpm.org/pipermail/rpm-maint/2009-October/002561.html
>>>
>>> Note that these patches require running on the current trunk of
>>> libselinux
>>> and libsemanage.
>>>
>>> If you're interested in trying out the support or just looking at  
>>> how it
>>> works, we've put up a wiki page talking about it here:
>>>
>>> http://selinuxproject.org/page/RPM
>>>
>>> Comments are welcome.
>>>
>>
>>
>> Just a short reply:
>>
>> The patches will never be included @rpm5.org as is because
>> you missed the abstraction (for packaging) and haven't tied
>> various stray identifiers as in
>> Type: mls targeted
>
> These should never be "concrete" in RPM. These are identifiers that  
> are created on end systems and forcing a specific set of them is a  
> good way to make sure custom solutions won't use this feature in RPM.
>

The bz2 blobs need to be verifiable even if opaque.

And the tagging (which you've chosen to add to *.rpm) needs
to be verifiable as being accurate, however that is arranged.

The fundamental design flaw is that you are choosing to distribute
security sensitive policy tagging without any visible means (other  
than what
is provided by bzip2) that the blob's are, in fact, what they are  
supposed
to be.

The claimed purpose of this patch set (by you) is so that rpm can be  
labeled
as "untrusted". I haven't any problem whatsoever with RPM being labeled
"untrusted". Just that you cannot send "trusted" data through an  
"untrusted"
channel without any means of verification and expect anything other than
	Sh*t happens.

>> to anything concrete.
>>
>> There are other and deeper flaws within the highly unnormalized data
>> within the *.bz2 policy blobs.
>>
>
> Well, you can normalize the data if you want but chances are the  
> format will be changing from the current binary blob to a text file  
> parseable only by high level compilers on the end systems in the  
> near future.
>

So change the format. I can only see what patches you've posted.
If the flaws are "fixed in the next release", well, I'll patiently  
wait for
"the next release". What I see in the current patch set is mis- 
designed and just
plain wrong.

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
