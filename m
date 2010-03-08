Message-ID: <4B9585E4.8040203@tycho.nsa.gov>
Date: Mon, 08 Mar 2010 18:19:00 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] libselinux: fix avc_netlink_loop() error caused by nonblocking
 mode.
References: <4B691583.5060608@ak.jp.nec.com> <4B881D79.4000500@tycho.nsa.gov> <4B8833C6.9070503@tycho.nsa.gov> <4B88356E.1040501@tycho.nsa.gov> <4B8C7C88.4090701@ak.jp.nec.com> <4B8D4AED.80203@tycho.nsa.gov> <4B8DAD9A.5020200@ak.jp.nec.com>
In-Reply-To: <4B8DAD9A.5020200@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/02/2010 07:30 PM, KaiGai Kohei wrote:
>
> It seems to me ok basically.
>
> It is just my preference. Can you move the poll(2) at the head of
> the avc_netlink_receive() call, like as the attachment?
> How should I say...it seems to me itchy to change non-blocking mode
> into blocking mode implicitly at avc_netlink_loop(), although we can
> specify the mode at creation time (avc_netlink_open()).
>
> Thanks,
>   


I have pushed this patch, thanks.



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
