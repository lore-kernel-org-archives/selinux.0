Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8O0ueoQ029789
	for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2009 20:56:40 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8O0tsi0012115
	for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2009 00:55:55 GMT
Message-ID: <4ABAC3C3.1000100@manicmethod.com>
Date: Wed, 23 Sep 2009 20:56:35 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
References: <C6A74D22.A99BD%csellers@tresys.com> <4A830B34.60402@redhat.com> <4AB139E8.50700@manicmethod.com> <4AB13E06.7020308@manicmethod.com> <4AB15164.1020507@redhat.com>
In-Reply-To: <4AB15164.1020507@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> On 09/16/2009 03:35 PM, Joshua Brindle wrote:
>>
>> Joshua Brindle wrote:
>>>
>>> Daniel J Walsh wrote:
>>>> What do you think of this one. Removed excess swig cruft,
>>>>
>>>> You need to run
>>>>
>>>> make swigify to generate those changes.
>>>>
>>> Ok, looking at this now. I don't completely get how it works. I'm trying
>>> to reproduce what you are doing by hand but nothing comes out of gcc:
>>>
>>> [root@localhost src]# echo '#include "../include/selinux/selinux.h"'>
>>> temp.c
>>> [root@localhost src]# gcc -c temp.c -aux-info temp.aux
>>> [root@localhost src]# ls temp.*
>>> temp.c temp.o
>>>
>>>

I got this "sort of" working locally. It works when I call it directly 
on the header but it leaves a .gch file sitting in the include directory.

Trying to use stdin I get:

[root@localhost src]# gcc -x c-header -c - -aux-info temp.aux < 
../include/selinux/selinux.h
<stdin>:569: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <http://bugzilla.redhat.com/bugzilla> for instructions.


Other comments:

The disconnect between swigify and clean targets remains: If make 
swigify builds this, and it is checked in to the tree then make clean 
shouldn't remove it, else it should be in the pywrap target and not 
installed.

I'm not sure what the header re-ordering in selinuxswig.i and the 
copytree/install functions have to do with this patch.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
