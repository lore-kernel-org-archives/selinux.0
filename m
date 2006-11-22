Subject: Re: do SELinux write/read permission checks exist?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4564557F.7030009@us.ibm.com>
References: <4564557F.7030009@us.ibm.com>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 09:36:58 -0500
Message-Id: <1164206218.13758.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-22 at 07:49 -0600, Michael C Thompson wrote:
> So, I've managed to loose track of this in my mind, but does SELinux do 
> permission checks for sys_read and sys_write?

Yes, they are covered by the security_file_permission ->
selinux_file_permission hooks.  However, for SELinux, those checks are
only for revalidation purposes to support revocation upon file relabels
or policy changes (and such revocation support is incomplete, e.g.
memory-mapped files, in-progress operations).  

A check should always be applied when a descriptor is obtained by a
process, e.g. the SELinux checking on open (selinux_inode_permission),
descriptor inheritance across execve (selinux_bprm_post_apply_creds),
and descriptor transfer across local IPC (selinux_file_receive), so that
a process can never obtain a descriptor for which it is not authorized.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
