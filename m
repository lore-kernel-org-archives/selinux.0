Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82JEHLa019119
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 15:14:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82JCjpQ029520
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:12:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h82JCiQX029517
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:12:44 GMT
Subject: Re: Q on Internals & Data Structures
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200308301545.03201.wlsel@verizon.net>
References: <200308291222.23424.wlsel@verizon.net>
	 <1062177075.5432.143.camel@moss-spartans.epoch.ncsc.mil>
	 <200308301545.03201.wlsel@verizon.net>
Content-Type: text/plain
Message-Id: <1062530054.18568.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 15:14:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-08-30 at 15:45, Bill Laut wrote:
> Speaking of "driving the requirements," there is something I've been curious 
> about:  Would it be possible to add permissions to the security services 
> themselves?  EG, if I have a program that is security-ignorant but which 
> passes through the firewall to talk on the Internet, should a malicious 
> server compromise it via an unforeseen buffer-overflow I want to insure that 
> a security-aware payload inside the BO cannot somehow interrogate my policy 
> or in any way alter it.
> 
> In short, if an application/client is assumed to be security-ignorant, I want 
> its domain to -enforce- that ignorance and to audit any unexpected behavior 
> to the contrary, especially if the app is a network client talking to a peer 
> over an untrusted network.

The ability to invoke the security policy API is already controlled by a
set of permissions, so you can already do this.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
