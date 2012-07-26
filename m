Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QFWqqe027770
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 11:32:56 -0400
Received: by ghbz13 with SMTP id z13so2183770ghb.12
        for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 08:32:55 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, eparis@redhat.com
Cc: Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] Fix broken peer recv check
Date: Thu, 26 Jul 2012 11:32:52 -0400
Message-ID: <1436950.BLQxDVFpHs@sifl>
In-Reply-To: <C42CE43E0E13AB44A299B62E25500374120AC7@TCSEXCH1.tcs-sec.com>
References: <C42CE43E0E13AB44A299B62E25500374120AC7@TCSEXCH1.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, July 20, 2012 09:42:59 PM Chad Hanson wrote:
> Fix a broken networking check. Return an error if peer recv fails. If
> secmark is active and the packet recv succeeds the peer recv error is
> ignored.
> 
> Signed-off-by: Chad Hanson <chanson@trustedcs.com>

I would also consider this as reasonable for stable once it it merged.

Acked-by: Paul Moore <paul@paul-moore.com>

> ---
>  hooks.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d85b793..64826a0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4215,8 +4215,10 @@ static int selinux_socket_sock_rcv_skb(struct sock
> *sk, struct sk_buff *skb) }
>  		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
>  				   PEER__RECV, &ad);
> -		if (err)
> +		if (err) {
>  			selinux_netlbl_err(skb, err, 0);
> +			return err;
> +		}
>  	}
> 
>  	if (secmark_active) {

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
