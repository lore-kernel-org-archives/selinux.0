Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2B3RxMh023128
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 23:28:00 -0400
Received: from mk-filter-4-a-1.mail.uk.tiscali.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2B3Rw8F002122
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 03:27:59 GMT
From: "Martin J. Green" <mail@martinjgreen.me.uk>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 11 Mar 2008 03:27:54 +0000
Subject: RE: Re: Getting started with SELinux and Slackware
Message-ID: <54EE10FFA0116B408D3A5172CB52729F012DC48610D7@exchange.home.martinjgreen.me.uk>
References: <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk>
In-Reply-To: <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I grabbed a copy of from http://www.filewatcher.com/p/util-linux-2.11y-31.2.src.rpm.1552730/util-linux-selinux.patch.html and had a go at patching it against the 2.12r code to see what was going to patch/what needed fixing, and it appears 2.12r already has some selinux code/support included? (the 2.11y patch creates two files, amongst other things, called selinux_utils.c and .h - these already exist) The MCONFIG file has an option to enable selinux - it appears the patch is already integrated?

Looking at fedora sources, it looks like they only patch util-linux for pam, not selinux, so this would seem to confirm this is the case (though looking at Timothy Wood's patchset, he's also adding the use_selinux define to MCONFIG).

So I don't need to do anything to util-linux except enable selinux on compile?

Login would come from Shadow in any event, so probably need to be looking there...

M

From: Stephen Smalley <sds@tycho.nsa.gov>

The switch from using a direct patch to login to using pam_selinux
happened back in 2003, so I think Fedora might have always used
pam_selinux (since Fedora first included SELinux in Fedora Core 2, which
came out later). You can tell by whether or not the
util-linux-selinux.patch included a diff to login.c or not.


Of course, pam_selinux has undergone a lot of changes since that time,
so you may want to consider just back porting its logic into login.c,
removing its pam'isms.


google on util-linux-selinux.patch found a copy that still had the
login.c mods at:
http://mirror.caoslinux.org/cAos-1/creation/util-linux-2.11y-31.1/SOURCES/util-linux-selinux.patch
among other places.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
