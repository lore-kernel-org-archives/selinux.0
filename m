Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8O0Lg4N015691
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 20:21:42 -0400
Received: from goalkeeper.city-fan.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8O0LfwJ018092
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 00:21:42 GMT
Date: Wed, 24 Sep 2008 01:21:31 +0100
From: Paul Howarth <paul@city-fan.org>
To: "Mike Sweetser - Adhost" <mikesw@adhost.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: How to find SELinux policy type?
Message-ID: <20080924012131.76c5e84f@metropolis.intra.city-fan.org>
In-Reply-To: <17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan>
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
	<17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Sep 2008 16:32:16 -0700
"Mike Sweetser - Adhost" <mikesw@adhost.com> wrote:

> James,
> 
> The following command set should give you what you want:
> 
> grep '^SELINUXTYPE' /etc/selinux/config | awk '{split($0,a,"="); print
> a[2];}'
> 
> When run against my targeted setup on RHEL 5.2, it gave me back
> "targeted".

There's also the "sestatus" command:

# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 21
Policy from config file:        targeted

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
