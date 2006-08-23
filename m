Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7NGEs9N014228
	for <selinux@tycho.nsa.gov>; Wed, 23 Aug 2006 12:14:54 -0400
Received: from web51505.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k7NGEbkH021313
	for <selinux@tycho.nsa.gov>; Wed, 23 Aug 2006 16:14:37 GMT
Message-ID: <20060823161452.97820.qmail@web51505.mail.yahoo.com>
Date: Wed, 23 Aug 2006 09:14:52 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Don't send statistics to audit logs
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156345190.8506.50.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>So I think the patch below would likely suffice for your need.

OK, sounds good.

On a separate note...I found that with avc_log, there was no good way to specify
the audit message type. They are all AUDIT_USER_AVC. Suppose some should be
AUDIT_USER_SELINUX_ERR? (There are some messages that are error conditions and
not an access vector calculation.)

Thanks,
-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
