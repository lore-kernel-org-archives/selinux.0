Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18FXsH8028459
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 10:33:55 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18FXrnd016238
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 15:33:54 GMT
Date: Fri, 8 Feb 2008 16:33:51 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: SELinux and Linux user mapping
Message-ID: <20080208153351.GA19504@bobek.pm.i.cz>
References: <1202238356.2672.26.camel@vogon> <1202240861.7533.64.camel@gorn> <20080206115102.GA19285@bobek.pm.i.cz> <1202405185.2683.4.camel@vogon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1202405185.2683.4.camel@vogon>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 07, 2008 at 06:26:25PM +0100, Stefan Schulze Frielinghaus wrote:
>...
> Yeah the problem seems to be with pam and openssh. At the weekend I will
> try another debian-stable machine including your repository.

I cleaned up Debian changelogs a bit, rebuild packages for Etch and Sid.

deb http://linux.i.cz/debian selinux-etch main
deb http://linux.i.cz/debian selinux-sid main

Not too much tested yet :). No better ssh package for Sid yet.
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
