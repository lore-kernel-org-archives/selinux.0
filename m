Message-ID: <49CD84CA.5020009@kaigai.gr.jp>
Date: Sat, 28 Mar 2009 11:00:42 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, method@manicmethod.com,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Expose avc_netlink_loop() for applications (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1796.2010507@ak.jp.nec.com> <49CC12C2.4050302@tycho.nsa.gov> <49CC1F3B.1040906@ak.jp.nec.com> <49CD752D.1070104@tycho.nsa.gov>
In-Reply-To: <49CD752D.1070104@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[snip]

>> The major one is we cannot handle them in a sindle lock section.
>> When the application is callbacked via AVC_CALLBACK_SETENFORCE,
>> it will change the state of enforcing/permissive, and it resets
>> its own avc on AVC_CALLBACK_RESET. But I would like to handle
>> these operations in a single lock section.
>>
>> If we reset the avc on AVC_CALLBACK_SETENFORCE, it finally
>> resets the avc twice on a single message. It is also unconfortable.
>>
>> The design of callbacks (via selinux_set_callback()) can be
>> considerable, but I don't think it is a good idea to hide
>> the netlink stuff here.
>>
>> In my patch, it adds SELINUX_CB_NETLINK for any messages.
>> But, if it would be SELINUX_CB_SETENFORCE and SELINUX_CB_POLICYLOAD,
>> we don't need to refer any netlink related stuffs from applications.
>>
>> What is your opinion?
>>   
> 
> 
> Considering your point, I'd rather create SETENFORCE and POLICYLOAD
> callbacks for selinux_set_callback(). However, they should be called in
> addition to the normal processing in avc_netlink_process(), not
> replacing the code flow. The savings from not updating a few globals and
> calling avc_ss_reset (which returns immediately if the userspace AVC is
> not running) are not that big.

It seems to me fair enough.

> You could optionally make avc_netlink_open() and avc_netlink_close()
> public functions, which would allow to avoid calling avc_init().

In addition, avc_netlink_loop() also.

I'll submit a revised patch on the Monday.
Please wait for a while.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
