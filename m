Date: Tue, 12 Dec 2017 19:56:38 -0200
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Message-ID: <20171212215638.GH3532@localhost.localdomain>
References: <20171127193121.2666-1-richard_c_haines@btinternet.com>
 <20171212160800.GE3532@localhost.localdomain>
 <CAHC9VhR+WoO3UtdXLp+9mQ=c=avpEQ5-W8vTkEWfxXH1EkUS8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhR+WoO3UtdXLp+9mQ=c=avpEQ5-W8vTkEWfxXH1EkUS8A@mail.gmail.com>
Subject: Re: [PATCH 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 12, 2017 at 04:33:03PM -0500, Paul Moore wrote:
> On Tue, Dec 12, 2017 at 11:08 AM, Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> > Hi Richard,
> >
> > On Mon, Nov 27, 2017 at 07:31:21PM +0000, Richard Haines wrote:
> > ...
> >> --- a/net/sctp/socket.c
> >> +++ b/net/sctp/socket.c
> >> @@ -3123,8 +3123,10 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
> >>
> >>       if (asoc) {
> >>               if (val == 0) {
> >> +                     struct sctp_af *af = sp->pf->af;
> >>                       val = asoc->pathmtu;
> >> -                     val -= sp->pf->af->net_header_len;
> >> +                     val -= af->ip_options_len(asoc->base.sk);
> >> +                     val -= af->net_header_len;
> >>                       val -= sizeof(struct sctphdr) +
> >>                                       sizeof(struct sctp_data_chunk);
> >>               }
> >
> > Right below here there is a call to sctp_frag_point(). That function
> > also needs this tweak.
> >
> > Yes, we should simplify all these calculations. I have a patch to use
> > sctp_frag_point on where it is currently recalculating it on
> > sctp_datamsg_from_user(), but probably should include other places as
> > well.
> 
> FYI: Richard let me know he is occupied with another project at the
> moment and likely won't be able to do another respin until next week
> at the earliest.

Okay, thanks. I can do a follow-up patch if it helps.

  Marcelo
