Subject: Re: Problems with /dev/tty on reboot.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <3FC4AF2B.3060301@redhat.com>
References: <3FC4AF2B.3060301@redhat.com>
Content-Type: text/plain
Message-Id: <1069856081.30315.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 09:14:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-26 at 08:48, Daniel J Walsh wrote:
> How should we handle the situation where contexts end up in the wrong 
> contexts because of crashes or reboots.
> 
> Currently if you login to a box as user_t, and then the system crashes 
> or you reboot the /dev/tty has the wrong context on it, so if the next 
> user that attempts to login has staff_t he will not be able to gain 
> access to the device.  I have put a
> setfiles file_context /dev/tty in my rc scripts as a stop gap, but that 
> is not a clean solution.  Also this can probably happen to other files 
> that have their contexts changed by running processes.  Ideas on how to 
> solve this problem??

The same issue should exist for the uid/gid on the tty; I would expect
that getty resets the owner on the tty to avoid this problem, so you
could likewise have getty reset the label.  In the past, we worked
around the problem by providing broader type_change rules in the policy,
e.g.
	type_change staff_t ttyfile:chr_file staff_tty_device_t;

I'm not sure why these were removed.  In fact, I see the general form of
this rule in policy/macros/user_macros.te, as:
	type_change $1_t ttyfile:chr_file $1_tty_device_t;
but it is within an ifdef(`dpkg.te') block for some reason.

Note:  type_change rules just indicate what new type to use when
relabeling an existing file with a given type for a process with a given
domain.  Programs like login use the security_compute_relabel()
interface to obtain the new context for the tty, and this new context is
computed based on the type_change rules.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
