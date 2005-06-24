Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OFwggA007295
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 11:58:43 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OFwfUD019659
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:58:41 GMT
Subject: Re: mdadm policy
From: Colin Walters <walters@redhat.com>
To: ivg2@cornell.edu
Cc: antoine <antoine@nagafix.co.uk>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119627684.30464.8.camel@celtics.boston.redhat.com>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 11:58:26 -0400
Message-Id: <1119628706.3450.5.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 11:41 -0400, Ivan Gyurdiev wrote:

> Those rules are usually added to access /etc/fstab and
> /etc/mtab.

And all the other random libc files.

> > * self:capability dac_override ipc_lock
> This looks interesting...

Could potentially be a problem; it'd be useful to track down what part
of the code needed it.

> > * read_sysctl(mdadm_t)
> > * r_dir_file(mdadm_t, sysfs_t)

I'm not sure why your version wouldn't need this.

> > * read_locale(mdadm_t)

You probably don't need this because you're using the "C" locale, but
the Fedora default is UTF-8, so it needs access to the locale files.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
