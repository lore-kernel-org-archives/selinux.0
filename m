Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7MBV7La008652
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 07:31:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7MBV6fF013491
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 11:31:06 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id h7MBV5Hd013488 for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 11:31:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7MBV4mG009154
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 07:31:04 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7MBV4k1009152
	for selinux@tycho.nsa.gov; Fri, 22 Aug 2003 07:31:04 -0400
Date: Fri, 22 Aug 2003 08:32:23 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Colin Walters <walters@verbum.org>
Cc: Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SELinux@tycho.nsa.gov
Subject: Re: 2.6.0-test3
Message-ID: <20030821223223.GA20695@snoopy.apana.org.au>
References: <200308212337.59952.russell@coker.com.au> <1061487623.22355.27.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1061487623.22355.27.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 21, 2003 at 01:40:23PM -0400, Colin Walters wrote:
> Eventually, I'd like to not have to use any packages outside of unstable
> at all.  Russell, what do you think about starting to send these patches
> to the Debian package maintainers and get them integrated?  At least the
> Debian coreutils package already applies over 50 patches, one more
> wouldn't hurt :)
> The only drawback I see is a dependency on libselinux, but it's so small
> anyways.

Does the libselinux in unstable support the 2.6 interface yet?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
