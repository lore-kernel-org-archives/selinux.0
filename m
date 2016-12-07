Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7FFZIT024393
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 10:15:35 -0500
Message-ID: <1481123729.15018.8.camel@trentalancia.net>
Subject: Re: [PATCH v2] selinux: support distinctions among all network
 address families
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Wed, 07 Dec 2016 16:15:29 +0100
In-Reply-To: <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
References: <1481036419-30057-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQgD_oYn2zCzJCvUzzD_zJYKiQVbG_YMfoPpjphJzTOHA@mail.gmail.com>
 <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello.

On Wed, 07/12/2016 at 08.25 -0500, Stephen Smalley wrote:
> On 12/06/2016 07:13 PM, Paul Moore wrote:

[...]

> > You mentioned IGMP previously, if we have a class for ICMP, it
> > seems
> > reasonable to have one for IGMP, don't you think?  Although this
> > does
> > spiral a bit if we consider all the IPPROTO* protocols.
> 
> I thought about it, but the kernel does not provide IGMP sockets per
> se,
> unlike ICMP or SCTP sockets (i.e. ipv4/af_inet.c:inetsw_array[]
> defines
> an entry for SOCK_DGRAM, IPPROTO_ICMP and sctp/protocol.c defines and
> registers inet_protosw entries for SOCK_STREAM, IPPROTO_SCTP and
> SOCK_SEQPACKET, IPPROTO_SCTP; there is no equivalent for IGMP unless
> I
> missed it).  So IGMP sockets are just raw IP sockets with a
> particular
> protocol value; they have no stream, seqpacket, or dgram semantics,
> and
> it is unclear it is worthwhile to distinguish them in policy.

I suppose distinguishing IGMP packets brings little benefit in terms of
security.

Regards,

Guido
