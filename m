Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RKx0rT022897
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 16:59:00 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RKwDpX022643
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 20:58:13 GMT
Subject: Re: policy patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408241818.40064.russell@coker.com.au>
References: <200408241818.40064.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 16:58:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Also added:
	allow hotplug_t udev_helper_exec_t:lnk_file read;
It seems reasonable and I was seeing a lot of denials, but it might be
possible to use a dontaudit.

On Tue, 2004-08-24 at 04:18, Russell Coker wrote:
> diff1 removes some unnecessary dontaudit lines from syslogd.te, if there is to 
> be one single domain accessing devpts_t:chr_file then syslogd_t is not it, 
> and if a log file gets type unlabeled_t then it's something we want audited.
> 
> httpd_t does not need search access to devpts_t (it is not granted access to 
> any device node under /dev/pts).  httpd_suexec_t does not need 
> net_bind_service (all it does it call setuid() and execute a script), it's 
> access attempts of /var/run are the usual nscd stuff that gets a dontaudit 
> rule.
> 
> It seems that only Red Hat has bootloader_t needing access to 
> modules_object_t:lnk_file.
> 
> cpucontrol_t sometimes needs getattr access to a sym-link in /dev, no harm in 
> granting it.
> 
> There should never be a printer_device_t:fifo_file object, there is no 
> file_contexts entry assigning printer_device_t to a fifo_file object, so I 
> remove the access to this invalid combination.
> 
> dovecot_cert_t is used for SSL certificates.  If there are any certificates 
> labeled as usr_t then that's a bug in the file_contexts file.  I'll change 
> the contexts of the files to use bin_t for sub-binaries on Debian as well as 
> Red Hat (as well as putting some conditionals into the .fc file).
> 
> I changed ftpd.te to have the domain_auto_trans(inetd, part inside 
> if(!ftpd_is_daemon).
> 
> Change hald.te to work with the latest version in Fedora.  I didn't want to 
> give it read access to hard disks, but it seems that's he way things are 
> going.
> 
> Changed hotplug.te to allow it to run arping on Red Hat, and to be a hald 
> client (maybe we need a hald_client_domain attribute).
> 
> Allows lvm_t to create unix_dgram_socket objects.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
