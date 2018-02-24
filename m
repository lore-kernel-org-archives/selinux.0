Message-ID: <1519468182.2469.7.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>,
 nhorman@tuxdriver.com, marcelo.leitner@gmail.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Martin Kepplinger <martink@posteo.de>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Feb 2018 10:29:42 +0000
In-Reply-To: <CAHC9VhTVaogfgf-R=so5mtrh9i1Vy9bnNm5CENgKKDKnSeWjZw@mail.gmail.com>
References: <20180223211235.2402024-1-arnd@arndb.de>
 <CAHC9VhTVaogfgf-R=so5mtrh9i1Vy9bnNm5CENgKKDKnSeWjZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: fix typo in
 selinux_netlbl_sctp_sk_clone declaration
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-02-23 at 16:25 -0500, Paul Moore wrote:
> On Fri, Feb 23, 2018 at 4:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > A missing 'struct' keyword caused a build error when
> > CONFIG_NETLABEL
> > is disabled:
> > 
> > In file included from security/selinux/hooks.c:99:
> > security/selinux/include/netlabel.h:135:66: error: unknown type
> > name 'sock'
> >  static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > sock *newsk)
> >                                                                   ^
> > ~~~
> > security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
> > security/selinux/hooks.c:5188:2: error: implicit declaration of
> > function 'selinux_netlbl_sctp_sk_clone'; did you mean
> > 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-
> > declaration]
> > 
> > Fixes: db97c9f9d312 ("selinux: Add SCTP support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  security/selinux/include/netlabel.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Thanks, merged and pushed to selinux/next.
> 
> Richard was going to submit a patch for that, but I don't think he
> would mind you beating him :)

Don't mind at all. What I will do then is fix the problem highlighted
by [1] that affects "[PATCH V7 2/4] sctp: Add ip option support", I'll
issue a V8 asap.

[1] https://lists.01.org/pipermail/kbuild-all/2018-February/043695.html

> 
> > diff --git a/security/selinux/include/netlabel.h
> > b/security/selinux/include/netlabel.h
> > index 6ef4953431dc..8671de09c363 100644
> > --- a/security/selinux/include/netlabel.h
> > +++ b/security/selinux/include/netlabel.h
> > @@ -132,7 +132,8 @@ static inline void
> > selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
> >  {
> >         return;
> >  }
> > -static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > sock *newsk)
> > +static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > +                                               struct sock *newsk)
> >  {
> >         return;
> >  }
> > --
> > 2.9.0
> > 
> 
> 
