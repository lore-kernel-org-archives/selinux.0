Subject: Re: [ PATCH ] hal - create netlink socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112030817.3350.6.camel@cobra.ivg2.net>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
	 <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
	 <1112029334.3350.2.camel@cobra.ivg2.net>
	 <1112029488.2914.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1112030817.3350.6.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 12:37:53 -0500
Message-Id: <1112031473.2914.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 12:26 -0500, Ivan Gyurdiev wrote:
> What about all the other denials?
> 
> That last one violates an assertion if allowed.
> 
> /usr/libexec/hald-probe-input denied { read } on mouse_device_t:chr_file
> /usr/libexec/hald-addon-acpi denied { write } on acpid.socket
> (apmd_var_run_t)
> /usr/libexec/hald-add-selinux-mount-option denied { search } on /selinux
> (security_t)

These look reasonable to allow, given the assumed purpose of the
corresponding hald helper.  I'd expect that you'll also get other
denials once you allow these permissions, e.g. to allow the Unix domain
connection or send, and to allow checking for a specific file
under /selinux.

> /usr/sbin/hald denied { getattr } on /dev/mapper/control (lvm_control_t)
> /usr/sbin/dmidecode denied { read } on /dev/mem (memory_device_t)

I don't know about these, and the last one is of course a definite
concern.  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
