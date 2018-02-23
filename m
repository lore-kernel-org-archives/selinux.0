Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1NBb8wp007430
 for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2018 06:37:08 -0500
Message-ID: <1519385820.10225.2.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 23 Feb 2018 11:37:00 +0000
In-Reply-To: <201802230851.puwlEkXk%fengguang.wu@intel.com>
References: <201802230851.puwlEkXk%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [pcmoore-selinux:next 5/5]
 security/selinux/include/netlabel.h:135:66: error: unknown type name 'sock'
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-02-23 at 08:21 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selin
> ux.git next
> head:   db97c9f9d31217e3e133056fe2bea76639f87ec1
> commit: db97c9f9d31217e3e133056fe2bea76639f87ec1 [5/5] selinux: Add
> SCTP support
> config: x86_64-allyesdebian (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout db97c9f9d31217e3e133056fe2bea76639f87ec1
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from security/selinux/hooks.c:99:0:
> > > security/selinux/include/netlabel.h:135:66: error: unknown type
> > > name 'sock'
> 
>     static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> sock *newsk)
>                                                                      
> ^~~~
>    security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
> > > security/selinux/hooks.c:5182:2: error: implicit declaration of
> > > function 'selinux_netlbl_sctp_sk_clone'; did you mean
> > > 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-
> > > declaration]
> 
>      selinux_netlbl_sctp_sk_clone(sk, newsk);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      selinux_netlbl_inet_csk_clone
>    cc1: some warnings being treated as errors
> --
>    In file included from security/selinux/ss/services.c:68:0:
> > > security/selinux/include/netlabel.h:135:66: error: unknown type
> > > name 'sock'
> 
>     static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> sock *newsk)
>                                                                      
> ^~~~
> --
>    In file included from security//selinux/hooks.c:99:0:
> > > security/selinux/include/netlabel.h:135:66: error: unknown type
> > > name 'sock'
> 
>     static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> sock *newsk)
>                                                                      
> ^~~~
>    security//selinux/hooks.c: In function 'selinux_sctp_sk_clone':
>    security//selinux/hooks.c:5182:2: error: implicit declaration of
> function 'selinux_netlbl_sctp_sk_clone'; did you mean
> 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-
> declaration]
>      selinux_netlbl_sctp_sk_clone(sk, newsk);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      selinux_netlbl_inet_csk_clone
>    cc1: some warnings being treated as errors
> 
> vim +/sock +135 security/selinux/include/netlabel.h
> 
>    120	
>    121	static inline int
> selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>    122							    str
> uct sk_buff *skb)
>    123	{
>    124		return 0;
>    125	}
>    126	static inline int
> selinux_netlbl_inet_conn_request(struct request_sock *req,
>    127							   u16
> family)
>    128	{
>    129		return 0;
>    130	}
>    131	static inline void selinux_netlbl_inet_csk_clone(struct
> sock *sk, u16 family)
>    132	{
>    133		return;
>    134	}
>  > 135	static inline void selinux_netlbl_sctp_sk_clone(struct
> sock *sk, sock *newsk)

Paul,
Would you like a new selinux-Add-SCTP-support.patch to fix this.

>    136	{
>    137		return;
>    138	}
>    139	static inline int
> selinux_netlbl_socket_post_create(struct sock *sk,
>    140							    u16
> family)
>    141	{
>    142		return 0;
>    143	}
>    144	static inline int selinux_netlbl_sock_rcv_skb(struct
> sk_security_struct *sksec,
>    145						      struct
> sk_buff *skb,
>    146						      u16
> family,
>    147						      struct
> common_audit_data *ad)
>    148	{
>    149		return 0;
>    150	}
>    151	static inline int
> selinux_netlbl_socket_setsockopt(struct socket *sock,
>    152							   int
> level,
>    153							   int
> optname)
>    154	{
>    155		return 0;
>    156	}
>    157	static inline int selinux_netlbl_socket_connect(struct
> sock *sk,
>    158							struct
> sockaddr *addr)
>    159	{
>    160		return 0;
>    161	}
>    162	static inline int
> selinux_netlbl_socket_connect_locked(struct sock *sk,
>    163							       
> struct sockaddr *addr)
>    164	{
>    165		return 0;
>    166	}
>    167	#endif /* CONFIG_NETLABEL */
>    168	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
