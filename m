Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UDFIrT022886
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 09:15:18 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UDEDng005551
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 13:14:13 GMT
Subject: Re: purpose of the staff_r role?
From: Colin Walters <walters@verbum.org>
To: Tom Anderson <granite217@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
References: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 09:17:01 -0400
Message-Id: <1096550221.969.5.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-29 at 18:38 -0700, Tom Anderson wrote:
> Can anyone explain the purpose/benefit of having an account under the
> staff_r role?  I thought it was to allow limited administrative
> functions, but I've discovered that it doesn't even allow reading the
> logfiles under /var/log/.  What purpose does it serve, other than to
> limit who can transition to sysadm_r?

It's the role that a person who can become sysadm_r should do their
daily work in like reading mail, working on source code, etc.  The
reason is because it basically isn't allowed to interact with user_t at
all; for example, staff_t can't read user_tmp_t.  This prevents /tmp
races from working.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
