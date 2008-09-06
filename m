Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m862Ani6022533
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 22:10:49 -0400
Received: from smtp108.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m862Ai2M006945
	for <selinux@tycho.nsa.gov>; Sat, 6 Sep 2008 02:10:49 GMT
Message-ID: <48C1E69A.2050002@schaufler-ca.com>
Date: Fri, 05 Sep 2008 19:10:34 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v5 05/14] smack: Fix missing calls to netlbl_skbuff_err()
References: <20080905231853.31840.57880.stgit@flek.lan> <20080905232344.31840.60714.stgit@flek.lan>
In-Reply-To: <20080905232344.31840.60714.stgit@flek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Smack needs to call netlbl_skbuff_err() to let NetLabel do the necessary
> protocol specific error handling.
>
> Signed-off-by: Paul Moore <paul.moore@hp.com>
>   
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
>  security/smack/smack_lsm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 87d7541..6e2dc0b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2179,7 +2179,10 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	 * This is the simplist possible security model
>  	 * for networking.
>  	 */
> -	return smk_access(smack, ssp->smk_in, MAY_WRITE);
> +	rc = smk_access(smack, ssp->smk_in, MAY_WRITE);
> +	if (rc != 0)
> +		netlbl_skbuff_err(skb, rc, 0);
> +	return rc;
>  }
>  
>  /**
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
