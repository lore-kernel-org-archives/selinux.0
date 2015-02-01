Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t11BHspM012767
 for <selinux@tycho.nsa.gov>; Sun, 1 Feb 2015 06:17:54 -0500
Received: from gator3165.hostgator.com (gator3165.hostgator.com
 [198.57.247.129])
 by gateway04.websitewelcome.com (Postfix) with ESMTP id 7684D8053819
 for <selinux@tycho.nsa.gov>; Sun,  1 Feb 2015 05:17:52 -0600 (CST)
Message-ID: <54CE0B5C.6030509@quantumwise.com>
Date: Sun, 01 Feb 2015 12:17:48 +0100
From: Stefano Borini <stefano.borini@quantumwise.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: spinlock in centos 6.4 and redhat enterprise 6 using chcon
References: <54CA07EC.5090403@quantumwise.com>
 <54CBAE30.5060402@tycho.nsa.gov> <54CBF6B6.9040002@quantumwise.com>
 <54CBF95E.3060109@tycho.nsa.gov>
In-Reply-To: <54CBF95E.3060109@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> I'm wondering if it might be a bug in glibc in that centos release
> rather than in libselinux.  I don't see any relevant difference in
> libselinux/src/setrans_client.c between the .src.rpm for centos 6.4 and
> current master to explain it, so if it is truly a bug in libselinux, it
> would seem to still be present.


Could be. I will try to send them a mail as well, maybe they have
some ideas. I'll keep you guys posted if I learn something useful
for selinux. At this point, I am mostly trying to find a workaround
that doesn't require excessive tinkering from my client. Also,
personal curiosity.


> Also, it looks like 6.4 is long since obsolete, so upgrading would be
> advisable regardless.


It's a business customer and I can't propose that as a solution.


-- 
Stefano Borini
QuantumWise A/S
