Message-ID: <43E7A4F1.4010005@acronis.com>
Date: Mon, 06 Feb 2006 22:35:13 +0300
From: Vladimir Simonov <Vladimir.Simonov@acronis.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: initrc_t has no execmod in targeted policy
References: <43E6FBD2.5040207@acronis.com> <1139235066.31135.49.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139235066.31135.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Thank you for your feedback.

Really dlopen-ed shared libs are quite typical -
created with --shared, -fpic, etc. They (and daemon itself)
do not use direct mmap/mprotect syscalls (just libc calls).
Daemon is called from simple bash init script located in
/etc/init.d. And I don't put bash script/demon/libs
into initrc_t domain directly. I suspect they are in initrc_t
by selinux magic.

So some question remains:
Does selinux (on FC4) permit dlopen call from initrc_t domain?
If not, then why?

I'm afraid even if I put all above staff into separate domain
(but start daemon from init scripts) the daemon will be moved
to initrc_t domain by selinux. Am I correct?

Thank you in advance
Vladimir Simonov


Stephen Smalley wrote:
> On Mon, 2006-02-06 at 10:33 +0300, Vladimir Simonov wrote:
> 
>>Hi all,
>>
>>Trying to launch my network daemon fron init.d on
>>Fedora Core 4 I see "avc:  denied  { execmod } ..."
>>in audit.log. The daemon loads some shared libraries
>>via dlopen. If I guessed right, code relocation at load
>>time modifies code segment and violates "no execmod
>>for initrc_t" rile.
>>
>>The questions:
>>1. Is my guess correct?
> 
> 
> execmod usually indicates a text relocation, which reflects a problem in
> the DSO that should be fixed if possible.  See:
> http://people.redhat.com/drepper/selinux-mem.html
> http://people.redhat.com/drepper/dsohowto.pdf
> 
> 
>>2. If yes, should it be considered as policy drawback
>>(FC4 uses policy.19) or I'm missing something?
> 
> 
> No, certainly not for initrc_t, as you shouldn't run your daemon
> directly in that domain anyway.
> 
> 
>>3. How to add execmod to system_u:system_r:initrc_t
>>type without full policy rebuild?
> 
> 
> You don't want to do that - you want to define a new domain for your
> daemon (or if it has the same security requirements as a daemon that
> already has policy and you don't care about separating them, you could
> just label it with the same entrypoint type).  
> 
> On FC4, you still have to install the policy sources package, add your
> files defining your own rules, and rebuild the entire binary policy.
> The modular policy support is coming in FC5.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
