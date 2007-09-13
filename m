Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8D9JNjx004409
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 05:19:23 -0400
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8D9JKe2018310
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 09:19:21 GMT
Subject: Re: I have put my latest policy patch up on
	http://dwalsh.fedorapeople.org/20070912/
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46E84D34.9030909@redhat.com>
References: <46E84D34.9030909@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 11:18:29 +0200
Message-Id: <1189675109.2917.11.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-12 at 16:33 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have a txt file describing the changes for each patch.
> 
> These are all my changes as of this morning.

I tried the patch for mozilla (apps_mozilla.patch) and I get a lot of
errors:

$ patch --dry-run mozilla.if apps_mozilla.patch
patching file mozilla.if
Hunk #1 FAILED at 36.
Hunk #2 FAILED at 54.
Hunk #3 FAILED at 106.
Hunk #4 FAILED at 147.
Hunk #5 FAILED at 198.
Hunk #6 FAILED at 226.
Hunk #7 FAILED at 251.
Hunk #8 FAILED at 267.
Hunk #9 FAILED at 308.
Hunk #10 FAILED at 480.
10 out of 10 hunks FAILED -- saving rejects to file mozilla.if.rej
patching file mozilla.te
Hunk #1 FAILED at 6.
1 out of 1 hunk FAILED -- saving rejects to file mozilla.te.rej

I'm using the files mozilla.{if,te} from SVN trunk repository of the
refpolicy. Do I have to use another version?

The changes look like to confine the mozilla app on a targeted policy,
right? Discussed before
here:http://marc.info/?l=fedora-selinux-list&m=116485986019158&w=2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
