Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T6YarT016597
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 02:34:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6T6YXCb026699
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 06:34:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: modifications to cups policy (maybe debian specific)
Date: Thu, 29 Jul 2004 16:34:23 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040728125206.GA3158@lkcl.net>
In-Reply-To: <20040728125206.GA3158@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407291634.23922.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Jul 2004 22:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> FHS policy violation in cupsys daemon where certs were stored in
> /etc/cups has been fixed - in debian version 1.1.20final+rcSomething.
>
> i added the following, also removing the /etc/cups/certs references which
> are set to cupsd_rw_etc_t.
>
> 	/var/lib/cups/certs		-d	system_u:object_r:cupsd_var_t
> 	/var/lib/cups/certs/.*	--	system_u:object_r:cupsd_var_t

/var/lib/cups/certs     -d      system_u:object_r:cupsd_rw_etc_t
/var/lib/cups/certs/.*  --      system_u:object_r:cupsd_rw_etc_t

Add the above to cups.fc and it should be fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
