Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i07FtZRb015765
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 10:55:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i07FtXiV020667
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 15:55:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i07FtX06020664 for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 15:55:33 GMT
Subject: Re: Questions about install SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_2004@yahoo.com.cn>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040107154244.96866.qmail@web15202.mail.bjs.yahoo.com>
References: <20040107154244.96866.qmail@web15202.mail.bjs.yahoo.com>
Content-Type: text/plain
Message-Id: <1073490932.24946.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 10:55:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-07 at 10:42, Park Lee wrote:
>  I have installed RedHat 9.0(the Linux kernel version is 2.4.20-8) on
> my computer and downloaded the 2.4.23 kernel with SELinux patch
> applied (i.e. linux-2.4-2003120509.tgz) and the SELinux Full Userland
> Archive (i.e. selinux-usr-2003120509.tgz) from NSA's web site
> (http://www.nsa.gov/selinux).
>  I can unpacked the 2.4.23 kernel with SELinux patch applied and would
> configure and install it successfully. 
>  Then I unpacked the SELinux Full Userland Archive .But when I take
> actions according to the README file,there are always several packages
> cann't be installed rightly.

We are using Fedora Core as our development platform, so some packages
may have dependencies that are not met on RH9.  See
http://fedora.redhat.com.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
