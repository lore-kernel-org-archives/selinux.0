Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NDtoEi013124
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:50 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NDtm3O001080
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 13:55:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l6NDtGLP016153
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:16 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l6NDtG3i016152
	for selinux@tycho.nsa.gov; Mon, 23 Jul 2007 09:55:16 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KJbCik019914
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 15:37:12 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6KJbB2i027801
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 19:37:11 GMT
Date: Fri, 20 Jul 2007 15:32:16 -0400
Subject: [RFC][PATCH 00/01]qemu VM entrypoints
From: David Windsor <dwindsor@tresys.com>
To: selinux <selinux@tycho.nsa.gov>,
        kvm-devel <kvm-devel@lists.sourceforge.net>
CC: Joshua Brindle <jbrindle@tresys.com>
Message-ID: <C2C68600.366D%dwindsor@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

After a bit more discussion about integrating SELinux and KVM, it seems that
there is little interest in adding enforcement hooks to KVM as it stands.
Once KVM gets some type of inter-vm communication mechanism, MAC hooks will
probably be added in that space.

Until then, there seems to be interest in adding MAC controls to control VM
management operations, such as migrating VMs, or saving/resuming VMs.

One particular aspect of VM management which may be nice to control via
SELinux is the loading of a virtual hard disk into a VM.  Currently,
administrators would have to rely on file permissions to control which files
could be used as a virtual hard disks.  The semantics of file permissions do
not accomplish what is needed here.  A domain needs to explicitly get
permission from the policy to both use a file as a virtual disk and to use
the contents of that virtual disk as an "entrypoint" to the new, virtual
machine of a different integrity level.

Since there is no SELinux permission for this, I have created the vm {
entrypoint } object class/permission pair to represent this type of access.
Policy for allowing domain user_t to load a virtual disk of type
qemu_virtdisk_t would look something like:

allow user_t qemu_virtdisk_t:file r_file_perms;
type_change user_t qemu_virtdisk_t:vm vm_user_t;
allow qemu_virtdisk_t user_vm_t:vm entrypoint;

Please note that this patch will only check the entrypoint permission, and
does not actually facilitate transitioning on the type of the virtual disk.
I want some comments before continuing with this approach.

When loading a virtual disk into a VM, qemu would consult the policy to see
essentially three things: if the current process is allowed to read the
virtual disk file, what the type of the VM should be after loading the disk,
and if the virtual disk is in fact allowed to serve as an entrypoint to the
target domain.

One problem with this approach is that loading a VM is not an exec-based
operation.  Dynamic transitions could be used, but could possibly be avoided
by altering the patch to fork, then re-exec in the target domain.

This patch applies cleanly to kvm-userspace trunk.

Thoughts?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
