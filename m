Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NJLCrT012116
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 15:21:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NJKBv8010982
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 19:20:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "James R. Marcus" <jmarcus@mvalent.net>
Subject: Re: bash_profile: Permission denied
Date: Fri, 24 Sep 2004 05:21:08 +1000
Cc: <selinux@tycho.nsa.gov>
References: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local>
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409240521.08617.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2004 04:13, "James R. Marcus" <jmarcus@mvalent.net> wrote:
> What is the right way to deal with this issue?  When root logs in should
> they automatically be in the sysadm_r role or should these files be
> labeled with staff_r?

If you enable the boolean staff_read_sysadm_file then staff_t can read 
sysadm_home_t files and can search sysadm_home_dir_t directories.  This will 
allow you to login as root:staff_r:staff_t without any warning messages AND 
with the aliases etc from .bashrc defined.

Also please put your test after the text you quote, and trim any quoted text 
that is not necessary to understanding your message.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
