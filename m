Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SD1ZXZ029469
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 09:01:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SD1VW1009083
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 13:01:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: MySQL Policy Patch
Date: Thu, 28 Oct 2004 23:01:28 +1000
Cc: Alex Ackerman <alex@darkhonor.com>, selinux@tycho.nsa.gov
References: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net> <1098117292.27895.125.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098117292.27895.125.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410282301.28107.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Oct 2004 02:34, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> Think about the security implications:  Do you want a compromised mysqld
> to be able to read arbitrary admin temporary files?  Not likely.  So

 allow mysqld_t sysadm_home_dir_t:dir search;
 allow mysqld_t sysadm_home_t:file { read getattr };

The above rules which are already in the policy are worse.

The mysql situation needs improvement.  Firstly I think that the temporary 
file should be created under /var/lib/mysql to remove the need for /tmp 
access.  Then we need to do something about /root/.my.conf, maybe move it to 
some place under /etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
