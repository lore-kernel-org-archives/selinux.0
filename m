Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1T4QERb020645
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 23:26:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1T4QDQQ016668
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:26:13 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i1T4QCP0016665 for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:26:13 GMT
Date: Sun, 29 Feb 2004 04:26:10 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Message-ID: <20040229042610.GA11147@vnl.com>
References: <20040228181418.GO11147@vnl.com> <200402291344.28017.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402291344.28017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 29, 2004 at 01:44:28PM +1100, Russell Coker wrote:
> The syslog.te file has policy to allow syslog-ng to perform klogd 
> functionality.  Why don't you have syslogd working in that manner?

I just thought about what you said here. Are we on the
same page? The problem I'm seeing is to do with Colin's
script deciding to remove klogd.te because there is no
klogd debian package installed... which is because the 
debian syslog-ng package doesn't need the klogd package.

This causes a problem later because the POLICY files
require klogd.te regardless of whether there is a
klogd debian package or not.
 
-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
