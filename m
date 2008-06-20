Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5KIgR1C023286
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 14:42:27 -0400
Received: from hs-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5KIgQNo004159
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 18:42:27 GMT
Received: by hs-out-0708.google.com with SMTP id k27so210624hsc.2
        for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 11:42:26 -0700 (PDT)
Cc: Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <BCA36425-E46A-4BAF-B712-732E2F8A4A4D@nall.com>
From: Joe Nall <joe@nall.com>
To: Joshua Brindle <method@manicmethod.com>
In-Reply-To: <485BF64E.9060905@manicmethod.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: releasibility in mcstransd
Date: Fri, 20 Jun 2008 13:41:45 -0500
References: <484D91BB.3080904@manicmethod.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com> <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com> <485BCED3.9020903@manicmethod.com> <FBDB910C-1B8E-4DCD-A427-6EF0B161F329@nall.com> <485BF64E.9060905@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 20, 2008, at 1:26 PM, Joshua Brindle wrote:

> Joe Nall wrote:
>>
>> On Jun 20, 2008, at 10:37 AM, Joshua Brindle wrote:
>>
>>> Joe Nall wrote:
>>>>
>>>> ...
>>>> Attached is a source rpm based on the mcstransd we are using  
>>>> internally.
>>>> It can translate ranges that look like:
>>>>
>>> Thanks for this. I started looking at the diff and it is pretty
>>> significant, it might take me a while to get through it all. One  
>>> thing
>>> I noticed immediately is that you are duplicating interfaces present
>>> in libsepol such as mls_level_to_string, mls_level_from_string and
>>> importing private headers from libsepol.
>>
>> IIRC, the functions were not exported. I'm more than willing to drop
>> those routines and use libsepol.
>>
>>> I don't think we want to proceed this way. If possible we should be
>>> using the libsepol interfaces and encapsulating the private types as
>>> necessary.
>>
>> I agree
>>
>
> Stephen: What do you think we should do about this? We've talked  
> about losing some of the encapsulation in libsepol but that was  
> related to policydb. Should we just export the mls types for now and  
> use those or continue by making them opaque? Since this mcstrans  
> does alot of operations on them it might make making them opaque  
> difficult. We could probably move alot of the functionality out of  
> mcstrans and in to libsepol but that would be coupling our libs to  
> this particular translation scheme which I thought we were trying to  
> avoid?
>
>>> The ebitmap operations can certainly be put in libsepol but  
>>> shouldn't
>>> be called directly the way they are.
>>
>> I like to putting the additional ebitmap functions in libsepol. I was
>> hoping Stephen would make them faster too :) I don't understand the
>> 'shouldn't be called directly the way they are' comment.
>>
>
> ebitmaps aren't exported so you'd never actually have an  
> unencapsulated one in the application.

FWIW, we do a fair amount of application level category bit twiddling  
beyond what mcstrans does. Having interfaces that allow access to the  
bits is a good thing. Our needs may not be representative :)

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
