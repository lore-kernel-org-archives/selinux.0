Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24187
	for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 14:53:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA14270
	for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 19:51:31 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id TAA14266
	for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 19:51:31 GMT
Received: from moss-sooners.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5) with ESMTP id gBIJvdDA003654
	for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 14:57:39 -0500
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5/Submit) id gBIJvciK003652
	for selinux@tycho.nsa.gov; Wed, 18 Dec 2002 14:57:38 -0500
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA19234
	for <selinux@tycho.nsa.gov>; Tue, 17 Dec 2002 22:34:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBI3YVI24939
	for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 03:34:31 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gBI3YTf24935 for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2002 03:34:29 GMT
Date: Wed, 18 Dec 2002 14:39:00 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: SE-Linux Debian woody archive
Message-ID: <20021218033900.GK3669@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am about to update my archive to use the my DAK version. All files are
copied now, I just need to update the Packages index files, this should
take minutes at the most.

It is located at:

deb http://www.microcomaustralia.com.au/debian/ unstable main selinux

OR

deb http://www.microcomaustralia.com.au/debian/ stable main selinux

What this means:

- some packages have been recompiled with newer version numbers, even
  though nothing has changed; this is because the previous versions did
  not include full source code, and DAK is rather fussy that all
  packages must have full source code available.

- if anyone is interested I can setup an announce mailing list
  which will notify you automatically when a new package is installed.

- as shown above, there are two distributions, a stable distribution and
  a unstable distribution.

Any new uploads will go straight to unstable. Packages in unstable may
not have received any testing yet, so could be broken. When the package
is tested, and seems to be working, I will move it to stable.

Eventually I could have a third stage, testing, to go inbetween stable
and unstable. However, I haven't yet worked out when to use testing, so
for now it remains empty.

If you encounter any problems with this new setup, please let me know.

Otherwise, I will assume it is working without any problems and
delete the files required by the old layout.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
