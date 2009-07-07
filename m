Date: Tue, 7 Jul 2009 22:48:16 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Thomas Liu <tliu@redhat.com>, selinux@tycho.nsa.gov, eparis@parisplace.org,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH 1/4 -v2] Namespacing of security/selinux
In-Reply-To: <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.0907072247380.15675@tundra.namei.org>
References: <1246906718.2460.12.camel@Ares>  <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil> <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Jul 2009, Stephen Smalley wrote:

> 1)  Create one patch that only renames security_ functions within
> selinux to sel_ or selinux_ (I don't care which; Paul seemed to prefer
> sel_ - James or Eric?).  That should be non-controversial and easy to
> merge.

sel_ gets the point across :-)


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
