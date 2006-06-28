Subject: [PATCH 3/3] usb core:  Save and pass the sending task SID when
	sending
From: David Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 16:34:47 -0400
Message-Id: <1151526887.13601.13.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch updates the USB core to save and pass the sending task secid
when sending signals upon AIO completion so that proper security
checking can be applied by security modules.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
---

 drivers/usb/core/devio.c |    6 +++++-
 drivers/usb/core/inode.c |    2 +-
 drivers/usb/core/usb.h   |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/devio.c linux-2.6.17-mm3-kill/drivers/usb/core/devio.c
--- linux-2.6.17-mm3/drivers/usb/core/devio.c	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/devio.c	2006-06-28 14:32:30.000000000 -0400
@@ -47,6 +47,7 @@
 #include <linux/usbdevice_fs.h>
 #include <linux/cdev.h>
 #include <linux/notifier.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
@@ -68,6 +69,7 @@ struct async {
 	void __user *userbuffer;
 	void __user *userurb;
 	struct urb *urb;
+	u32 secid;
 };
 
 static int usbfs_snoop = 0;
@@ -312,7 +314,7 @@ static void async_completed(struct urb *
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
 		kill_proc_info_as_uid(as->signr, &sinfo, as->pid, as->uid, 
-				      as->euid);
+				      as->euid, as->secid);
 	}
 	snoop(&urb->dev->dev, "urb complete\n");
 	snoop_urb(urb, as->userurb);
@@ -572,6 +574,7 @@ static int usbdev_open(struct inode *ino
 	ps->disc_euid = current->euid;
 	ps->disccontext = NULL;
 	ps->ifclaimed = 0;
+	security_task_getsecid(current, &ps->secid);
 	wmb();
 	list_add_tail(&ps->list, &dev->filelist);
 	file->private_data = ps;
@@ -1053,6 +1056,7 @@ static int proc_do_submiturb(struct dev_
 	as->pid = current->pid;
 	as->uid = current->uid;
 	as->euid = current->euid;
+	security_task_getsecid(current, &as->secid);
 	if (!(uurb->endpoint & USB_DIR_IN)) {
 		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->transfer_buffer_length)) {
 			free_async(as);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/inode.c linux-2.6.17-mm3-kill/drivers/usb/core/inode.c
--- linux-2.6.17-mm3/drivers/usb/core/inode.c	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/inode.c	2006-06-28 14:33:00.000000000 -0400
@@ -700,7 +700,7 @@ static void usbfs_remove_device(struct u
 			sinfo.si_errno = EPIPE;
 			sinfo.si_code = SI_ASYNCIO;
 			sinfo.si_addr = ds->disccontext;
-			kill_proc_info_as_uid(ds->discsignr, &sinfo, ds->disc_pid, ds->disc_uid, ds->disc_euid);
+			kill_proc_info_as_uid(ds->discsignr, &sinfo, ds->disc_pid, ds->disc_uid, ds->disc_euid, ds->secid);
 		}
 	}
 }
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/usb.h linux-2.6.17-mm3-kill/drivers/usb/core/usb.h
--- linux-2.6.17-mm3/drivers/usb/core/usb.h	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/usb.h	2006-06-28 14:33:46.000000000 -0400
@@ -80,6 +80,7 @@ struct dev_state {
 	uid_t disc_uid, disc_euid;
 	void __user *disccontext;
 	unsigned long ifclaimed;
+	u32 secid;
 };
 
 /* internal notify stuff */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
