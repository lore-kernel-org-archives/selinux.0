Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0BG61Ii007912
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 11:06:01 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0BG45MI015202
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 16:04:05 GMT
Subject: Re: root and change of passwords
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: sequel@neofreak.org, SELinux Mail List <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1105456202.7682.18.camel@selinux>
References: <1105124940.27291.20.camel@sequel.info.polymtl.ca>
	 <1105451963.20566.12.camel@moss-spartans.epoch.ncsc.mil>
	 <1105456202.7682.18.camel@selinux>
Content-Type: text/plain
Message-Id: <1105459192.20566.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 10:59:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 10:10, Christopher J. PeBenito wrote:
> I was writing up a patch for shadow's version of passwd, chfn, and chsh,
> when I noticed that chage doesn't have a check.  Is chage not included
> in Fedora, or was it determined that it didn't need a check?

Fedora CVS tree includes a separate SELinux patch for chage in the
shadow-utils directory.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
