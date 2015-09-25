Date: Fri, 25 Sep 2015 17:45:30 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: selinux network control question
Message-ID: <20150925154528.GB29665@x250>
References: <20150925151543.GA29665@x250>
 <560567F4.8010800@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <560567F4.8010800@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 25, 2015 at 11:27:48AM -0400, Stephen Smalley wrote:
> On 09/25/2015 11:15 AM, Dominick Grift wrote:
> > I am trying to clean up my network policy module but some things are
> > unclear. Could anyone shine some light (or correct me) on the below:
> > 
> > 1.
> > network interface labels are no longer checked in any scenario (secmark,
> > netlabel, labeled-ipsec) and the netif isid is no longer used.
> > 
> > So i can remove my netif types and associate the netif isid with a
> > context reserved for unused isids?
> 
> netif SIDs are used by the egress/ingress permission checks (which are only active if using peer labeling).

so netifcon is still useful (albeit only with peer labeling) ?

> 
> > 2.
> > Above also applies to node labels (ie. nodes are no longer checked in
> > any scenarion (secmark, netlabel, labeled-ipset)
> > 
> > The question is then why is the node isid still working. And why do i
> > need to allow some processes to bind to nodes with the context
> > associated with the node isid?
> > 
> > why is the node isid still used?
> 
> node SIDs are used in checks on bind(2) and for sendto/recvfrom checks (also only if using peer labeling).
>

so nodecon is still useful (albeit with using peer labeling) ?

What i do not understand and find inconsistent is: why do i need to
allow processes that bind(2) to bind nodes associated with the
context associated with the node isid regardless, but nodecon is not
honored without using peer labeling 

> > 3. packets are checked with secmark, and you can associate different
> > packet types with different packets)
> 
> secmark allows local/internal labeling of packets via iptables and access control over them based on those labels.
>

So only packet labels apply to secmark

> > 4. peers are checked with netlabel, but you only need on peer type
> > (ie. you can't associate different peer types with different peers)
> 
> peer labeling can be based on labeled IPSEC or netlabel.
> NetLabel can only pass MLS labels across the network, although it can convey full contexts locally (see the selinux-testsuite for a configured example under tests/inet_socket or the SELinux Notebook for further examples).
> Labeled IPSEC can pass full labels locally or across the network (ditto).

So i only need a single "peer type" (the one associated with the peer isid)


It is a bit confusing to me, the more because i do not use these
technologies but i want to support them with my policy.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWBWwUAAoJENAR6kfG5xmcQZ8L/20Dua/mYrwNgbdIlKgsD+Hz
5511SyuGQ/Mx1tIXLJYIQsr46W5mpeMB0RqTcvIMAdQsKDE6MXE3omA8TQu+oPRl
VpcKKFSHtOhTouD7MHRny/6KjVEB3YrPZZNOSMB+t8JpAF0s/yfkQf4yNYUY+S/O
8jJMaklYNc7rKldPS8O6dz9WnCM0I00mBLwBuc+x5lhbF50Ja9ByNazepqAi6cOo
Al/shGWiszpfNjaiYMOxuzDE5ErUN54OU6RtJHtcV+BKVhImHO1qFZa1ojJMiWzk
zdQpqSGyhy195gkW0in0MSGX4E8Bp2LmLrD5cO6cJuCMb+n0L5F4sihT4e+2FUJF
de8/jX2jnlAJkaHzu6P+Ubx1+DMmlQUWZ/ZuK0+Y5peJTbGN9fuz1Rt/Zy89cDzg
LkIB2O1VT4DmbovGQfkKLBjvVUU07bijj96HQQTR86hHByRA6JCUwej07Yj51xBE
NciKsz62tJyspKAjX0EF3d2BORY28KAueF11JZFr9Q==
=TwuT
-----END PGP SIGNATURE-----
