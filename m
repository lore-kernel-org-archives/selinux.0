Message-ID: <4873A26A.1040400@manicmethod.com>
Date: Tue, 08 Jul 2008 13:22:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Paul Moore <paul.moore@hp.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: releasibility in mcstransd
References: <484D91BB.3080904@manicmethod.com> <4864D44E.8010505@redhat.com> <4864EE58.2090108@manicmethod.com> <200806271441.01625.paul.moore@hp.com> <486537FA.2010307@manicmethod.com> <90C62997-D6C9-4E64-A89F-A5569943DE67@nall.com>
In-Reply-To: <90C62997-D6C9-4E64-A89F-A5569943DE67@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> 
> On Jun 27, 2008, at 1:56 PM, Joshua Brindle wrote:
> 
>> Paul Moore wrote:
>>> On Friday 27 June 2008 9:42:48 am Joshua Brindle wrote:
>>>> I think for the time being we should not be importing the updated
>>>> mcstrans into fedora. There are still some unanswered questions about
>>>> the implementation. We are talking about some of these offline.
>>>
>>> Any particular reason why the discussion isn't online?  Granted I'm not
>>> sure I would have much useful to contribute but I do like hearing about
>>> what is going on and the discussion behind the decisions ...
>>>
>>
>> Oops, I misspoke. The unanswered questions were on list, how to deal
>> with the use of private libsepol types, duplicated functions and
>> missing ebitmap functionality in the library.
> 
> Any progress or thoughts on this?
> 

Not over here. I do have someone trying to use the updated server so I'll hopefully hear any comments or concerns back from them. 

On the technical issues above, I don't think Steve wanted the functionality pushed into the library but without either doing that or encapsulating all these types the server will always have to be statically linked against libsepol, which I'd like to avoid. 

I'll change my mind if it comes down to this server needs more information about the level than we can reasonably give via encapsulation.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
