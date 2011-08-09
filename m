Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p79GDjgl031642
	for <selinux@tycho.nsa.gov>; Tue, 9 Aug 2011 12:13:45 -0400
Received: from nm6-vm0.bullet.mail.sp2.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p79GDh1U005322
	for <selinux@tycho.nsa.gov>; Tue, 9 Aug 2011 16:13:43 GMT
Message-ID: <4E415CB3.8020202@schaufler-ca.com>
Date: Tue, 09 Aug 2011 09:13:39 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: rongqing.li@windriver.com
CC: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 1/6] Security: define security_sk_getsecid.
References: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com> <1312874910-31010-2-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312874910-31010-2-git-send-email-rongqing.li@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/9/2011 12:28 AM, rongqing.li@windriver.com wrote:
> From: Roy.Li <rongqing.li@windriver.com>
>
> Define security_sk_getsecid to get the security id of a sock.

Why are you requesting the secid when you're just going to
use it to get the secctx? Why not ask for that directly?
Is there ever a case where you only want the secid?

>
> Signed-off-by: Roy.Li <rongqing.li@windriver.com>
> ---
>  include/linux/security.h |    6 ++++++
>  security/security.c      |    6 ++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ebd2a53..739ac39 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2560,6 +2560,7 @@ int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>  void security_sk_free(struct sock *sk);
>  void security_sk_clone(const struct sock *sk, struct sock *newsk);
>  void security_sk_classify_flow(struct sock *sk, struct flowi *fl);
> +void security_sk_getsecid(struct sock *sk, u32 *secid);
>  void security_req_classify_flow(const struct request_sock *req, struct flowi *fl);
>  void security_sock_graft(struct sock*sk, struct socket *parent);
>  int security_inet_conn_request(struct sock *sk,
> @@ -2701,6 +2702,11 @@ static inline void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
>  {
>  }
>  
> +static inline void security_sk_getsecid(struct sock *sk, u32 *secid)
> +{
> +	*secid = 0;
> +}
> +
>  static inline void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
>  {
>  }
> diff --git a/security/security.c b/security/security.c
> index 0e4fccf..b0e0825 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1104,6 +1104,12 @@ void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
>  }
>  EXPORT_SYMBOL(security_sk_classify_flow);
>  
> +void security_sk_getsecid(struct sock *sk, u32 *secid)
> +{
> +	security_ops->sk_getsecid(sk, secid);
> +}
> +EXPORT_SYMBOL(security_sk_getsecid);
> +
>  void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
>  {
>  	security_ops->req_classify_flow(req, fl);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
