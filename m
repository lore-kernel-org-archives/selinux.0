Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5J9wBkM001955
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 05:58:25 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5J9wcKY006365
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 09:58:38 GMT
Message-ID: <4A3B6110.8010308@redhat.com>
Date: Fri, 19 Jun 2009 05:57:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch add seusers support to SELinux
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com> <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com> <4A3AA03E.4010208@manicmethod.com>
In-Reply-To: <4A3AA03E.4010208@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/18/2009 04:14 PM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> On 06/18/2009 09:48 AM, Joshua Brindle wrote:
>>> Joshua Brindle wrote:
>>>> Daniel J Walsh wrote:
>>>>> The idea here is to break the seusers file up into lots of little
>>>>> seusers file that can be user specific, also adds the service field to
>>>>> be used by tools like pam_selinux to choose which is the correct
>>>>> context
>>>>> to log a user in as.
>>>>>
>>>>> Patch was added to facilitate IPA handing out SELinux content for
>>>>> selection of roles at login.
>>>>>
>>>>
>>>> This patch does not affect the behavior of getseuserbyname(), how is
>>>> this expected to work with existing applications?
>>>>
>> I think it only affects pam_selinux.
>
> The function name is very confusing if its only used for pam_selinux,
> I'd like it renamed but seeing that pam_selinux is already deployed with
> it I suppose that isn't an option.
>
> Signed-off-by: Joshua Brindle <method@manicmethod.com>
>
>>>
>>> Also, what is the format of this file? What should service be to test
>>> this on F11?
>>>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
It is not only for pam_selinux, but that is currently the only user.

Really all this function does is add a second variable when selecting a 
users default context. service is just a string that the caller can 
specify.  It just allows you to change the default context you would get 
on entry to the system.  So I guess you could get use similar calls to 
get different context depending on whether or not you are on the 
console.  Imagine a dbus service which would run with one context if you 
we logged onto the console versus a different context if you were logged 
in via ssh.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
