Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i395NjRb023020
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 01:23:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i395Nimw029339
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 05:23:44 GMT
Received: from mutemail.com (mutemail.com [24.244.170.124])
        by jazzband.ncsc.mil  with SMTP id i395Ni4w029336 for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 05:23:44 GMT
Date: Thu, 08 Apr 2004 22:23:19 -0700
From: Bill McCarty <bmccarty@pt-net.net>
To: Tom <tom@lemuria.org>
cc: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <280262546.1081462998@[192.168.0.3]>
In-Reply-To: <20040407075405.D19421@lemuria.org>
References: <401FF280.8070301@treblig.org>
 <88042458.1081270777@[192.168.0.3]> <20040407075405.D19421@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Tom and all,

--On Wednesday, April 07, 2004 7:54 AM +0200 Tom <tom@lemuria.org> wrote:

> Those are for woody, not unstable. Look at my site for apt sources for
> the other distros (http://selinux.lemuria.org)

I ditched my not-quite-right Linux 2.4 installation of SELinux and had a go 
at at Linux 2.6 installation under Debian Sid, created by following Tom's 
excellent instructions at <http://selinux.lemuria.org/install-2.6.html>.

However, I ran into a snag. Sid's SSH package has been updated to require 
libpam-runtime 0.76-14 or greater, and the latest libpam-runtime having 
SELinux mods is only 0.76-13.

Although I was once familiar with Debian, I no longer know my way around 
it. Is there a way to instruct apt-get to ignore such a package dependency? 
I haven't been able to find an appropriate option in the man pages. I 
suppose that I could manually download the SSH package and install it via 
dpkg, which has a --force option. Is that the way to go?

Cheers,

---------------------------------------------------
Bill McCarty, Ph.D.
Professor of Information Technology
Azusa Pacific University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
