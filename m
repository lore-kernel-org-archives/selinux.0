Subject: Re: Another change we would like to make to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <4F44114F.4080005@redhat.com>
References: <4F3D16EF.6080904@redhat.com>
	 <1329857024.12501.85.camel@moss-pluto>  <4F44114F.4080005@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Feb 2012 08:29:13 -0500
Message-ID: <1329917353.15569.8.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-21 at 16:49 -0500, Daniel J Walsh wrote:
> Right now we added selinux_current_policy_path and we are using it as
> the default for seinfo, audit2allow, sepolgen-ifgen

I'm not sure this is a good idea to always use it, as it is definitely
more costly to generate the policy image in the kernel than to just read
the policy file.  I had only envisioned it being used by tools that want
to verify that the kernel policy matches the policy file.

> It currently looks like
> 
> const char *selinux_current_policy_path(void)
> {
> 	int rc = 0;
> 	int vers = 0;
> 	static char policy_path[PATH_MAX];
> 
> 	snprintf(policy_path, sizeof(policy_path), "%s/policy", selinux_mnt);
> 	if (access(policy_path, F_OK) != 0 ) {
> 		vers = security_policyvers();

The selinux_mkload_policy() logic starts with
sepol_policy_kern_vers_max() rather than security_policyvers() if
libsepol is available, since it can downgrade the policy file via
libsepol to the kernel version.  So your logic may end up using the
wrong policy file.

> 		do {
> 			/* Check prior versions to see if old policy is available */
> 			snprintf(policy_path, sizeof(policy_path), "%s.%d",
> 				 selinux_binary_policy_path(), vers);
> 		} while ((rc = access(policy_path, F_OK)) && --vers > 0);
> 
> 		if (rc) return NULL;
> 	}
> 
> 	return policy_path;
> }


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
