Message-ID: <4DA70C0F.10606@manicmethod.com>
Date: Thu, 14 Apr 2011 11:00:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Eric Paris <eparis@parisplace.org>, Steve Lawrence <slawrence@tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "qingtao.cao@windriver.com" <qingtao.cao@windriver.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol: support policy modules when roletrans rules
 not supported
References: <1302642701-15441-1-git-send-email-eparis@redhat.com>	 <4DA5BFF0.2090209@tresys.com>	<4DA5DEDB.9020005@tresys.com>	 <1302718034.8639.4.camel@unknown001a4b0c2895>	 <BANLkTinU3TutCwDNA9eROjAjY+xXmztH1g@mail.gmail.com>	 <4DA6FD94.1050302@manicmethod.com> <1302790741.9684.15.camel@unknown001a4b0c2895>
In-Reply-To: <1302790741.9684.15.camel@unknown001a4b0c2895>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Thu, 2011-04-14 at 09:58 -0400, Joshua Brindle wrote:
>> Eric Paris wrote:
>>> So I'm questioning the correctness of the range_transition and
>>> role_transition rules in libsepol.  My main problem is that libsepol
>>> defines SECCLASS_* at all.  Right now if the policy reads in one of
>>> these rules types without a tclass it will set SECCLASS_PROCESS in the
>>> tclasses bitmap.  But we never had any that would declare what the
>>> means.  At link time when we have to map "process" in a module to
>>> "process" in the base policy.  But if the module didn't require
>>> "process" it won't have the mapping.  So the fact that we set the
>>> SECCLASS_PROCESS bit could cause it to get mapped to random crap (or
>>> nothing at all)  Right?
>>>
>>> I know it's ugly but I think we need to do a couple of things.  #1 on
>>> that list is get SECCLASS_* out of libsepol altogether.  Those are
>>> COMPLETELY a construct of policy.  Not libsepol.  After we remove all
>>> of those we need to change the logic of everything that uses them to
>>> instead make sure that the "process" class exists in it's definitions
>>> and if not declare it.  Then set the bitmap for that new object.
>>>
>>> Am I not understanding something about how using SECCLASS_PROCESS
>>> could ever be a good idea?
>> It isn't the first time we've had hardcoded symbols that have to be mapped in
>> the code. See OBJECT_R_VAL as an example.
>>
>> It is a bit wonky though, suppose a type_transition rule were in a XenSE policy,
>> I don't think they have a process object class.
>
> So what it sounds like is that I probably want to look up the "process"
> class every time I would have used SECCLASS_PROCESS and if I don't find
> it, create it, and then look it up.  In this manor a policy which
> doesn't have process at all wouldn't have it forcibly jammed upon it
> (like we do in roles_init for OBJECT_R_VAL) and we wouldn't be mapping
> rules to garbage.  Sound right/ok to others?
>

It isn't the most elegant but there is precedence. I'm fine with it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
