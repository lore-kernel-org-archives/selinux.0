Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OB83rT025250
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:08:03 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OB82CV028738
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:08:02 GMT
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040824002244.GA25356@lkcl.net>
References: <20040823214228.GA13677@lkcl.net>
	 <20040824002244.GA25356@lkcl.net>
Content-Type: text/plain
Message-Id: <1093345601.1800.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 07:06:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 20:22, Luke Kenneth Casson Leighton wrote:
> my apologies for the length of the patch which i had not correctly
> observed: the /.?u?dev is there to deal with /.dev which on debian
> linux with udev is the "real" /dev remounted (--bind?) to a different
> point.

fixfiles and make relabel exclude bind mounts from the relabeling.  So
if it is a bind mount, it shouldn't get relabeled anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
