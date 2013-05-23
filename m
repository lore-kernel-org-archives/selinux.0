Message-ID: <519E073F.80803@tycho.nsa.gov>
Date: Thu, 23 May 2013 08:10:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        Joshua Brindle <brindle@quarksecurity.com>
Subject: Re: Last version of policycoreutils using Fedora only API
References: <20130523005354.418a2541@fornost.bigon.be> <CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com> <20130523095747.22818ef6@soldur.bigon.be>
In-Reply-To: <20130523095747.22818ef6@soldur.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/23/2013 03:57 AM, Laurent Bigonville wrote:
> Le Thu, 23 May 2013 07:30:18 +0200,
> Sven Vermeulen <sven.vermeulen@siphos.be> a écrit :
>
>> On May 23, 2013 1:09 AM, "Laurent Bigonville" <bigon@debian.org>
>> wrote:
>>> The last release of policycoreutils is using a function
>>> (selinux_current_policy_path()) that is only available in Fedora. I
>>> guess this shouldn't have made upstream.
>>>
>>> An idea how this could be sorted for other distributions?
>>
>> Please see my answer to Joshua's announcement on the new userspace.
>
> Oh thanks, I messed this.
>
>> You'll need to add in the function.
>
> Well I'm not a big fan of adding function in libraries that are not
> merged upstream. IIRC eparis told me on IRC that he has not happy with
> this new functions.

Maybe we should back out the relevant changes and cut another release?
I agree that it is wrong for an upstream release to have Fedora-specific 
dependencies.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
