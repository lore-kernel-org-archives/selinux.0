Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1NLPLeW026702
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 16:25:21 -0500
Received: by mail-lf0-f66.google.com with SMTP id x196so14246463lfd.12
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 13:25:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223211235.2402024-1-arnd@arndb.de>
References: <20180223211235.2402024-1-arnd@arndb.de>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2018 16:25:17 -0500
Message-ID: <CAHC9VhTVaogfgf-R=so5mtrh9i1Vy9bnNm5CENgKKDKnSeWjZw@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Martin Kepplinger <martink@posteo.de>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: fix typo in
 selinux_netlbl_sctp_sk_clone declaration
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 23, 2018 at 4:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A missing 'struct' keyword caused a build error when CONFIG_NETLABEL
> is disabled:
>
> In file included from security/selinux/hooks.c:99:
> security/selinux/include/netlabel.h:135:66: error: unknown type name 'sock'
>  static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
>                                                                   ^~~~
> security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
> security/selinux/hooks.c:5188:2: error: implicit declaration of function 'selinux_netlbl_sctp_sk_clone'; did you mean 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-declaration]
>
> Fixes: db97c9f9d312 ("selinux: Add SCTP support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/selinux/include/netlabel.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, merged and pushed to selinux/next.

Richard was going to submit a patch for that, but I don't think he
would mind you beating him :)

> diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
> index 6ef4953431dc..8671de09c363 100644
> --- a/security/selinux/include/netlabel.h
> +++ b/security/selinux/include/netlabel.h
> @@ -132,7 +132,8 @@ static inline void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>  {
>         return;
>  }
> -static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
> +static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> +                                               struct sock *newsk)
>  {
>         return;
>  }
> --
> 2.9.0
>

-- 
paul moore
www.paul-moore.com
