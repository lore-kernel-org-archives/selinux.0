Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h59CUJI4013113
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 08:30:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h59CUItV004490
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 12:30:18 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h59CUIal004487 for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 12:30:18 GMT
Subject: Re: selinux kernel patch in bitkeeper, somewhere?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030607145722.GA2974@schuldei.org>
References: <20030607145722.GA2974@schuldei.org>
Content-Type: text/plain
Message-Id: <1055161811.1068.34.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jun 2003 08:30:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-06-07 at 10:57, Andreas Schuldei wrote:
> is there a bitkeeper repository for the 2.4 selinux kernel,
> somewhere?
> 
> i would like to magically merge (yeah, right!) it with the ipsec
> backport of davidm (bk://kernel.bkbits.net/davem/ipsec-2.4/).

Not really.  There is a lsm-2.4 BitKeeper tree for the LSM project
(bk://lsm.bkbits.net/lsm-2.4), but since it was originally created
before there was any mainline 2.4 BitKeeper tree, it wasn't cloned from
the mainline tree.  Hence, you can't merge easily.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
