Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EEWwWt018770
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 10:32:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EEWvhS008632
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 14:32:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9EEWvEs008629 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 14:32:57 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EEWuAn013678
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 10:32:57 -0400 (EDT)
Subject: Re: [patch] 2.6.0-test7-selinux1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
In-Reply-To: <3F89E737.7090004@hotmail.com>
References: <1065712103.8181.266.camel@moss-spartans.epoch.ncsc.mil>
	 <3F89E737.7090004@hotmail.com>
Content-Type: text/plain
Message-Id: <1066141976.5054.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 10:32:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-10-12 at 19:43, James de Lurker wrote:
> I just can't get this to apply cleanly. I assume that the reference here is
> the standard kernel.org linux-2.6.0-test7 ?

Yes.

$ wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.0-test7.tar.bz2
$ tar xjf linux-2.6.0-test7.tar.bz2
$ cd linux-2.6.0-test7
$ patch -p1 < ~/2.6.0-test7-selinux1.patch

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
