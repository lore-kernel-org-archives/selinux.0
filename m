Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA04107
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 11:16:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA15580
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 15:16:40 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzband.ncsc.mil  with ESMTP id PAA15576
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 15:16:39 GMT
Date: Sat, 21 Apr 2001 17:15:30 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>
Cc: "Donaldson, Matthew" <matthew@datadeliverance.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [BUGTRAQ] Linux patches to solve /tmp race problem
Message-ID: <20010421171530.A3210@caldera.de>
References: <15072.12895.627024.191687@localhost.localdomain> <20010421104502.A25434@bunuel.tii.matav.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010421104502.A25434@bunuel.tii.matav.hu>; from mag@bunuel.tii.matav.hu on Sat, Apr 21, 2001 at 10:45:02AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Apr 21, 2001 at 10:45:02AM +0200, Magos?nyi ?rp?d wrote:
> Hi!
> 
> This is a good functionality. What about making a selinux-dependent
> version of it, which can include the TSID (or much better the label
> representation) in the pathname?
> It could be very useful for creating multilevel directories.

It's a _horrible_ cludge.  Look at Al Viro's namespace patches for Linux 2.4
(ftp.math.psu.edu:/pub/viro) for a sane alternative.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
