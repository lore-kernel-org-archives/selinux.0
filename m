Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5IJfA9C010038
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 15:41:10 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5IJfZHF002190
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 19:41:36 GMT
Message-ID: <4A3A9851.7010003@redhat.com>
Date: Thu, 18 Jun 2009 15:41:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
References: <C63853A5.A735D%csellers@tresys.com> <4A12EDFC.6020305@redhat.com> <4A3A4DC6.4070105@manicmethod.com>
In-Reply-To: <4A3A4DC6.4070105@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/18/2009 10:23 AM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> On 05/19/2009 12:16 PM, Chad Sellers wrote:
>>> On 5/18/09 2:10 PM, "Daniel J Walsh"<dwalsh@redhat.com> wrote:
>>>
>>>> Basically we need to search for all interfaces that return an int and
>>>> set those up as python exception handlers.
>>>
>>> I presume this supercedes the patch submitted on March 4 titled
>>> "Patch to
>>> python bindings" which used a single generic exception handler. Is that
>>> correct? Why the switch from a generic exception handler to a shell
>>> script
>>> to generate lots of specific exception handlers?
>>>
>>> Thanks,
>>> Chad
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to
>>> majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>> Yes, that patch caused certain interfaces to not work if they did not
>> return int.
>>
>
> This doesn't strike me as the best way to handle it. Assuming all
> functions that return an int returns it as a return code is a little
> overzealous. For example selinux_file_context_cmp() returns 1, 0, -1 for
> comparison. It is only not included in the exception.sh output by
> accident it appears (it is defined as int selinux_file_context_cmp(...)
> rather than extern int.
>
I am willing to accept better ideas.  Admittedly this is a hack, but I 
have not seen a bug since implementing.  I guess we should tell python 
when we have exceptions to the rule, like selinux_file_context_cmp

> Which brings up the next point, there are a handful of functions in
> selinux.h that don't have extern which means exception handlers aren't
> made for them.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
