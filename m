Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FN28Wt029414
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:02:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FN200p000932
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 23:02:00 GMT
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by jazzswing.ncsc.mil  with ESMTP id h9FN1xr7000929
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 23:01:59 GMT
Received: from franklin.cisco.com (franklin.cisco.com [171.70.156.17])
	by sj-core-4.cisco.com (8.12.6/8.12.6) with ESMTP id h9FN24H7028466
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:02:04 -0700 (PDT)
Received: from Cowboys.cisco.com (200@stealth-10-32-244-142.cisco.com [10.32.244.142]) by franklin.cisco.com (8.8.6 (PHNE_17190)/CISCO.SERVER.1.2) with SMTP id QAA07147 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:02:03 -0700 (PDT)
Date: Wed, 15 Oct 2003 16:01:09 -0700
From: Michael Reilly <michaelr@cisco.com>
To: selinux@tycho.nsa.gov
Subject: setfiles and /home labeling
Message-Id: <20031015160109.7fbdbb12.michaelr@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I know I am missing something.  These are all of the lines from
file_contexts which reference the /home directories.  Notice the two lines
which reference /home/michaelr.  After running make relabel /home/michaelr
is labeled system_u:object_r:user_home_dir_t instead of
system_u:object_r:staff_home_dir_t and all of the files in /home/michaelr
and below (except the files special cased like .ssh, etc.) are labeled
system_u:object_r:user_home_t.

Why are the two lines for /home/michaelr being ignored?  What am I doing
wrong?

Thanks,

michael
# Ordinary user home directories.
/home				system_u:object_r:home_root_t
/home/[^/]+	-d		system_u:object_r:user_home_dir_t
/home/[^/]+/.+			system_u:object_r:user_home_t
# Other staff home directories, replace "jadmin" with appropriate name
/home/michaelr/(/.*)?		system_u:object_r:staff_home_t
/home/michaelr			system_u:object_r:staff_home_dir_t
/home/\.\.\.security(/.*)?	system_u:object_r:file_labels_t
/home/lost\+found(/.*)?		system_u:object_r:lost_found_t
/home/[^/]+/\.gnupg(/.+)?	system_u:object_r:user_gpg_secret_t
/home/[^/]+/\.netscape(/.*)?	system_u:object_r:user_netscape_rw_t
/home/[^/]+/\.mozilla(/.*)?	system_u:object_r:user_netscape_rw_t
/root/\.ssh(/.*)?		system_u:object_r:staff_home_ssh_t
/home/[^/]+/\.ssh(/.*)?		system_u:object_r:user_home_ssh_t
/home/michaelr/\.ssh(/.*)?	system_u:object_r:staff_home_ssh_t
/home/[^/]+/\.vmware(/.*)?	system_u:object_r:vmware_user_file_t
/home/[^/]+/\vmware(/.*)?       system_u:object_r:vmware_user_file_t
/home/[^/]+/\vmware[^/]*/.*\.cfg    system_u:object_r:vmware_user_conf_t
/home/[^/]+/\.Xauthority.*	system_u:object_r:user_home_xauth_t


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
