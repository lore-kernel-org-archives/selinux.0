Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VMTmDo000227
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:29:49 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VMSQiv018795
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 22:28:26 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VMSQB9021571
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:28:27 -0500 (EST)
Subject: Re: Further X client cleanups..questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
In-Reply-To: <1112308113.17917.9.camel@cobra.ivg2.net>
References: <1112308113.17917.9.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 17:34:37 -0500
Message-Id: <1112308477.17917.12.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 17:28 -0500, Ivan Gyurdiev wrote:
> I am wondering whether the following are needed:
> 
> allow $1_$2_t xdm_t:fd use;
> allow $1_$2_t xdm_t:fifo_file rw_file_perms;
> dontaudit $1_$2_t xdm_t:tcp_socket { read write };
> 
> allow $1_t $2_xserver_t:process signal;

The $1 and $2 here are different from the other ones - 

In the first case $1 is role, $2 is app, in the second
$1 is role_app, $2 is role.
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
