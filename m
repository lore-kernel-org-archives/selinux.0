Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OC7NgA005081
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 08:07:23 -0400 (EDT)
Subject: Re: [PATCH] selinux_sb_copy_data requires a whole page?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1119558154.10817.45.camel@localhost.localdomain>
References: 
	 <Xine.LNX.4.44.0506231548050.14587-100000@thoron.boston.redhat.com>
	 <1119558154.10817.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 07:56:33 -0400
Message-Id: <1119614193.12865.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:22 -0400, Eric Paris wrote:
> This would still (maybe) leave sec info in the buffer after the null
> whereas previously it would have been nulled out.  Do we care?

I don't think so.  fs code should stop on the NUL byte; if it doesn't,
that is a bug in the fs code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
