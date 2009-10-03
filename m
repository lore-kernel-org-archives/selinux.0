Date: Sat, 03 Oct 2009 21:30:49 +0300
From: =?gb2312?B?xbfn5sv+zqzRxw==?= <octavian.ionescu@huawei.com>
Subject: RE: [PATCH v4 2/2] selinux:  generate flask headers during kernel build
In-reply-to: <1254530025.12997.4.camel@defiant.pebenito.net>
To: "'Chris PeBenito'" <pebenito@gentoo.org>,
        "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'James Morris'" <jmorris@namei.org>,
        "'KaiGai Kohei'" <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        "'Eric Paris'" <eparis@parisplace.org>,
        "'Paul Moore'" <paul.moore@hp.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>
Message-id: <000e01ca4457$c52f37d0$efe3540a@china.huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello all,

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Chris PeBenito
Sent: Saturday, October 03, 2009 3:34 AM
To: Stephen Smalley
Cc: James Morris; KaiGai Kohei; selinux@tycho.nsa.gov; Eric Paris; Paul
Moore; Joshua Brindle
Subject: Re: [PATCH v4 2/2] selinux: generate flask headers during kernel
build

On Thu, 2009-10-01 at 08:32 -0400, Stephen Smalley wrote:
> On Thu, 2009-10-01 at 07:46 +1000, James Morris wrote:
> > On Wed, 30 Sep 2009, Stephen Smalley wrote:
> > 
> > > Does anyone think we still need to support policy versions <
> > > POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
> > > dynamic remapping of netlink classes in the security server:
> > >         if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
> > >                 if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
> > >                     tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> > >                         tclass = SECCLASS_NETLINK_SOCKET;
> > > 
> > > I think RHEL4 shipped with policy.18.
> > 
> > Was any distro shipped with a lower policy version?  If not, then I
think 
> > it should be ok.
> 
> policy.18 was first supported by Linux 2.6.8.
> I think the only distro to ship with SELinux enabled and Linux < 2.6.8
> would have been Fedora Core 2, which is long since EOL'd and even akpm
> doesn't run it anymore.  Not sure about Hardened Gentoo - Chris and/or
> Joshua?

No objection here.  Gentoo has several kernels, but none that old.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

We've agreed!

Best regards,

Octavian Ionescu
Å·çæËþÎ¬ÑÇ
Core Network TAC Engineer
 
Huawei Technologies Co. ,Ltd 
Mobile: +40726691157
E-mail: octavian.ionescu@huawei.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
