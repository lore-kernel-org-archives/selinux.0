Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5DHfEI4006488
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 13:41:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5DHeXss021007
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 17:40:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h5DHeXhY021004
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 17:40:33 GMT
Subject: Re: Status of selinux on IBM mainframe
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Michael Lambert <mlambe7@lsu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1055514931.6878.33.camel@lambert.ocs.lsu.edu>
References: <1055514931.6878.33.camel@lambert.ocs.lsu.edu>
Content-Type: text/plain
Message-Id: <1055526062.1039.214.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 13 Jun 2003 13:41:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-06-13 at 10:35, Michael Lambert wrote:
> I was wondering what the development status of selinux was for
> architectures other than intel, particularly for linux on the IBM
> mainframe. I've searched the list archives and found a few mentions of
> the s/390, but nothing very descriptive. If there is a desire to port
> selinux to mainframe linux, I may be able to lend a hand in development.

There isn't much point in pursuing such a port; the overhaul of the
SELinux API for 2.5 has eliminated the architecture-specific code from
SELinux, and the LSM hooks have been merged into mainline 2.5, including
the few hooks that go into the architecture-specific subtrees.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
