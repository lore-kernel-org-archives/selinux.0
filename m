Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA17013
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 17:18:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA05703
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 22:17:36 GMT
Received: from mail.lemuria.org ([213.191.74.130])
	by jazzband.ncsc.mil  with ESMTP id WAA05699
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 22:17:35 GMT
Received: from unicorn.lemuria.org (b065224.adsl.hansenet.de [62.109.65.224])
	by mail.lemuria.org (Postfix) with ESMTP id E8FCFBB7C
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 23:16:03 +0100 (CET)
Date: Fri, 30 Nov 2001 23:17:36 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Message-ID: <20011130231736.A1680@lemuria.org>
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil> <20011130200644.BDF4535FC98@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011130200644.BDF4535FC98@lyta.coker.com.au>; from russell@coker.com.au on Fri, Nov 30, 2001 at 08:13:14PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 30, 2001 at 08:13:14PM +0100, Russell Coker wrote:
> Yes.  Sun is the only vendor I've come across that ships packages that mess 
> with /usr/local.  They seem to think that a Sun package of bash for Solaris 
> 2.6 (distributed from a Sun web site) should install to /usr/local/bin while 
> a package for Solaris 8.0 (distributed on the install CDs) should be in /bin. 
> This sort of thing really sucks when you are trying to manage a network.

OpenBSD also does this. bash is in /usr/local/bin even though it's not
a port or a 3rd party piece, but an official package.

I agree on that not being good practice. I don't know that rationale
for these, though.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
