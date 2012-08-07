Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77M1df9012765
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 18:01:39 -0400
Received: by qcpx40 with SMTP id x40so73661qcp.12
        for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2012 15:01:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50218F7E.1060004@linaro.org>
References: <50215A7E.8000701@linaro.org>
	<CAHC9VhTSS8+-OcX9uK0xqnYC3-y0axVGs1m+kuC6+M6HvmSmgg@mail.gmail.com>
	<50218F7E.1060004@linaro.org>
Date: Tue, 7 Aug 2012 18:01:38 -0400
Message-ID: <CAHC9VhTd-d9NgWoU6_o9qw0bq4ZbuTEj8E_jRYyDXPWQaLLdog@mail.gmail.com>
Subject: Re: NULL pointer dereference in selinux_ip_postroute_compat
From: Paul Moore <paul@paul-moore.com>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 7, 2012 at 5:58 PM, John Stultz <john.stultz@linaro.org> wrote:
> On 08/07/2012 02:50 PM, Paul Moore wrote:
>>
>> On Tue, Aug 7, 2012 at 2:12 PM, John Stultz <john.stultz@linaro.org>
>> wrote:
>>>
>>> Hi,
>>>      With my kvm environment using 3.6-rc1+, I'm seeing NULL pointer
>>> dereferences in selinux_ip_postroute_compat(). It looks like the sksec
>>> value
>>> is null and we die in the following line:
>>>
>>>      if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
>>>
>>> This triggers every time I shutdown the machine, but has also triggered
>>> randomly after a few hours.
>>>
>>> This is on an ubuntu 12.04 image, not using selinux.
>>
>> NOTE: Adding the SELinux list to the CC line
>
> Thanks!
>
>> Hi,
>>
>> I'm trying to understand this and I was hoping you could you clarify a
>> few things for me:
>>
>> * Is the panic in the Ubuntu 12.04 guest, or the host?  If the host,
>> could you share what distribution you are using?
>
> Sorry, its a 12.04 guest.  I think the host is Ubuntu 12.04 as well.
>
>
>> * When you say you are not using SELinux, could you be more specific?
>> It seems odd that you are not using SELinux but the panic is happening
>> in a SELinux hook.
>
> I just mean that, being Ubuntu,  the system (userland) isn't configured to
> use selinux.  SELinux is just enabled in the kernel config.

Thanks for the quick response, I'll setup an Ubuntu guest and see if I
can reproduce this ... something is odd.  Anything non-standard about
your guest install or anything else you think might be helpful?

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
