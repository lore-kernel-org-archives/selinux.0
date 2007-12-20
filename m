Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBKDeVul005568
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2007 08:40:31 -0500
Received: from mk-filter-1-a-1.mail.uk.tiscali.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBKDeUiE023340
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2007 13:40:31 GMT
From: "Martin J. Green" <mail@martinjgreen.me.uk>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Thu, 20 Dec 2007 13:40:10 +0000
Subject: Re: Getting started with SELinux and Slackware
Message-ID: <54EE10FFA0116B408D3A5172CB52729FBF526E155A@exchange.home.martinjgreen.me.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Timothy <timothy_at_diyab.net>
> Date: Thu, 22 Sep 2005 14:02:29 -0400
>
> All of the modified slackware sources that I used to build that old release are available on that ftp site (ftp.diyab.net/selinux). I haven't had time to update any of it > in a while but it generally just requires checking the newer patches and rebuilding the tgz from the slackbuild script.
> I included PAM because I think it has good advantages so all of the packages I built include PAM support. Not sure what would be involved in building without PAM. Most >likely it just requires removing the configure flags to enable PAM from the build scripts.
> I'll be more than happy to help you out if you want.
> Timothy


I appreciate this is an old post, but I'm in the process of updating your build scripts for the latest selinux, however I'm also looking for the old login patch so I don't have to use PAM.

I would of course be happy to make the build scripts available (I'll also build for i486 and upload to linuxpackages.net when I get time - I'm building for p4 & x86_64 for myself).

Can anyone point me in the right direction to find the necessary patch(es)? I've found some FC4 patches in the fedora CVS tree that don't seem to refer to PAM, but not sure when PAM was introduced to redhat/fedora, so not quite sure what I'm looking for. I want to modify slack as little as possible.

Martin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
