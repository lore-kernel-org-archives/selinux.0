Subject: Re: [ PATCH ] hal - create netlink socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1111905173.3520.8.camel@cobra.ivg2.net>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:27:55 -0500
Message-Id: <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-27 at 01:32 -0500, Ivan Gyurdiev wrote:
> Makes hal work again on my system....sort of
> 
> /usr/libexec/hald-probe-input denied { read } on mouse_device_t:chr_file
> /usr/libexec/hald-addon-acpi denied { write } on acpid.socket
> (apmd_var_run_t)
> /usr/libexec/hald-add-selinux-mount-option denied { search } on /selinux
> (security_t)
> /usr/sbin/hald denied { getattr } on /dev/mapper/control (lvm_control_t)
> /usr/sbin/dmidecode denied { read } on /dev/mem (memory_device_t)

Class 'netlink_socket' is the catch-all for netlink protocols that have
no individual security class.  Can you remove this permission from your
policy and enable syscall auditing via auditctl (or boot with audit=1)
and try again so we can see the actual netlink protocol value that was
used?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
