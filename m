Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SDJBrT025910
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 09:19:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SDIMHc008188
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 13:18:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen torri <storri@torri.org>
Subject: Re: more policy patches
Date: Sat, 28 Aug 2004 23:19:06 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200408241937.04958.russell@coker.com.au> <200408281204.22830.russell@coker.com.au> <1093668326.22885.13.camel@base.torri.org>
In-Reply-To: <1093668326.22885.13.camel@base.torri.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408282319.06487.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Aug 2004 14:45, Stephen torri <storri@torri.org> wrote:
> Your are right. There is no binary called halt in the root directory /.
> There were no files starting with .autofsck either. The only place I
> found a binary called halt was in /sbin/halt.

/halt is different from /sbin/halt.  /halt is a zero byte flag file created 
when the system is being halted.

The below policy which is surrounded by ifdef(`distro_redhat' permits the 
creation of such files.

# for /halt /.autofsck and other flag files
file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
