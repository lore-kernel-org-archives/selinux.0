Subject: Re: login messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
Content-Type: text/plain
Message-Id: <1065457196.3919.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Oct 2003 12:19:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-06 at 10:35, Kratzer, James R. wrote:
> When I login as my user, I get the following messages.   Is this normal and
> can someone explain what they mean?  When I log in as root, I do not get
> these messages.
> 
> Your default context is jamesk:user_r:user_t
> Keymap 0: Permission denied
> Keymap 1: Permission denied
> Keymap 2: Permission denied
> KDSKBENT: Operation not permitted
> loadkeys: could not deallocate keymap 3

Yes, I see this as well.  SELinux checks the CAP_SYS_TTY_CONFIG
capability for the KDSKBENT and KDSKBSENT ioctls to prevent unprivileged
processes from changing the keyboard mapping.  See
http://marc.theaimsgroup.com/?l=selinux&m=103122430232003&w=2.
So the attempt to run loadkeys is going to fail; it needs to be called
from a more trusted context to set up the authorized mappings.

> When I then try to switch to the sysadm role from the user role, I get the
> following message.  In my policy "user" file, I have jamesk set for {
> staff_r sysadm_r } roles.  Why can't I switch?
> 
> # newrole -r sysadm_r
> jamesk:sysadm_r:sysadm_t is not a valid context

The fact that your default context was jamesk:user_r:user_t shows that
the actual policy loaded into your kernel is not what you describe,
since you don't even list user_r above.  So you likely changed your
policy and forgot to reload it, or you changed your policy but didn't
rebuild the initrd and have subsequently rebooted, thus loading the old
policy from the initrd.

Russell has suggested loading only a minimal policy from the initrd and
then loading a full policy from the disk via a change to
/etc/rc.d/rc.sysinit to mount /selinux and then run load_policy on the
policy file on the disk.  This allows you to make changes to the policy
that aren't relevant to the initialization prior to rc.sysinit without
needing to rebuild your initrd each time.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
