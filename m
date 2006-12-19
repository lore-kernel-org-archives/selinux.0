Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBJN3uVl022421
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 18:03:56 -0500
Received: from davidz.fubar.dk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBJN4WF1009993
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 23:04:32 GMT
Subject: Re: Fast User Switching and security / SELinux
From: David Zeuthen <david@fubar.dk>
To: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45886451.8070601@redhat.com>
References: <45886451.8070601@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 19 Dec 2006 18:04:29 -0500
Message-Id: <1166569469.2597.22.camel@zelda.fubar.dk>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-19 at 17:14 -0500, Karl MacMillan wrote:
> Reading through http://fedoraproject.org/wiki/Desktop/FastUserSwitching, 
> I had two questions.
> 
> 1) Any work ongoing to look at the security of this solution. For 
> example, the proposed fix for device ownership allows multiple users to 
> use devices simultaneously. This could have serious security 
> implications (e.g., monitoring VIOP calls made by another user).

No code yet, plans include using ACL's on device nodes and have *some*
way of specifying whether a device of a given class can have multiple
owners or not. Preferably specifying this so it can be locked down.
Whether the driver in question support multiple openers (it varies, even
within the same class e.g. ALSA) is another question. 

All this will probably mean replacing pam-console with *something*, not
a bad idea anyway since pam-console is one reason that e.g. udev takes a
long time to start. It just does a lot of work on every uevent that it
doesn't need to do.

Again, no code is written yet. For discussion please follow up on the
Wiki page, not on this mailing list (as such, Karl, please add notes to
the Wiki page). Thanks.

     David



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
