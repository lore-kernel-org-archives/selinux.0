Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i616CLrT004555
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 02:12:21 -0400 (EDT)
Received: from audiogram.mail.pas.earthlink.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i616C5P8003082
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 06:12:05 GMT
Received: from h-68-164-213-183.atlngahp.dynamic.covad.net ([68.164.213.183] helo=mindspring.com)
	by audiogram.mail.pas.earthlink.net with asmtp (Exim 4.34)
	id 1Bfunz-00066q-Hc
	for selinux@tycho.nsa.gov; Wed, 30 Jun 2004 23:12:20 -0700
Message-ID: <40E3AB39.9040804@mindspring.com>
Date: Thu, 01 Jul 2004 02:12:09 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Fwd: additions to strict policy]
Content-Type: multipart/mixed;
 boundary="------------030500070001020008000207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030500070001020008000207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Below is a message the was sent to the Fedora-selinux-list. Perhaps some 
of these allow rules can be added to the NSA example policy.
Thanks,
Richard Hally

-------- Original Message --------
Subject: additions to strict policy
Date: Tue, 29 Jun 2004 02:14:17 -0400
From: Richard Hally <rhallyx@mindspring.com>
Reply-To: Fedora SELinux support list for users & developers. 
<fedora-selinux-list@redhat.com>
To: fedora-selinux-list@redhat.com

Below (and as an attached file) are some policy allow rules to be added
to the strict policy.
These allow rules were developed by running the latest /devel tree using
selinux-policy-strict-sources-1.13.10-3 and putting the resulting avc
denied messages through audit2allow.
Most are necessary to perform normal operations while in  enforcing mode.
Some of the rules marked "#from booting" may be candidates for dontaudit
rules.

Thanks for the help,
Richard Hally

#from " logrotate -f /etc/logrotate.conf" while root(sysadm_r)
allow logrotate_t devpts_t:dir { search };
allow logrotate_t initrc_t:process { transition };
allow logrotate_t mysqld_log_t:file { execute };
allow logrotate_t mysqld_log_t:file { execute_no_trans };
allow logrotate_t privoxy_log_t:file { execute };
allow logrotate_t privoxy_log_t:file { execute_no_trans };
allow logrotate_t selinux_config_t:dir { search };
allow logrotate_t selinux_config_t:file { getattr read };
allow logrotate_t staff_home_dir_t:dir { read search };
allow logrotate_t var_t:file { getattr };
allow logrotate_t var_t:file { read };

# from booting
allow lvm_t file_t:dir { getattr read };
allow mount_t ptmx_t:chr_file { read write };
allow mount_t rhgb_gph_t:fd { use };
allow mount_t rhgb_t:unix_stream_socket { read write };
allow rhgb_t staff_home_dir_t:dir { search };
# from booting
allow udev_t dbusd_t:unix_stream_socket { connectto };
allow udev_t dbusd_var_run_t:dir { search };
allow udev_t dbusd_var_run_t:sock_file { write };
allow udev_t file_t:dir { search };
 


# from exe=/usr/bin/mDNSResponder during boot
allow user_t dns_port_t:udp_socket { name_bind };

# from starting mozilla as staff_r
allow staff_mozilla_t file_t:dir { getattr };
allow staff_mozilla_t staff_home_t:file { unlink };
allow staff_mozilla_t xdm_tmp_t:dir { search };

# from normal gnome session as staff_r
allow staff_screensaver_t xdm_tmp_t:dir { search };
allow staff_screensaver_t xdm_tmp_t:sock_file { write };
allow staff_t file_t:dir { getattr };
allow staff_t staff_t:netlink_route_socket { create };

#from starting postgresql server during boot and using postgresql as user.
allow initrc_su_t postgresql_db_t:dir { search };
allow user_t postgresql_db_t:dir { add_name getattr read remove_name
search write };
allow user_t postgresql_db_t:file { create getattr read rename unlink
write };
allow staff_t user_tmp_t:sock_file { write };
allow staff_t user_t:unix_stream_socket { connectto };




--------------030500070001020008000207
Content-Type: text/plain;
 name="addthese.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="addthese.te"

#from " logrotate -f /etc/logrotate.conf" while root(sysadm_r) 
allow logrotate_t devpts_t:dir { search };
allow logrotate_t initrc_t:process { transition };
allow logrotate_t mysqld_log_t:file { execute };
allow logrotate_t mysqld_log_t:file { execute_no_trans };
allow logrotate_t privoxy_log_t:file { execute };
allow logrotate_t privoxy_log_t:file { execute_no_trans };
allow logrotate_t selinux_config_t:dir { search };
allow logrotate_t selinux_config_t:file { getattr read };
allow logrotate_t staff_home_dir_t:dir { read search };
allow logrotate_t var_t:file { getattr };
allow logrotate_t var_t:file { read };

# from booting
allow lvm_t file_t:dir { getattr read };
allow mount_t ptmx_t:chr_file { read write };
allow mount_t rhgb_gph_t:fd { use };
allow mount_t rhgb_t:unix_stream_socket { read write };
allow rhgb_t staff_home_dir_t:dir { search };
# from booting
allow udev_t dbusd_t:unix_stream_socket { connectto };
allow udev_t dbusd_var_run_t:dir { search };
allow udev_t dbusd_var_run_t:sock_file { write };
allow udev_t file_t:dir { search };
                                                                                
# from exe=/usr/bin/mDNSResponder during boot
allow user_t dns_port_t:udp_socket { name_bind };

# from starting mozilla as staff_r
allow staff_mozilla_t file_t:dir { getattr };
allow staff_mozilla_t staff_home_t:file { unlink };
allow staff_mozilla_t xdm_tmp_t:dir { search };

# from normal gnome session as staff_r
allow staff_screensaver_t xdm_tmp_t:dir { search };
allow staff_screensaver_t xdm_tmp_t:sock_file { write };
allow staff_t file_t:dir { getattr };
allow staff_t staff_t:netlink_route_socket { create };

#from starting postgresql server during boot and using postgresql as user.
allow initrc_su_t postgresql_db_t:dir { search };
allow user_t postgresql_db_t:dir { add_name getattr read remove_name search write };
allow user_t postgresql_db_t:file { create getattr read rename unlink write };
allow staff_t user_tmp_t:sock_file { write };
allow staff_t user_t:unix_stream_socket { connectto };



--------------030500070001020008000207--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
