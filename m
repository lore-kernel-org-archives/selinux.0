Subject: Re: [PATCH] selinux_set_file_paths function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <200510251258.34894.csellers@tresys.com>
References: <200510251258.34894.csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 13:59:00 -0400
Message-Id: <1130263140.17609.388.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 12:58 -0400, Chad Sellers wrote:
> Attached is a patch to libselinux that moves the setting of file_paths[] out 
> of init_selinux_config and into its own exported function.  This allows a 
> caller to reset those paths to an alternate policy type for getting paths of 
> files in that alternate policy type.  The patch also includes a patch to 
> semanage_install_active in libsemanage to use this function rather than 
> hacking the strings returned by libselinux.

I'm not sure about the approach.  Some thoughts:
- You are changing the libselinux file paths _except_ for the policy
root, which you preserve for restoring the original values.  This leaves
the paths in an inconsistent state.  If the approach were retained, I'd
suggest saving the original type for restoration purposes, but setting
policy root consistent with the other paths.  In that case, setting of
selinux_policyroot moves into your new function as well and the code is
a bit simpler.
- Since you are changing the paths, any libselinux function that
internally opens one of these paths will use the new path after a set
has been performed, so it has side effects beyond just the functions
that get paths.  Not sure if that is a feature or a bug ;)
- Since the paths are global state of libselinux, if the caller is
multi-threaded, then all threads will be affected (and the transition
period isn't safe).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
