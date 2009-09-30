Date: Thu, 1 Oct 2009 07:46:18 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
In-Reply-To: <1254315215.30591.18.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.0910010745180.30576@tundra.namei.org>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>  <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>  <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>  <4AC2C32D.3010405@ak.jp.nec.com>  <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>
 <1254315215.30591.18.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Sep 2009, Stephen Smalley wrote:

> Does anyone think we still need to support policy versions <
> POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
> dynamic remapping of netlink classes in the security server:
>         if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
>                 if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
>                     tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
>                         tclass = SECCLASS_NETLINK_SOCKET;
> 
> I think RHEL4 shipped with policy.18.

Was any distro shipped with a lower policy version?  If not, then I think 
it should be ok.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
