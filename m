Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIIQWt027442
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:18:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FIII0p008638
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:18:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9FIIIr7008635
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:18:18 GMT
Subject: Re: A new kid on the SELinux block!!
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Miguel Guirao <thinkfreemx@yahoo.com.mx>
Cc: SELinux NSA <selinux@tycho.nsa.gov>
In-Reply-To: <20031015140421.10222.qmail@web12605.mail.yahoo.com>
References: <20031015140421.10222.qmail@web12605.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1066241904.7399.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:18:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 10:04, Miguel Guirao wrote:
> Hi!!
> 
> My name is Mike Guirao and I just downloaded SELinux
> 2.4. Since I'm a first time SELinux user I do not know
> is SELinux is just an enhanced linux kernel and should
> be installed as any other kernel, Am I allright?
> 
> Any doc about installing SELinux?

You need the patched kernel and the userland archive.  Build
instructions are included in the userland archive.  Dan Walsh of RH has
put together a set of RPMs available under
ftp://people.redhat.com/dwalsh/SELinux as well as example scripts to
help automate the installation if you prefer.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
