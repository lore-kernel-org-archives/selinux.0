Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39E8qRb024951
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 10:08:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i39E6aUZ000560
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 14:06:36 GMT
Received: from mail.lemuria.org (web.lemuria.org [213.191.85.3])
	by jazzswing.ncsc.mil  with ESMTP id i39E6ZmT000550
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 14:06:36 GMT
Date: Fri, 9 Apr 2004 15:59:18 +0200
From: Tom <tom@lemuria.org>
To: Bill McCarty <bmccarty@pt-net.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <20040409155916.A21924@lemuria.org>
References: <401FF280.8070301@treblig.org> <88042458.1081270777@[192.168.0.3]> <20040407075405.D19421@lemuria.org> <280262546.1081462998@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <280262546.1081462998@[192.168.0.3]>; from bmccarty@pt-net.net on Thu, Apr 08, 2004 at 10:23:19PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 08, 2004 at 10:23:19PM -0700, Bill McCarty wrote:
> However, I ran into a snag. Sid's SSH package has been updated to require 
> libpam-runtime 0.76-14 or greater, and the latest libpam-runtime having 
> SELinux mods is only 0.76-13.
> 
> Although I was once familiar with Debian, I no longer know my way around 
> it. Is there a way to instruct apt-get to ignore such a package dependency? 
> I haven't been able to find an appropriate option in the man pages. I 
> suppose that I could manually download the SSH package and install it via 
> dpkg, which has a --force option. Is that the way to go?

Yes. Just to be sure I usually keep a full copy of the package archive
locally (just the SE progs) and then do something like dpkg -i * after
every upgrade.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
