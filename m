Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6C8M9rT000313
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 04:22:09 -0400 (EDT)
Received: from smtp806.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6C8M7PJ002927
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 08:22:08 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp806.mail.ukl.yahoo.com with SMTP; 12 Jul 2004 08:22:08 -0000
Date: Mon, 12 Jul 2004 09:33:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Thomas Hood <jdthood@aglu.demon.nl>
Cc: 258725@bugs.debian.org, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#258725: Location of net.agent
Message-ID: <20040712083309.GU4677@lkcl.net>
References: <20040711145538.GA15954@wonderland.linux.it> <1089615747.2520.213.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089615747.2520.213.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 12, 2004 at 09:02:27AM +0200, Thomas Hood wrote:

> The reason for using net.agent is precisely to delay the processing
> of hotplug network-interface events until such time as the system is
> ready to bring up network interfaces.

 ah ha :)

> We don't want to switch off the hotplug system prior to this because
> then we would miss the events.

 switch off?

 surely you mean switch on?

> Is it really the case that it would be preferable, for SELinux reasons,
> to put net.agent into a subdirectory of /etc/hotplug/ ?

 the alternative is to make a special case for every single
 file that could possibly, now and in the future, write into
 the directory /etc/hotplug.  as you might imagine, that gets
 quite messy quite quickly.

 by recommending a subdirectory, it is possible to do the
 selinux-equivalent of setgid, such that any file in that
 subdirectory will be made writeable to the hotplug scripts.

 (and incidentally, not by anything else _other_ than the hotplug
  scripts, but that's another story)

 it would also then be possible for distributions that guarantee
 the existence of /var on a local filesystem that will have
 been mounted by /etc/init.d/mountall.sh, to symlink /etc/hotplug/run
 to /var/run/hotplug.

 or /etc/hotplug/state to /var/state/hotplug.

 whichever people who have more experience of FHS than i deem to be
 more appropriate.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
