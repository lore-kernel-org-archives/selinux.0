Message-ID: <1515605860.21056.1.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, Vlad
 Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com, Stephen Smalley
 <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, marcelo.leitner@gmail.com,
 casey@schaufler-ca.com
Date: Wed, 10 Jan 2018 17:37:40 +0000
In-Reply-To: <CAHC9VhR9AkU4nF8VjCiGERtTU5OEtSUQFcDDhJeyJe2gzM=1gQ@mail.gmail.com>
References: <20171230172035.15837-1-richard_c_haines@btinternet.com>
 <CAHC9VhR9AkU4nF8VjCiGERtTU5OEtSUQFcDDhJeyJe2gzM=1gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V4 4/4] selinux: Add SCTP support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-01-10 at 11:37 -0500, Paul Moore wrote:
> On Sat, Dec 30, 2017 at 12:20 PM, Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > The SELinux SCTP implementation is explained in:
> > Documentation/security/SELinux-sctp.rst
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  Documentation/security/SELinux-sctp.rst | 157 ++++++++++++++++++
> >  security/selinux/hooks.c                | 280
> > +++++++++++++++++++++++++++++---
> >  security/selinux/include/classmap.h     |   2 +-
> >  security/selinux/include/netlabel.h     |  21 ++-
> >  security/selinux/include/objsec.h       |   4 +
> >  security/selinux/netlabel.c             | 138 ++++++++++++++--
> >  6 files changed, 570 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/security/SELinux-sctp.rst
> 
> ...
> 
> > +/**
> > + * selinux_netlbl_socket_connect - Label a client-side socket on
> > connect
> > + * @sk: the socket to label
> > + * @addr: the destination address
> > + *
> > + * Description:
> > + * Attempt to label a connected socket with NetLabel using the
> > given address.
> > + * Returns zero values on success, negative values on failure.
> > + *
> > + */
> > +int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr
> > *addr)
> > +{
> > +       int rc;
> > +       struct sk_security_struct *sksec = sk->sk_security;
> > +
> > +       if (sksec->nlbl_state != NLBL_REQSKB &&
> > +           sksec->nlbl_state != NLBL_CONNLABELED)
> > +               return 0;
> > +
> > +       lock_sock(sk);
> > +       rc = selinux_netlbl_socket_connect_helper(sk, addr);
> >         release_sock(sk);
> > +
> >         return rc;
> >  }
> > +
> > +/**
> > + * selinux_netlbl_socket_connect_locked - Label a client-side
> > socket on
> > + * connect
> > + * @sk: the socket to label
> > + * @addr: the destination address
> > + *
> > + * Description:
> > + * Attempt to label a connected socket that already has the socket
> > locked
> > + * with NetLabel using the given address.
> > + * Returns zero values on success, negative values on failure.
> > + *
> > + */
> > +int selinux_netlbl_socket_connect_locked(struct sock *sk,
> > +                                        struct sockaddr *addr)
> > +{
> > +       struct sk_security_struct *sksec = sk->sk_security;
> > +
> > +       if (sksec->nlbl_state != NLBL_REQSKB &&
> > +           sksec->nlbl_state != NLBL_CONNLABELED)
> > +               return 0;
> > +
> > +       return selinux_netlbl_socket_connect_helper(sk, addr);
> > +}
> 
> [Sorry for the review delay, the holidays and some associated travel
> made it hard to find some quiet time to look at the latest patches.]
> 
> I probably should have been a bit more clear in my last comment, but
> what I had in mind was something like the following:
> 
> int selinux_netlbl_socket_connect_locked(...)
> {
>     if (sksec->nlbl_state ...)
>         return 0;
> 
>     return selinux_netlbl_socket_connect_helper();
> }
> 
> int selinux_netlbl_socket_connect(...)
> {
>     int rc;
> 
>     lock_sock();
>     rc = selinux_netlbl_socket_connect_locked();
>     release_sock();
> 
>     return rc;
> }
> 
> Yes, you do end up checking nlbl_state while the socket lock is held,
> but I believe the benefit of consolidating the code outweighs any
> additional overhead (I believe it would be "noise" anyway).

Okay I'll send an updated [PATCH V5 4/4] tomorrow.

> 
> Otherwise, this all looks good to me.
> 
