Message-ID: <485BF64E.9060905@manicmethod.com>
Date: Fri, 20 Jun 2008 14:26:22 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: releasibility in mcstransd
References: <484D91BB.3080904@manicmethod.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com> <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com> <485BCED3.9020903@manicmethod.com> <FBDB910C-1B8E-4DCD-A427-6EF0B161F329@nall.com>
In-Reply-To: <FBDB910C-1B8E-4DCD-A427-6EF0B161F329@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> 
> On Jun 20, 2008, at 10:37 AM, Joshua Brindle wrote:
> 
>> Joe Nall wrote:
>>>
>>> ...
>>> Attached is a source rpm based on the mcstransd we are using internally.
>>> It can translate ranges that look like:
>>>
>> Thanks for this. I started looking at the diff and it is pretty
>> significant, it might take me a while to get through it all. One thing
>> I noticed immediately is that you are duplicating interfaces present
>> in libsepol such as mls_level_to_string, mls_level_from_string and
>> importing private headers from libsepol.
> 
> IIRC, the functions were not exported. I'm more than willing to drop
> those routines and use libsepol.
> 
>> I don't think we want to proceed this way. If possible we should be
>> using the libsepol interfaces and encapsulating the private types as
>> necessary.
> 
> I agree
> 

Stephen: What do you think we should do about this? We've talked about losing some of the encapsulation in libsepol but that was related to policydb. Should we just export the mls types for now and use those or continue by making them opaque? Since this mcstrans does alot of operations on them it might make making them opaque difficult. We could probably move alot of the functionality out of mcstrans and in to libsepol but that would be coupling our libs to this particular translation scheme which I thought we were trying to avoid?

>> The ebitmap operations can certainly be put in libsepol but shouldn't
>> be called directly the way they are.
> 
> I like to putting the additional ebitmap functions in libsepol. I was
> hoping Stephen would make them faster too :) I don't understand the
> 'shouldn't be called directly the way they are' comment.
> 

ebitmaps aren't exported so you'd never actually have an unencapsulated one in the application. 

>> It looks like quite a few todo's and hacks are in there as well.
> 
> Yep. It got to this mostly workable state some time ago and other things
> have taken precedence since.
> 
>> I'll try to help as much as I can, and hopefully we can get this in
>> good shape to merge in to Dan's codebase. Are you going to have any
>> time to work on this?
> 
> Yes. I really want to get some conversion constraints in before OLS.
> Things like REL and NOFORN don't go together. An interface to export
> which bits are 'inverse' would be very handy within our applications
> code. The semanage translation code is broken/obsoleted by these changes
> too.
> 

What about semanage? Is it doing translations without calling the translation interfaces that talk to the server?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
