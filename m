Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IKdXRb005226
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:39:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IKb9B2024596
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:37:09 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
	by jazzswing.ncsc.mil  with SMTP id i4IKb8wi024593
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:37:08 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 18 May 2004 19:53:49 -0000
Date: Tue, 18 May 2004 19:51:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518195106.GA7217@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil> <20040518130244.GB24917@lkcl.net> <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil> <20040518151112.GF24917@lkcl.net> <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 01:18:26PM -0400, Stephen Smalley wrote:
> >  do i end up with _only_ getattr permissions or do i end up
> >  with both read _and_ getattr?
> 
> checkpolicy takes the union of all such allow rules, so you end up with
> both read and getattr.  You can check at runtime via compute_av.  So you
> shouldn't still get denials, unless you aren't truly loading the new
> policy into the kernel or another factor (e.g. policy/constraints) is
> coming into play.  One common mistake is if your kernel isn't up-to-date
> and doesn't accept the latest policy version, you may be loading an
> older policy version, not the one you just compiled with your new
> checkpolicy.

 ah ha!

	tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t
	system_u:system_r:initrc_t shm
	allowed= { getattr read write associate unix_read unix_write }

 ha ha!

 okay, one lot disappeared, have another lot to deal with.

 so i think i might be on track, now.

 okay, this is what i get from audit2allow when the selinux programs
 (latest cvs, head tag) are compiled on the same kernel as wot i install
 on:


	allow crond_t lib_t:file { execute };
		#PATH=/lib/libselinux.so.1   :  execute

	allow hotplug_t dbusd_t:unix_stream_socket { connectto };
		#EXE=/usr/lib/hal/hal.hotplug  PATH=/var/run/dbus/system_bus_socket   :  connectto

	allow hotplug_t sysctl_net_t:file { getattr write };
		#EXE=/bin/bash  PATH=/proc/sys/net/ipv4/conf/all/rp_filter   :  getattr
		#EXE=/bin/bash  NAME=rp_filter   :  write

	allow hotplug_t unlabeled_t:file { getattr };
		#EXE=/bin/bash  PATH=/usr/sbin/usbmodules   :  getattr

	allow inetd_t smtp_port_t:tcp_socket { name_bind };
		#EXE=/usr/sbin/inetd   :  name_bind

	allow initrc_t dbusd_t:unix_stream_socket { connectto };
		#EXE=/usr/sbin/hald  PATH=/var/run/dbus/system_bus_socket   :  connectto

	allow initrc_t fonts_t:dir { read };
		#EXE=/usr/bin/gdmlogin  NAME=TrueType   :  read

	allow initrc_t fonts_t:file { read };
		#EXE=/usr/X11R6/bin/xfs-xtt  NAME=fonts.dir   :  read

	allow initrc_t initrc_t:tcp_socket { bind create listen setopt };
		#EXE=/usr/sbin/famd   :  create
		#EXE=/usr/sbin/famd   :  bind
		#EXE=/usr/sbin/famd  LADDR=127.0.0.1  LPORT=834   :  listen
		#EXE=/usr/bin/perl   :  setopt

	allow initrc_t initrc_t:udp_socket { listen };
		#EXE=/usr/bin/perl  LPORT=10000   :  listen

	allow initrc_t netif_lo_t:netif { udp_recv udp_send };
		#EXE=/usr/sbin/famd  SADDR=127.0.0.1  SRC=835  DADDR=127.0.0.1  DEST=111   :  udp_send
		#EXE=/sbin/portmap  SADDR=127.0.0.1  SRC=111  DADDR=127.0.0.1  DEST=835   :  udp_recv

	allow initrc_t node_inaddr_any_t:tcp_socket { node_bind };
		#EXE=/usr/bin/perl  SRC=10000   :  node_bind

	allow initrc_t node_inaddr_any_t:udp_socket { node_bind };
		#EXE=/usr/sbin/famd  SRC=835   :  node_bind
		#EXE=/usr/sbin/famd  SRC=836   :  node_bind

	allow initrc_t node_lo_t:node { udp_recv udp_send };
		#EXE=/usr/sbin/famd  SADDR=127.0.0.1  SRC=835  DADDR=127.0.0.1  DEST=111  NETIF=lo   :  udp_send
		#EXE=/sbin/portmap  SADDR=127.0.0.1  SRC=111  DADDR=127.0.0.1  DEST=835  NETIF=lo   :  udp_recv

	allow initrc_t node_lo_t:tcp_socket { node_bind };
		#EXE=/usr/sbin/famd  SADDR=127.0.0.1  SRC=834   :  node_bind

	allow initrc_t port_t:tcp_socket { name_bind };
		#EXE=/usr/sbin/famd   :  name_bind
		#EXE=/usr/bin/perl   :  name_bind

	allow initrc_t port_t:udp_socket { name_bind };
		#EXE=/usr/sbin/famd   :  name_bind
		#EXE=/usr/bin/perl   :  name_bind

	allow initrc_t portmap_port_t:udp_socket { recv_msg send_msg };
		#EXE=/usr/sbin/famd  SADDR=127.0.0.1  SRC=835  DADDR=127.0.0.1  DEST=111  NETIF=lo   :  send_msg
		#EXE=/sbin/portmap  SADDR=127.0.0.1  SRC=111  DADDR=127.0.0.1  DEST=835  NETIF=lo   :  recv_msg

	allow initrc_t readable_t:file { read };
		#EXE=/usr/bin/gdmlogin  NAME=fonts.conf   :  read

	allow initrc_t readable_t:lnk_file { read };
		#EXE=/usr/bin/gdmlogin  NAME=Bitstream-Vera-Sans.ttf   :  read

	allow initrc_t unlabeled_t:file { execute execute_no_trans ioctl read };
		#EXE=/bin/bash  NAME=makedev   :  execute
		#EXE=/bin/bash  PATH=/etc/init.d/makedev   :  execute_no_trans
		#EXE=/bin/bash  PATH=/etc/init.d/makedev   :  read
		#EXE=/bin/bash  PATH=/etc/init.d/makedev   :  ioctl

	allow initrc_t var_lib_t:dir { setattr };
		#EXE=/usr/bin/gdm  NAME=gdm   :  setattr

	allow initrc_t var_lib_t:fifo_file { create read setattr write };
		#EXE=/usr/bin/gdm  NAME=.gdmfifo   :  create
		#EXE=/usr/bin/gdm  NAME=.gdmfifo   :  read write
		#EXE=/usr/bin/gdm  NAME=.gdmfifo   :  setattr

	allow initrc_t var_log_t:dir { remove_name };
		#EXE=/usr/bin/gdm  NAME=:0.log   :  remove_name

	allow initrc_t var_log_t:file { link unlink };
		#EXE=/usr/bin/gdm  NAME=:0.log   :  link
		#EXE=/usr/bin/gdm  NAME=:0.log   :  unlink

	allow initrc_t var_spool_t:dir { read };
		#EXE=/usr/sbin/atd  NAME=atjobs   :  read

	allow initrc_t xdm_xserver_tmp_t:dir { setattr };
		#EXE=/usr/bin/gdm  NAME=.ICE-unix   :  setattr

	allow initrc_t xdm_xserver_t:unix_stream_socket { connectto };
		#EXE=/usr/bin/gdm  PATH=/tmp/.X11-unix/X0   :  connectto

	allow klogd_t boot_t:file { getattr read };
		#EXE=/sbin/klogd  NAME=System.map-2.6.6-selinux1   :  read
		#EXE=/sbin/klogd  PATH=/boot/System.map-2.6.6-selinux1   :  getattr

	allow local_login_t lib_t:file { execute };
		#PATH=/lib/libselinux.so.1   :  execute
		#PATH=/lib/libselinux.so.1   :  execute

	allow mount_t security_t:dir { mounton };
		#EXE=/bin/mount  PATH=/selinux   :  mounton

	allow syslogd_t unlabeled_t:dir { search };
		#EXE=/sbin/syslogd  NAME=news   :  search

	allow syslogd_t unlabeled_t:file { append ioctl };
		#EXE=/sbin/syslogd  NAME=news.crit   :  append
		#EXE=/sbin/syslogd  PATH=/var/log/news/news.crit   :  ioctl

	allow system_chkpwd_t lib_t:file { execute };
		#PATH=/lib/libselinux.so.1   :  execute

	allow system_chkpwd_t var_run_t:dir { search };
		#EXE=/sbin/unix_verify  NAME=run   :  search

	allow user_t staff_home_t:file { getattr read };
		#EXE=/bin/bash  NAME=.bash_profile   :  read
		#EXE=/bin/bash  PATH=/home/lkcl/.bash_profile   :  getattr

	allow xdm_xserver_t tmpfs_t:file { read write };
		#PATH=/SYSV00000000   :  read write


wheeee :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
