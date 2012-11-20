Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKHeEfG016961
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 12:40:14 -0500
Received: from gaara.hadrons.org (85.137.229.25) by resmaa12.ono.com (8.6.048.02) (authenticated as guillemj@ono.com)
        id 5052D7630150E798 for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 15:31:59 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.80)
	(envelope-from <guillemj@ono.com>)
	id 1TantB-000227-Hp
	for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 14:29:21 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Subject: =?UTF-8?q?=5BPATCH=200/4=5D=20libselinux=3A=20Man=20pages=20cleanups=20and=20updates?=
Date: Tue, 20 Nov 2012 14:25:26 +0100
Message-Id: <1353417930-7707-1-git-send-email-guillem@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

While going through the SELinux documentation to improve its support
in dpkg, I found some issues in the man pages. Here's some patches
addressing them.

I'm not sure the typo fix in “libselinux: Fix typo in man page” is
entirely correct, being non-native an all. The formatting fixes bring
the man pages closer in line with the linux-man project's style; I
didn't split that one into smaller changes, because it didn't seem
worth it though.

Regards,
Guillem

Guillem Jover (4):
  libselinux: Fix program synopsis and function prototypes in man pages
  libselinux: Fix man pages formatting
  libselinux: Fix typo in man page
  libselinux: Add references and man page links to _raw function
    variants
-- 
1.8.0



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
