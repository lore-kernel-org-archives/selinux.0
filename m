Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0CDINRb012332
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 08:18:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0CDICiV018460
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 13:18:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0CDIB06018457 for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 13:18:11 GMT
Subject: Re: Questions about install SELinux in Fedora Core
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Park Lee <parklee_2004@yahoo.com.cn>, selinux@tycho.nsa.gov
In-Reply-To: <200401112231.54137.russell@coker.com.au>
References: <20040111024703.62855.qmail@web15208.mail.bjs.yahoo.com>
	 <200401112231.54137.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073913483.11263.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 08:18:03 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-01-11 at 06:31, Russell Coker wrote:
> 2.6.0 and 2.6.1 run fine without any patches.

The latest -mm patch (2.6.1-mm2) includes all of the patches to the
SELinux module except for a reworking of the skb logging and new
port-based controls by James Morris.  2.6.1 still lacked the resource
limit inheritance control as well as the networking controls, and 2.6.0
further lacked the signal inheritance control and several fixes.  Hence,
while you can use vanilla 2.6.0 or 2.6.1 without any patches, it isn't
exactly the same; certain controls won't be present.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
