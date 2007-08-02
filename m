Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72M1Mrq000498
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:01:22 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72M1JTm027738
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 22:01:20 GMT
Message-ID: <46B2544F.4090700@kaigai.gr.jp>
Date: Fri, 03 Aug 2007 07:01:51 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
Cc: fedora-selinux-list@redhat.com, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: SE-PostgreSQL for Fedora (Re: Guideline for RPM packages)
References: <46681714.3030009@kaigai.gr.jp> <1181227502.11979.24.camel@moss-spartans.epoch.ncsc.mil> <46681ED6.1010408@kaigai.gr.jp> <46A861F6.10709@ak.jp.nec.com> <46A8CAE0.7030809@kaigai.gr.jp> <46B207B3.6040703@manicmethod.com> <46B21986.5040806@kaigai.gr.jp> <46B21C29.906@manicmethod.com>
In-Reply-To: <46B21C29.906@manicmethod.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Err, I think you should be using the new userland discovery interface
> for this, hardcoding at compile time is a very bad idea (it makes the
> compiled binaries completely non-portable).
> 
> look at libselinux/checkAccess.c in the trunk version to see how it is
> used, essentially something like:
> 
> dbase_class = string_to_security_class("database");
> if (dbase_class == 0)
> return 0;
> 
> That lets you discover the class offset at runtime. There are also
> facilities for doing the same with permissions.

SE-PostgreSQL can already use the userland discovert interdace, if the kernel
provides it. But it is available at the only latest kernel, now.
We have to be also able to apply hardcoded object class number for a while,
to work on the current kernel (2.6.22 or older).

Otherwise, we have to replace or modify the base policy to add definitions of
new object classes and access vectors related to database, so we want these
definitions are integrated into the base policy.

Thanks,

>> As you mentioned, I also think this trick is not a good idea.
>> However, the number of object classes is not constant between policy versions,
>> so I had to handle the difference and to follow the version up.
>> I modified it by hand at first, but conditional definition for SECCLASS_DATABASE
>> got necessary, because the number of object classes got differ between Fedora core 6
>> and Fedora 7.
>>
>> I think integration of these definitions into the base policy is the best way
>> to avoid such a ugly implementation. :)
>>
>> Thanks,
>>
>>   
>>> As an aside to this, I notice that you tried to integrate policy
>>> management into the RPM, and I had to modify my spec file to not do this
>>> because I have my own custom policies on the system. I don't think this
>>> is the best way, long term, to handle policy integration, though,
>>> unfortunately, I don't have any better suggestions. This is something I
>>> intend to look into soon though so I'll provide some feedback on the
>>> previous thread when I have something useful to say :)
>>>     
>> --
>> KaiGai Kohei <kaigai@kaigai.gr.jp>

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
