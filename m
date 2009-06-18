Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5IKFPOE026381
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 16:15:25 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5IKFDpe007107
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 20:15:14 GMT
Message-ID: <4A3AA03E.4010208@manicmethod.com>
Date: Thu, 18 Jun 2009 16:14:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch add seusers support to SELinux
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com> <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com>
In-Reply-To: <4A3A97B0.6030407@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 06/18/2009 09:48 AM, Joshua Brindle wrote:
>> Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> The idea here is to break the seusers file up into lots of little
>>>> seusers file that can be user specific, also adds the service field to
>>>> be used by tools like pam_selinux to choose which is the correct
>>>> context
>>>> to log a user in as.
>>>>
>>>> Patch was added to facilitate IPA handing out SELinux content for
>>>> selection of roles at login.
>>>>
>>>
>>> This patch does not affect the behavior of getseuserbyname(), how is
>>> this expected to work with existing applications?
>>>
> I think it only affects pam_selinux.

The function name is very confusing if its only used for pam_selinux, I'd like 
it renamed but seeing that pam_selinux is already deployed with it I suppose 
that isn't an option.

Signed-off-by: Joshua Brindle <method@manicmethod.com>

>>
>> Also, what is the format of this file? What should service be to test
>> this on F11?
>>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
