Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA25962
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 07:42:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA15970
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 12:42:26 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA15966
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 12:42:26 GMT
Date: Tue, 13 Nov 2001 07:41:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tetsuji Rai <tetsuji@rai.sytes.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Cannot build utils on RH7.2
In-Reply-To: <200111130805.fAD85hO32732@rai.sytes.net>
Message-ID: <Pine.GSO.4.33.0111130734440.28969-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 13 Nov 2001, Tetsuji Rai wrote:

>    I'm a newbiew here, trying to install selinux on my RH7.2.   But I
> cannot build utils.  I'm building selinux as readme file says (I buld
> SELinux module as part of the kernel) and many parts went well.  However,
> I'm stuck at 7) in readme file (I mean I am stuck when building utils).
>    Under utils, "make" command quits with this error message after a while:

As the NSA SELinux web pages mention, our current base platform for
SELinux is RedHat 7.1.  If you look at the mailing list archives
(available either via email to majordomo@tycho.nsa.gov or at
http://marc.theaimsgroup.com/?l=selinux), you'll see that several other
people have already asked about RedHat 7.2, and I've explained the current
obstacles to using it.  One of those obstacles will be removed shortly,
since ext3 support has been merged into the 2.4.15 pre-releases, but we
will still need to update the example policy configuration and upgrade at
least some of the modified daemon and utility packages.   I don't have any
timeline for when we'll go to RedHat 7.2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
