Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8P8UtsJ022810
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 04:30:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8P8UsCG003806
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:30:54 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8P8UsqJ003803 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:30:54 GMT
Date: Thu, 25 Sep 2003 09:30:52 +0100
From: Dale Amon <amon@vnl.com>
To: Diyab <diyab@diyab.net>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925083052.GA10234@vnl.com>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com> <20030924222702.GT21997@vnl.com> <3F725AA4.1090300@diyab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F725AA4.1090300@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 24, 2003 at 11:01:56PM -0400, Diyab wrote:
> Dale Amon wrote:
> I don't get that /var/lib avc error.  Does the login work without that 
> allow rule you added?  If so then maybe it doesn't really need it.

Nope. I cannot connect in enforcing mode. I've worked my way through
two ssh fatal avc's and this is the last one. None of them make
particular sense to me. To the point that I even did a 
forced reinstall of ssh...
 
> Maybe that "bad" link has something to do with it.  unmount /var and run 
> an fsck on it then remount it and see if you still get the error.

It's not a partition, just a plain directory. The whole disk is a
/ partition so all I could do is reboot. That will happen later
this morning anyway, since I shut the test bed down at night. It's
old and noisy. :-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
