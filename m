Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KSmDo015133
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:28:48 -0500 (EST)
Subject: Re: patch: Cleanup policy for /var/lock
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050330155926.GA5791@thorium.jmh.mhn.de>
References: <20050330155926.GA5791@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:28:29 -0500
Message-Id: <1112387309.9437.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2005-03-30 at 17:59 +0200, Thomas Bleher wrote:
> This patch replaces direct write access to /var/lock with calls to
> lock_domain(). There is a potential for breakage here: if there are any
> locks shared between two domains it will break. However, I have tested
> this patch on two systems, no problem so far.
> 
> Please apply.
> Thomas
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
