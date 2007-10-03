Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l940H632014946
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2007 20:17:06 -0400
Received: from smtp.enter.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l940H4Id029271
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2007 00:17:04 GMT
Received: from smtp.enter.net (mail.enter.net [216.193.128.40])
	by smtp.enter.net (Postfix) with ESMTP id E74FDCDF5E
	for <selinux@tycho.nsa.gov>; Wed,  3 Oct 2007 19:52:45 -0400 (EDT)
Received: from d500.localdomain (dhcp-14-173.dsl.enter.net [216.193.173.14])
	by smtp.enter.net (Postfix) with ESMTP id 9BFA3CD90F
	for <selinux@tycho.nsa.gov>; Wed,  3 Oct 2007 19:52:45 -0400 (EDT)
Message-ID: <47042B4C.50004@enter.net>
Date: Wed, 03 Oct 2007 19:52:44 -0400
From: Michael Klinosky <mpk2@enter.net>
MIME-Version: 1.0
To: NSA SElinux <selinux@tycho.nsa.gov>
Subject: Re: ftpd is denied access to a dir
References: <47019EAF.4050009@enter.net> <47024D25.4000102@redhat.com>
In-Reply-To: <47024D25.4000102@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel:
> Well first thing I would do is update to the latest selinux policy

I did that already (about 2 weeks ago). I asked about this on the 
general Fedora list, and that was recommended.

> Looking at the current policy the creation of the pid file (var_run_t)
> should be allowed.  The second avc is fixed in Fedora 8/Rawhide but not
> in FC7.  So I will add it in the next update.

> A better list to ask about Fedora SELinux questions is
> "Fedora SELinux support list for users & developers."
> <fedora-selinux-list@redhat.com>

OK - found it, and subscribed.

And, someone posted to the list about selinux denying httpd access to a 
file. So, perhaps the SElinux people still have to tweak on things (as 
you mentioned there, about the pid file).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
