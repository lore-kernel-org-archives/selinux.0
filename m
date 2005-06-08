Message-ID: <42A70558.5030609@redhat.com>
Date: Wed, 08 Jun 2005 10:48:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: [Fwd: Unable to create files when using "context"option for NFS]
Content-Type: multipart/mixed;
 boundary="------------050704000204030300000809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050704000204030300000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

What is the best way to handle this? 

If I add a rule

allow file_type self:filesystem associate;

Will that cause and explosion in rules?  Will this open a security risk?

We tell people to use the mount -o context flags but policy can not 
handle most of them without the above rule.

Dan

-- 



--------------050704000204030300000809
Content-Type: message/rfc822;
 name="Unable to create files when using \"context\"option for NFS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Unable to create files when using \"context\"option for NFS"

Return-Path: <fedora-selinux-list-bounces@redhat.com>
Received: from mail.boston.redhat.com ([unix socket])
	by mail.boston.redhat.com (Cyrus v2.1.12) with LMTP; Thu, 02 Jun 2005 16:20:35 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j52KKYDi025021;
	Thu, 2 Jun 2005 16:20:34 -0400
Received: from mx1.util.phx.redhat.com (mx1.util.phx.redhat.com [10.8.4.92])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j52KKTO12437;
	Thu, 2 Jun 2005 16:20:29 -0400
Received: from hormel.redhat.com (hormel.util.phx.redhat.com [10.8.4.111])
	by mx1.util.phx.redhat.com (8.11.6/8.11.6) with ESMTP id j52KKTk12021;
	Thu, 2 Jun 2005 16:20:29 -0400
Received: from listman.util.phx.redhat.com (listman.util.phx.redhat.com [10.8.4.110])
	by hormel.redhat.com (Postfix) with ESMTP
	id 6743973012; Thu,  2 Jun 2005 16:20:29 -0400 (EDT)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by listman.util.phx.redhat.com (8.12.11/8.12.10) with ESMTP id
	j51LhsS7006611 for <fedora-selinux-list@listman.util.phx.redhat.com>;
	Wed, 1 Jun 2005 17:43:54 -0400
Received: from mx3.redhat.com (mx3.redhat.com [172.16.48.32])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j51LhsO06328
	for <fedora-selinux-list@redhat.com>; Wed, 1 Jun 2005 17:43:54 -0400
Received: from ftp.cert.ucr.edu (IDENT:root@ftp.cert.ucr.edu [138.23.180.129])
	by mx3.redhat.com (8.12.11/8.12.11) with ESMTP id j51LhkDD004781
	for <fedora-selinux-list@redhat.com>; Wed, 1 Jun 2005 17:43:46 -0400
Received: from [127.0.0.1] (ninkasi.cert.ucr.edu [138.23.181.0])
	by cert.ucr.edu (8.12.8/8.12.8) with ESMTP id j51LhiAJ022281
	for <fedora-selinux-list@redhat.com>; Wed, 1 Jun 2005 14:43:45 -0700
Message-ID: <429E2C10.7060501@cert.ucr.edu>
Date: Wed, 01 Jun 2005 14:43:44 -0700
From: Robert Bottomley <bob@mail.cert.ucr.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US;
	rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-selinux-list@redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RedHat-Spam-Score: 0 
X-loop: fedora-selinux-list@redhat.com
X-Mailman-Approved-At: Thu, 02 Jun 2005 16:20:28 -0400
Subject: Unable to create files when using "context"option for NFS
X-BeenThere: fedora-selinux-list@redhat.com
X-Mailman-Version: 2.1.5
Precedence: junk
List-Id: "Fedora SELinux support list for users &amp;
	developers." <fedora-selinux-list.redhat.com>
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-selinux-list>,
	<mailto:fedora-selinux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-selinux-list>
List-Post: <mailto:fedora-selinux-list@redhat.com>
List-Help: <mailto:fedora-selinux-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-selinux-list>,
	<mailto:fedora-selinux-list-request@redhat.com?subject=subscribe>
Sender: fedora-selinux-list-bounces@redhat.com
Errors-To: fedora-selinux-list-bounces@redhat.com

In FC3 (running kernel 2.6.11-1.27_FC3smp and 
selinux-policy-targeted-1.17.30-2.96), I am mounting an NFS filesystem for use 
by Apache. In /etc/fstab, I have:

ozone:/usr/local/svn /svn nfs 
rw,context=system_u:object_r:httpd_sys_script_rw_t,intr,bg,hard,rsize=8192,wsize=8192 
0 0

Any attempts to create a file in /svn are met with (here I was attempting a 
"touch x"):

audit(1117233333.027:0): avc: denied { associate } for pid=12795 
exe=/bin/touch name=x scontext=root:object_r:httpd_sys_script_rw_t 
tcontext=system_u:object_r:httpd_sys_script_rw_t tclass=filesystem

It does not matter what context I specify, I cannot create a file -- even 
though my shell is running as unconfined_t. (If a file already exists, I can 
edit it.)

So the questions are:

1. Is this a bug? Should I not be able to create a file when running in the 
unconfined_t context?

2. Audit2allow tells me that I need to add:

allow httpd_sys_script_rw_t self:filesystem associate;

but if unconfined_t context cannot write, then will something in 
httpd_sys_script_rw_t be able to?

sestatus
========

SELinux status:         enabled
SELinuxfs mount:        /selinux
Current mode:           enforcing
Mode from config file:  enforcing
Policy version:         18
Policy from config file:targeted

Policy booleans:
allow_ypbind            active
dhcpd_disable_trans     inactive
httpd_disable_trans     inactive
httpd_enable_cgi        active
httpd_enable_homedirs   active
httpd_ssi_exec          active
httpd_tty_comm          inactive
httpd_unified           inactive
mysqld_disable_trans    inactive
named_disable_trans     inactive
named_write_master_zonesinactive
nscd_disable_trans      inactive
ntpd_disable_trans      inactive
portmap_disable_trans   inactive
postgresql_disable_transinactive
snmpd_disable_trans     inactive
squid_disable_trans     inactive
syslogd_disable_trans   inactive
use_nfs_home_dirs       inactive
use_samba_home_dirs     inactive
use_syslogng            inactive
winbind_disable_trans   inactive
ypbind_disable_trans    inactive

-- 
Robert Bottomley         | E-mail: bob@cert.ucr.edu
System Administrator     | Tel: 951-781-5788
College of Engineering   |                 It is dangerous to be right
Center for Environmental | CE-CERT         when the government is wrong.
Research and Technology  | UC Riverside                       --Voltaire


--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
http://www.redhat.com/mailman/listinfo/fedora-selinux-list

--------------050704000204030300000809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
