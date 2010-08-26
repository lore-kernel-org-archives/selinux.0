Message-ID: <4C76FDD2.4070800@ak.jp.nec.com>
Date: Fri, 27 Aug 2010 08:50:42 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: ewalsh@tycho.nsa.gov
Subject: Re: [PATCH] Fast status update interface (/selinux/status)
References: <4C76455E.6000504@ak.jp.nec.com>
In-Reply-To: <4C76455E.6000504@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The new /selinux/status allows application to read-only mmap.
> It exposes the following structure, then application can reference
> these status information with nearly zero cost.
> 
>    struct selinux_kernel_status
>    {
>          u32     length;
>          u32     sequence;
>          u32     enforcing;
>          u32     policyload;
>    };
> 
> The 'sequence' shall be incremented by 2 for each events.
> So, application can know it should invalidate userspace avc,
> if the 'sequence' was changed from the last reference of avc.
> 
> The 'enforcing' and 'policyload' are protected from concurrent
> updates using seqlock logic. So, if 'sequence' is odd number,
> application needs to wait for a moment.
> 

The 'deny_unknown' might be also exposed.
When expected object class and access vectors are not supported
in the current working policy, userspace object manager needs to
know whether the undefined permissions should be denied, or not.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
