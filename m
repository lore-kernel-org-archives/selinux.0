Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KLQrx6019098
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 16:26:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2KLQq9P010035
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 21:26:52 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2KLQpP7010030 for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 21:26:51 GMT
Subject: Re: selinux
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: "Menon, Sunanda R" <sunanda.r.menon@intel.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0F2F09B6@orsmsx108.jf.intel.com>
References: 
	 <D9223EB959A5D511A98F00508B68C20C0F2F09B6@orsmsx108.jf.intel.com>
Content-Type: text/plain
Message-Id: <1048195601.24500.111.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Mar 2003 16:26:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site at nsa.gov provides only the current release and
"historically significant" old releases.  Frankly I don't recommend
using an old release because the newer releases contain important bug
fixes, improvements, and old releases are often are incompatible with
newer tools and utilities.  If you must have an old release, the SELinux
site at SourceForge maintains a public CVS tree which you can use to get
the old release.  See http://sourceforge.net/cvs/?group_id=21266

On Wed, 2003-03-19 at 19:29, Menon, Sunanda R wrote:
> I am trying to get selinux patch for red hat Linux 2.4.18. I could not find
> the tar file at the NSA site. Can anyone tell me where I can get it?
> Thanks

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
