Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KTGDo015166
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:29:17 -0500 (EST)
Subject: Re: patch: cleanup uses of notdevfile_class_set
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050330165215.GD5791@thorium.jmh.mhn.de>
References: <20050330165215.GD5791@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:29:00 -0500
Message-Id: <1112387340.9437.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2005-03-30 at 18:52 +0200, Thomas Bleher wrote:
> This patch replaces uses of allow ...:notdevfile_class_set r_file_perms;
> with r_dir_file(). This should be no problem normally; user_t used to
> have access to sock_file and fifo_file under /var and /var/spool - I
> have removed this access, if there are any files where access is really
> needed they should probably get extra types.
> 
> Please apply.
> Thomas
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
