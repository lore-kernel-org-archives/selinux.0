Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGlNL9008791
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:47:23 -0500 (EST)
Subject: Re: Setting loginuid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050215155312.45937.qmail@web50601.mail.yahoo.com>
References: <20050215155312.45937.qmail@web50601.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1108485556.17854.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 11:39:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 10:53, Steve G wrote:
> 1) Use pam to set the information "pre-fork" and let the child inherit the
> loginuid from the parent process. This muddies up the entry point program's
> information, but is easier to do.

One caveat with this approach: any pam modules run (and any helpers that
they run) after the pam_audit module will then execute with this
loginuid.  We had an issue in this regard for pam_selinux that was
resolved by bracketing the module stack with two instances of
pam_selinux with separate open/close arguments to indicate whether each
instance should perform its processing upon session open or close.  This
then ensured that the exec security context wasn't set until after all
other pam modules (and their helpers) had run upon session open, and
that it was cleared before any other pam modules upon session close.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
