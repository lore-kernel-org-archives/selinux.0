Message-ID: <43E8E3C1.20204@redhat.com>
Date: Tue, 07 Feb 2006 13:15:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Chad Hanson <chanson@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add seuser and user_extra to package format
References: <43E7D03D.4090909@tresys.com>  <43E80E52.6090503@cornell.edu> <1139322866.2872.44.camel@moss-spartans.epoch.ncsc.mil> <43E8DE4F.1040203@tresys.com>
In-Reply-To: <43E8DE4F.1040203@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Mon, 2006-02-06 at 22:04 -0500, Ivan Gyurdiev wrote:
>>> Please try with the following patch on top:
>>>
>>> - removes system databases, which are unnecessary, write directly to 
>>> the final file
>>> - fix 64-bit bugs Joshua's introducing :)
>>
>> Merged both patches.
>>
>>> I will resync my nodecon patch tomorrow - let me know if anything's 
>>> wrong with it, otherwise will submit as is (ordering pending in a 
>>> later patch).
>>
>> I still wasn't clear on the disposition of the pylist patch.
>
> IMO we should leave the semanageswig.i as the language neutral 
> interface file (and not remove the _by_idx functions) and make 
> language specific files include it. Then all the common parts are in 
> semanageswig.i and python specific ones are in another file. That way 
> we are free to use better features for python without eliminating the 
> possibility of building the wrappers for another language and it 
> shouldn't make maintenance any harder.
>
>
>
>
>>
>> For the nodecon patch, I wasn't sure if we were sufficiently confident
>> in the ABI/API stability to include it for FC5 or if it should wait on
>> FC6 devel.  It would likely help to have feedback from potential users
>> of the nodecon API.
>>
>
I agree.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
