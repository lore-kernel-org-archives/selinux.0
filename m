Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q39HjMDE021267
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2012 13:45:22 -0400
Received: by qcsk26 with SMTP id k26so2675247qcs.12
        for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2012 10:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F831D42.2080208@manicmethod.com>
References: <4F7F4FD5.30108@tycho.ncsc.mil>
	<4F831D42.2080208@manicmethod.com>
Date: Mon, 9 Apr 2012 13:45:21 -0400
Message-ID: <CACLa4puxwxJ4n5arqSMNuovSgqKRJBiJVWXkTaHAuuJ3o2zYZA@mail.gmail.com>
Subject: Re: libselinux: Provide new labeling backend
From: Eric Paris <eparis@parisplace.org>
To: Joshua Brindle <method@manicmethod.com>
Cc: rpcraig <rpcraig@tycho.ncsc.mil>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I belive sds would like me to grab his libselinux android patches from
2/23 and get them into the main repo.  I'm hoping to get to the this
afternoon.

-Eric

On Mon, Apr 9, 2012 at 1:32 PM, Joshua Brindle <method@manicmethod.com> wrote:
> rpcraig wrote:
>>
>> I have attached a patch which provides a new labeling backend
>> directed at the Android property service keys.
>
>
> Does this apply to the main selinux repo or the android repo? It appears to
> be the selinux repo but I don't understand what the purpose is since Android
> uses a different libselinux at runtime.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
