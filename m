Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBACKUIi019814
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 07:20:30 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBACIpwg019071
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 12:18:52 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <20041209200301.59535.qmail@web50204.mail.yahoo.com>
References: <20041209200301.59535.qmail@web50204.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 23:20:26 +1100
Message-Id: <1102681226.4509.139.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:03 -0800, Casey Schaufler wrote:
> In the U2X world the issue of /tmp was solved

What is U2X?

>     /tmp becomes /tmp/<labelname>

There is talk of adding poly-instantiated directories to SE Linux which
will give similar facilities.  I'm not aware of any code release yet
though.

> and then resolution continues. A process with a
> "moldy" attribute of it's own is does not have the
> additional component added, addressing the admin
> issue. Some systems created the subdirectories on
> reference, others required it be done
> administratively. There are similar tricks that
> can be played with variable symlinks.

Yes, that solves many of the issues related to users attacking other
users via sym-links.  But it doesn't entirely solve the issues related
to attacking the administrator processes.  It's a fairly standard
practice for the administrator to inspect the files of a user and modify
them on occasion.  This means that the admin has to work inside the
mouldy directory.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
