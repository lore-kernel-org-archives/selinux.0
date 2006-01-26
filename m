Subject: Re: API for getting loginuid, for use by newrole and run_init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: redhat-lspp@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1138195675.20815.318.camel@moss-spartans.epoch.ncsc.mil>
References: <1138109451.20815.205.camel@moss-spartans.epoch.ncsc.mil>
	 <200601241004.37638.sgrubb@redhat.com>
	 <1138195675.20815.318.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 09:18:04 -0500
Message-Id: <1138285084.13075.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 08:27 -0500, Stephen Smalley wrote:
> First cut at patches below.  The Makefile diffs use the same approach
> that was used for the conditional pam support, as policycoreutils
> doesn't use auto* and I'm not inclined to change that.  With these
> patches applied, I can use newrole -r sysadm_r when my Linux user is
> mapped to staff_u via seusers; it properly re-authenticates me as sds.
> Look sane?

These patches went into policycoreutils 1.29.11, which is now in rawhide
as well.  Hence, newrole and run_init in rawhide now re-authenticate
based on the loginuid.

Need to add audit-libs to Requires and audit-libs-devel to BuildRequires
for policycoreutils in the spec file.

I'm not sure whether you can just re-use the USE_AUDIT support I
introduced as part of this patch for your code that adds an audit
message to newrole, or whether you need a separate #ifdef for your
patch.  The issue is that whereas my patch works fine on vanilla
rawhide, I think your patch still depends on patches that are only in
the LSPP kernel.  So either your patch needs to gracefully recover if it
cannot generate an audit message due to an unpatched kernel (so rawhide
users can still use newrole) or we can't build your patch into the
rawhide version of newrole and will need a separately built version for
LSPP testing until the kernel patches go upstream and are included in
rawhide.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
