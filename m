Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6EQcIi021071
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 09:26:38 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6EQeoX008545
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 14:26:40 GMT
Subject: Re: SELinux port for 2.4.28 (and incoming backport from 2.6)
	released.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lorenzo@gnu.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1102192723.19001.19.camel@localhost>
References: <1102192723.19001.19.camel@localhost>
Content-Type: text/plain
Message-Id: <1102342918.23475.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 06 Dec 2004 09:21:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-12-04 at 15:38, Lorenzo Hernandez Garcia-Hierro wrote:
> I've not tested it yet, but hopefully works.

For that kernel, you'll have to pass the -c 15 option to checkpolicy to
tell it to build a version 15 policy, as the 2.4-based SELinux doesn't
support newer policy versions.  Specifically, the 2.4-based SELinux was
never updated for the conditional policy support (policy booleans), ipv6
support, and fine-grained netlink classes.  See
http://marc.theaimsgroup.com/?l=selinux&m=107643944721568&w=2.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
