Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CJYUrT005208
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 15:34:31 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CJY9DC002903
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 19:34:10 GMT
Date: Mon, 12 Jul 2004 20:44:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Hood <jdthood@aglu.demon.nl>, 258725@bugs.debian.org,
   "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#258725: Location of net.agent
Message-ID: <20040712194451.GA7550@lkcl.net>
References: <20040711145538.GA15954@wonderland.linux.it> <1089615747.2520.213.camel@localhost.localdomain> <20040712083309.GU4677@lkcl.net> <200407122116.36896.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407122116.36896.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i been thinking a bit more.

perhaps there should be a debian installer-option which specifies the
directory for state information: it should be a high-priority option
and should end up placing the writeable-directory-location into
/etc/default/hotplug under some appropriate variable, e.g.
STATE_DIRECTORY.

then, wherever hotplug refers to /etc/hotplug to write files, place
$(STATE_DIRECTORY) in front of it, which is read from
/etc/default/hotplug.

the information presented to the person doing the installation should
be something like this:

	"Please type in [select?] a directory location for hotplug to
	 put its state information.

	Bear in mind that the directory must be writeable very early in
	start-up time, so if you select /var/run/hotplug, for example,
	and /var is NFS mounted, the directory may not yet be accessible.

	If you are running a really weird non-standard system (NFS mounted,
	lots of partitions, an SE/Linux system with read-only access to /etc,
	you may wish to use /devfs/shm/tmp.

	If you do not know what this is all talking about, just press
	<return> to select /etc/hotplug/run as the default"

this will at least allow people to install systems that will work in
almost all cases.

l.

On Mon, 12 Jul 2004 18:33, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  by recommending a subdirectory, it is possible to do the
>  selinux-equivalent of setgid, such that any file in that
>  subdirectory will be made writeable to the hotplug scripts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
