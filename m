Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8JS7Ii007694
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:28:07 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8JQUTx011153
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:26:30 GMT
Subject: Re: patch: suse stuff
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041206234226.GF3678@jmh.mhn.de>
References: <20041206234226.GF3678@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102534242.30962.22.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 14:30:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-12-06 at 18:42, Thomas Bleher wrote:
> This patch corrects some issues from a previous patch. I looked over the
> acpi package again and noted that the /var/lib/acpi stuff was added by
> SuSE and is not included upstream. Thus the ifdefs.
> It also corrects the labeling in a few places.
> Please apply.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
