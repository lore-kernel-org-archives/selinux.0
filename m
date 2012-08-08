Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q78JR0RU004745
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2012 15:27:00 -0400
Received: by yhp3 with SMTP id 3so1237768yhp.12
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2012 12:26:58 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: John Stultz <johnstul@us.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov,
        Eric Dumazet <edumazet@google.com>, john.johansen@canonical.com
Subject: Re: NULL pointer dereference in selinux_ip_postroute_compat
Date: Wed, 08 Aug 2012 15:26:54 -0400
Message-ID: <17464273.DGOeQvDGIE@sifl>
In-Reply-To: <5022BAA2.90606@us.ibm.com>
References: <50215A7E.8000701@linaro.org> <502198B4.8040503@linaro.org> <5022BAA2.90606@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, August 08, 2012 12:14:42 PM John Stultz wrote:
> So I bisected this down and it seems to be the following commit:
> 
> commit be9f4a44e7d41cee50ddb5f038fc2391cbbb4046
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Jul 19 07:34:03 2012 +0000
> 
>      ipv4: tcp: remove per net tcp_sock
> 
> 
> It doesn't revert totally cleanly, but after fixing up the rejections
> and booting with this patch removed on top of Linus' head the oops on
> shutdown goes away.

Thanks!

It looks the like there is a bug in ip_send_unicast_reply() which uses a 
inet_sock/sock struct which does not have the LSM data properly initialized. 

I'll put together a patch shortly.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
