Subject: Re: [PATCH 1/3] Move variable function in lsm_audit.h into SMACK
 private space
From: Eric Paris <eparis@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Thomas Liu <tliu@redhat.com>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, eparis@parisplace.org,
        etienne.basset@numericable.fr
In-Reply-To: <4A55FBFC.20306@schaufler-ca.com>
References: <1247148029.2276.9.camel@Ares> <4A55FBFC.20306@schaufler-ca.com>
Content-Type: text/plain
Date: Thu, 09 Jul 2009 10:23:22 -0400
Message-Id: <1247149402.2830.16.camel@dhcp235-23.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-09 at 07:17 -0700, Casey Schaufler wrote:
> Thomas Liu wrote:
> > Moved variable function in include/linux/lsm_audit.h into the
> > smack_audit_data struct since it is never used outside of it.
> >   
> 
> What value does this change provide?

By itself, none other than proper abstracting.  ->function is a smack
specific object so it shouldn't be in the generic space.  Along with
patch #3 it saves memory on systems that choose to build without SMACK.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
