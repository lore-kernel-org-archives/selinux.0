Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22737
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 13:03:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA25583
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 18:02:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA25579
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2002 18:02:08 GMT
Date: Mon, 11 Mar 2002 13:02:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Greene <pgreene@patriot.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Trouble with Selinux install
In-Reply-To: <Pine.LNX.4.30.0203111242410.9199-100000@adams.patriot.net>
Message-ID: <Pine.GSO.4.33.0203111250380.25401-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 11 Mar 2002, Paul Greene wrote:

> One possibility that came to mind was the CPU type. The system is a
> Pentium 166 w/ 64 megs of RAM; the only option for CPU type in .config was
> for a Pentium III.

You can change that option's value by selecting the "Processor family"
entry under the "Processor type and features" submenu while configuring
your kernel.  The default value in the mainstream kernel tree is Pentium
III, and that won't produce a useable kernel for a Pentium Classic.  Run
'make menuconfig' or 'make xconfig' again in the lsm directory, and fix
your configuration.  Also, be sure that you enabled the driver for your
network card and that you enabled ext3 filesystem support if you want it
(e.g. if you are using RH7.2 with ext3 filesystems).  Then save your new
configuration, rebuild your kernel, and install the new kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
