Subject: Re: SELinux for embedded devices...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Sriram, Kannan" <ksriram@ti.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com>
References: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 09:10:57 -0400
Message-Id: <1122642657.6573.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 07:50 +0530, Sriram, Kannan wrote:
> 1. Is SELinux applicable and suitable for mobile equipment, where the
> end user always has root privileges? Has SELinux been ported to any
> embedded device yet (some ARM platform??).

As to the first question, being able to confine exploits of flaws in
applications on such devices is important, because you may not be able
to update software on those devices very quickly or easily.  That is a
separate issue from controlling what the end user of the device can do.
As to the latter question, earlier versions of SELinux (before we
migrated to using extended attributes for file security labels) were
successfully ported to the iPAQ.  The current version of SELinux
shouldn't have any architecture-specific issues, but there is the
problem of having a labeled filesystem, as others have noted.  In the
short term, one could take the reiserfs approach of implementing xattrs
as regular files hidden from userspace to avoid changing the filesystem
format for jffs2 et al, but that isn't the desired approach for
upstream.  

> 2. Assuming I have made the kernel on the flash to be tamperproof (can't
> replace the SElinux image on the flash with the "SE" part disabled),
> isn't  it still possible at runtime to disable the security server?
> 
> 3. Same as above, is it possible to change the security policy files, or
> reload a different set of policies (given root access).
> 
> And now the big question, is there a way to prevent both (2) and (3)??
> Or have I completely misunderstood the whole thing??

Do you want to prevent such tampering, or just be able to subsequently
perform remote attestation that the device is running an approved
software stack and configuration before giving the device access to some
remote resource?

In any event, the kernel could certainly be modified to check (or just
measure, depending on what you want to achieve above) the integrity
of /sbin/init prior to executing it and of the policy prior to loading
it, and likewise for any other security-critical dependencies that may
exist.  And the kernel can be configured to turn off various options
such as CONFIG_SECURITY_SELINUX_BOOTPARAM,
CONFIG_SECURITY_SELINUX_DISABLE, and CONFIG_SECURITY_SELINUX_DEVELOP, so
that selinux=0, enforcing=0 and /selinux/disable are all rendered
unuseable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
