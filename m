Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I9rwRb000055
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 05:53:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4I9pYB2029993
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:51:34 GMT
Received: from zinc.btinternet.com (zinc.btinternet.com [194.73.73.148])
	by jazzswing.ncsc.mil  with ESMTP id i4I9pXwi029990
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:51:34 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by zinc.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BQ1IJ-0000HZ-00
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 10:53:55 +0100
Received: from highfield ([192.168.0.223]:34028 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQ1L5-0007YR-Lj
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:56:47 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQ1Fo-0006MJ-6T
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 09:51:20 +0000
Date: Tue, 18 May 2004 09:51:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [latest cvs]: build error on printer_device_t not recognised
Message-ID: <20040518095120.GB24333@lkcl.net>
References: <20040518094837.GA24333@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040518094837.GA24333@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 09:48:37AM +0000, Luke Kenneth Casson Leighton wrote:

> is this error something to do with me having cups installed but not
> lpd?
> 
> i believe i am correct in thinking that you don't need lpd installed in
> order for cups to work _as a client_.
> 
> l.

p.s. i have cupsys-bsd installed instead of lprng or equiv.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
