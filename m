From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1 2/6] selinux: Set the peer label correctly on connected UNIX domain sockets
Date: Tue, 4 May 2010 11:34:16 -0400
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
References: <20100503220455.8177.91177.stgit@flek.lan> <1272981939.30175.57.camel@moss-pluto.epoch.ncsc.mil> <1272983220.2762.23.camel@localhost>
In-Reply-To: <1272983220.2762.23.camel@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201005041134.16579.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 10:27:00 am Eric Paris wrote:
> On Tue, 2010-05-04 at 10:05 -0400, Stephen Smalley wrote:
> > On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> > > Correct a problem where we weren't setting the peer label correctly on
> > > the client end of a pair of connected UNIX sockets.
> > > 
> > > Signed-off-by: XXX
> > > ---
> > > 
> > >  security/selinux/hooks.c |   28 ++++++++++++----------------
> > >  1 files changed, 12 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index f9545c8..09973e2 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -4039,34 +4039,30 @@ static int
> > > selinux_socket_unix_stream_connect(struct socket *sock,
> > > 
> > >  					      struct socket *other,
> > >  					      struct sock *newsk)
> > >  
> > >  {
> > > 
> > > -	struct sk_security_struct *ssec;
> > > -	struct inode_security_struct *isec;
> > > -	struct inode_security_struct *other_isec;
> > > +	struct sk_security_struct *sksec_s = sock->sk->sk_security;
> > > +	struct sk_security_struct *sksec_o = other->sk->sk_security;
> > > +	struct sk_security_struct *sksec_n = newsk->sk_security;
> > 
> > Don't you find the code using these names (sksec_[son]) to be rather
> > difficult to read compared to the old code?
> 
> He is probably doing this because I just converted everything that was
> an sk_security_struck to sksec for easy grepping in a recent patch.

Bingo.  Eric's patch seemed like a good idea to me so I'm trying to not break 
the convention here ...

> I'd be in favor of more than _s _o and _n suffix's though....

> > At the least, can we use more descriptive suffixes, e.g. _sock, _other,
> > _new, to match the input argument names, or if you prefer, _client,
> > _listener, _server?

I'm not in love with the names either, if you've got suggestions I'm all ears 
(well, I suppose eyes is more apt unless you want to call me to discuss the 
patches).

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
