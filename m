Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8O8OqrT015714
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 04:24:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8O8NnxO002328
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 08:23:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: bash_profile: Permission denied
Date: Fri, 24 Sep 2004 18:24:41 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "James R. Marcus" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov
References: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local> <200409240622.07118.russell@coker.com.au> <20040923231535.GB8569@lkcl.net>
In-Reply-To: <20040923231535.GB8569@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409241824.41593.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2004 09:15, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  ah, but running newrole is not enough: not having write access to
>  /root/.bash_profile results in bash not _reading_ the file either.

I wrote the following in my previous message to James R. Marcus on the same 
topic:

If you enable the boolean staff_read_sysadm_file then staff_t can read 
sysadm_home_t files and can search sysadm_home_dir_t directories.  This will 
allow you to login as root:staff_r:staff_t without any warning messages AND 
with the aliases etc from .bashrc defined.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
