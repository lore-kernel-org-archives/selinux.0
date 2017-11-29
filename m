Date: Thu, 30 Nov 2017 10:41:29 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
cc: Eric Dumazet <edumazet@google.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>, netdev <netdev@vger.kernel.org>,
 selinux@tycho.nsa.gov
In-Reply-To: <1511995754.16595.27.camel@gmail.com>
Message-ID: <alpine.LFD.2.20.1711301040400.16533@localhost>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <1511976706.10464.19.camel@tycho.nsa.gov>
 <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
 <1511985547.10464.22.camel@tycho.nsa.gov>
 <CANn89iK23gDN_ma3MyybzgDkBr_A7R-MPfAG3dS_f7ehpiJtJQ@mail.gmail.com>
 <1511995754.16595.27.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1073903225-1511998893=:16533"
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--8323328-1073903225-1511998893=:16533
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Nov 2017, Eric Dumazet wrote:

> On Wed, 2017-11-29 at 12:23 -0800, Eric Dumazet wrote:
> >=20
> > I suspect this exposes an ancient bug, caused by fact that TCP moves
> > IP[6]CB in skb->cb[]
> >=20
> > Basically the 2nd tcp_filter() added in commit
> > 8fac365f63c866a00015fa13932d8ffc584518b8
> > ("tcp: Add a tcp_filter hook before handle ack packet") was not
> > expecting selinux code being called a 2nd time,
> > while skb->cb[] has been mangled [1]
> >=20
> > [1]
> > memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
> > =C2=A0=C2=A0=C2=A0=C2=A0sizeof(struct inet_skb_parm));
>=20
> Please try this fix for IPv4 (a similar patch will be needed for IPv6)
>=20
>  net/ipv4/tcp_ipv4.c |   51 ++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 19 deletions(-)

Works for me, no crashes with the testsuite running in a loop.


Tested-by: James Morris <james.l.morris@oracle.com>


--=20
James Morris
<james.l.morris@oracle.com>

--8323328-1073903225-1511998893=:16533--
