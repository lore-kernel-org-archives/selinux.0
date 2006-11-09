Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and
	permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0611071620140.21330@d.namei>
References: <C1751E53.19473%csellers@tresys.com>
	 <1162933056.3009.62.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0611071620140.21330@d.namei>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:36:11 -0500
Message-Id: <1163086571.12241.310.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-07 at 16:20 -0500, James Morris wrote:
> On Tue, 7 Nov 2006, Stephen Smalley wrote:
> 
> > (re-added list to cc)
> 
> Thanks.
> 
> Stephen, do you think these patches are suitable for merging?

Yes.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

We should also follow up with a patch that strips the non-kernel classes
and permissions from the kernel headers (possibly by modifying the
script in policy to emit two sets of headers, one for kernel and one for
libselinux, based on the already existing # userspace annotations in
security_classes).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
