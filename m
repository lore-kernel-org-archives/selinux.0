Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5LNR0gA012255
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 19:27:01 -0400 (EDT)
Received: from ppsw-0.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5LNHSkw018683
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:17:28 GMT
Date: Wed, 22 Jun 2005 00:25:52 +0100
From: Stephen Bennett <spb@gentoo.org>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: 'name_connect' undefined!
Message-ID: <20050622002552.645ab2aa@localhost>
In-Reply-To: <1119394710.9416.23.camel@localhost>
References: <1119394710.9416.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jun 2005 23:58:30 +0100
antoine <antoine@nagafix.co.uk> wrote:

> On a x86 box running Gentoo SELinux profile , I cannot 'emerge
> sync' (in enforcing mode): I get the following error message:
> 
> audit(1119487194.838:0): avc:  denied  { name_connect } for  dest=873
> scontext=root:sysadm_r:portage_fetch_t
> tcontext=system_u:object_r:rsyncd_port_t tclass=tcp_socket
> 

Your selinux-base-policy is older than your kernel, so the access
vectors it knows to allow aren't the same as the ones the kernel tries
to enforce. There should be an update in Portage (probably still
unstable though) to fix this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
