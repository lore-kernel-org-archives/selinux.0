Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VMNkDo000131
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:23:46 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VMJiTg023527
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 22:19:44 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VMMNB9018301
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:22:24 -0500 (EST)
Subject: Further X client cleanups..questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 31 Mar 2005 17:28:33 -0500
Message-Id: <1112308113.17917.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am wondering whether the following are needed:

allow $1_$2_t xdm_t:fd use;
allow $1_$2_t xdm_t:fifo_file rw_file_perms;
dontaudit $1_$2_t xdm_t:tcp_socket { read write };

allow $1_t $2_xserver_t:process signal;

=========

I also plan on moving this out of x_client and into each 
separate client:

# Allow the user domain to send any signal to the $2 process.
can_ps($1_t, $1_$2_t)
allow $1_t $1_$2_t:process signal_perms;

=========

And I've introduced a boolean here:

# Client write xserver shm
if (allow_write_xshm) {
allow $1_t $2_xserver_t:shm write;
allow $1_t $2_xserver_tmpfs_t:file write;
}


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
