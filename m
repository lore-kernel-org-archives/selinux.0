Subject: Re: Fixfiles using new setfiles/restorecon simplification
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4B8726DA.8040806@manicmethod.com>
References: <4B85902B.70300@redhat.com>  <4B8726DA.8040806@manicmethod.com>
Content-Type: text/plain
Date: Fri, 26 Feb 2010 07:56:22 -0500
Message-Id: <1267188982.7691.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-02-25 at 20:41 -0500, Joshua Brindle wrote:
> What version of the kernel was this added in? I don't want to completely 
> break old kernels using new toolchains (CLIP backports toolchains to 
> RHEL 4 and 5). It would be better to use seclabel if it is there, 
> otherwise fall back to the old list.

setfiles internally checks for >= 2.6.30 and will only exclude
non-seclabel mounts in that case.

With the newer setfiles + kernel >= 2.6.30, you can actually relabel all
filesystems just by running restorecon -R / and letting it auto-exclude
filesystems that do not support labeling rather than needing to
enumerate the mount points for labeled filesystems to setfiles.  So
maybe fixfiles should just do that if the kernel >= 2.6.30.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
