Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JGk0rT000499
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 12:46:00 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JGijvJ000578
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 16:44:45 GMT
Subject: Re: insmod
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200410161928.00867.russell@coker.com.au>
References: <200410161928.00867.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1098204278.11426.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 12:44:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2004-10-16 at 05:28, Russell Coker wrote:
> It seems that we can't get insmod changed to not open the module read/write 
> for locking, so the attached patch permits this access.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
