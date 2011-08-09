Message-ID: <4E40F5D6.5060704@windriver.com>
Date: Tue, 9 Aug 2011 16:54:46 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: Re: [PATCH 6/6] Export the tcp sock's security context to proc.
References: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>	<1312874910-31010-7-git-send-email-rongqing.li@windriver.com> <20110809.003326.1002501904080430572.davem@davemloft.net>
In-Reply-To: <20110809.003326.1002501904080430572.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/09/2011 03:33 PM, David Miller wrote:
> From:<rongqing.li@windriver.com>
> Date: Tue, 9 Aug 2011 15:28:30 +0800
>
>>   	if (v == SEQ_START_TOKEN) {
>>   		seq_printf(seq, "%-*s\n", TMPSZ - 1,
>>   			   "  sl  local_address rem_address   st tx_queue "
>>   			   "rx_queue tr tm->when retrnsmt   uid  timeout "
>> -			   "inode");
>> +			   "inode seclabel");
>>   		goto out;
>>   	}
>
> Unfortunately you cannot change the layout of procfs file output in
> this way.  It has the potential to break programs which are parsing
> this file in userspace already.
>
> The layout hasn't changed in a very long time because it is essentially
> a uservisible ABI.
>
> If you want to export new information you'll have to do it using the
> facility that is extensible, and that's the netlink based socket dumping
> facility implemented in inet_diag.c, tcp_diag.c and friends.
>
> There, you can simply add a new netlink attribute that gets dumped with
> the entry, which will provide the security context.
>
>

Thanks, I see how I should do.
I will continue to develop it and hope get your help.
Thanks.


-- 
Best Reagrds,
Roy | RongQing Li

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
