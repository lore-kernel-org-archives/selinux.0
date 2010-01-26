Subject: Re: incoming packets` context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d1001260421o160fec25qc7bc45ff6f6bda7c@mail.gmail.com>
References: <bb74313d1001260421o160fec25qc7bc45ff6f6bda7c@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 08:29:58 -0500
Message-Id: <1264512598.19890.9.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 15:51 +0330, michel m wrote:
> Hi,
> as I noticed, getpeercon() API allows me to have domain of the peer
> connection, but packets received have their own security context which
> are set by iptable rules on the peer side. how can I get arriving
> packets` context using libselinux?

iptables secmark labels are local-only; they are not passed across the
wire.  They are only used internally for network access control checks.

In contrast, labeled networking (netlabel or labeled ipsec) conveys the
security context across the wire, and that security context is exposed
to userspace via getpeercon(3) for stream sockets and via
IP_PASSEC/SCM_SECURITY for dgram sockets.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
