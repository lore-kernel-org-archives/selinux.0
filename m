Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74FR4rT029032
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 11:27:04 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74FQUVf021982
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 15:26:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i74FQue1022339
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 11:26:56 -0400
Message-ID: <4111003F.7070500@redhat.com>
Date: Wed, 04 Aug 2004 11:26:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@redhat.com>
CC: rcoker@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [patch] allow rpm_t to create/relabel device files too
References: <1091633163.9005.26.camel@nexus.verbum.private>
In-Reply-To: <1091633163.9005.26.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>Hi,
>
>The attached patch allows rpm_t to create/relabel device files - I
>needed this when upgrading the "dev" package on my system.  I'm
>surprised this hasn't been caught before, maybe I missed something.
>
>Some AVC messages for reference:
>
>Aug  4 11:11:43 decepticon kernel: audit(1091632303.691:0): avc:  denied  { getattr } for  pid=31094 exe=/usr/bin/python path=/dev/dri dev=sda2 ino=10111422 scontext=root:sysadm_r:rpm_t tcontext=system_u:object_r:dri_device_t tclass=dir
>Aug  4 11:16:50 decepticon kernel: audit(1091632610.920:0): avc:  denied  { relabelfrom } for  pid=31149 exe=/usr/bin/python name=dri dev=sda2 ino=10111422 scontext=root:sysadm_r:rpm_t tcontext=system_u:object_r:dri_device_t tclass=dir
>
>  
>
The /dev/dri directory is mislabled.  It should be device_t.  The latest 
policy fixes this.

Dan

>------------------------------------------------------------------------
>
>--- policy-1.15.11/domains/program/unused/rpm.te~	2004-07-31 06:22:37.000000000 -0400
>+++ policy-1.15.11/domains/program/unused/rpm.te	2004-08-04 11:20:40.165411688 -0400
>@@ -90,9 +90,9 @@
> general_domain_access(rpm_script_t)
> 
> # read/write/create any files in the system
>-allow rpm_t { file_type - shadow_t }:{ file lnk_file dir fifo_file sock_file chr_file blk_file } { relabelfrom relabelto };
>-allow rpm_t { file_type - shadow_t }:dir create_dir_perms;
>-allow rpm_t { file_type - shadow_t }:{ file lnk_file fifo_file sock_file chr_file blk_file } create_file_perms;
>+allow rpm_t { file_type device_type -shadow_t }:{ file lnk_file dir fifo_file sock_file chr_file blk_file } { relabelfrom relabelto };
>+allow rpm_t { file_type device_type - shadow_t }:dir create_dir_perms;
>+allow rpm_t { file_type device_type - shadow_t }:{ file lnk_file fifo_file sock_file chr_file blk_file } create_file_perms;
> allow rpm_t sysfs_t:filesystem getattr;
> allow rpm_t tmpfs_t:filesystem getattr;
> dontaudit rpm_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
