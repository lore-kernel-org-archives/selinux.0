Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VA6RrT010938
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 06:06:28 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VA6O5m017578
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 10:06:24 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 072D6BF08
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 11:06:14 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C25hl-0002y3-Ue
	for selinux@tycho.nsa.gov; Tue, 31 Aug 2004 11:17:33 +0100
Date: Tue, 31 Aug 2004 11:17:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /dev entries which also need to be /.?u?dev'd
Message-ID: <20040831101733.GC2098@lkcl.net>
References: <20040831101602.GB2098@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <20040831101602.GB2098@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

duh.  having gone to the trouble of producing the list, _let's_ attach
it, shall we?

 :)

 l.

On Tue, Aug 31, 2004 at 11:16:02AM +0100, Luke Kenneth Casson Leighton wrote:
> the following entries presently marked as /dev need, imo, to also
> be modified to be ":%s/\/dev/\/.?u?dev/g" [in vi].
> 
> the reason is as i explained that if someone using udev [with or
> without tmpfs] does a
> 
> 	setfiles /etc/selinux/src/file_contexts/file_contexsts /.dev
> 
> then they are buggered, without the above.
> 
> for example, /.dev/initctl will suddenly end up with a default_t
> type such that bootup will fail!
> 
> also /dev/.udev.tdb was set to default_t as well which could
> have caused problems.
> 
> it's all gone pear-shaped, gloop, gloop.
> 
> l.

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

program/gpm.fc:/dev/gpmctl		-s	system_u:object_r:gpmctl_t
program/gpm.fc:/dev/gpmdata		-p	system_u:object_r:gpmctl_t
program/init.fc:/dev/initctl		-p	system_u:object_r:initctl_t
program/lpd.fc:/dev/printer		-s	system_u:object_r:printer_t
program/lpd.fc:/dev/lp.*		-c	system_u:object_r:printer_device_t
program/lpd.fc:/dev/par.*		-c	system_u:object_r:printer_device_t
program/lpd.fc:/dev/usb/lp.*		-c	system_u:object_r:printer_device_t
program/lpd.fc:/dev/usblp.*		-c	system_u:object_r:printer_device_t
program/lvm.fc:/dev/lvm		-c	system_u:object_r:fixed_disk_device_t
program/lvm.fc:/dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t
program/lvm.fc:/dev/mapper/control	-c	system_u:object_r:lvm_control_t
program/pppd.fc:/dev/ppp		-c	system_u:object_r:ppp_device_t
program/pppd.fc:/dev/pppox.*		-c	system_u:object_r:ppp_device_t
program/pppd.fc:/dev/ippp.*		-c	system_u:object_r:ppp_device_t
program/syslogd.fc:/dev/log		-s	system_u:object_r:devlog_t
program/udev.fc:/dev/udev.tbl	--	system_u:object_r:udev_tbl_t
program/udev.fc:/dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
program/vmware.fc:/dev/vmmon		-c	system_u:object_r:vmware_device_t
program/vmware.fc:/dev/vmnet.*		-c	system_u:object_r:vmware_device_t
program/vmware.fc:/dev/plex86		-c	system_u:object_r:vmware_device_t
program/watchdog.fc:/dev/watchdog		-c	system_u:object_r:watchdog_device_t
program/xserver.fc:/dev/agpgart		-c	system_u:object_r:agp_device_t
program/xserver.fc:/dev/dri/.*		-c	system_u:object_r:dri_device_t
program/xserver.fc:/dev/nvidia.*        		system_u:object_r:xserver_misc_device_t

--azLHFNyN32YCQGCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
