MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 7/7] Use -Werror
Date: Wed, 9 Jan 2008 10:33:46 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880153F456@exchange.columbia.tresys.com>
In-Reply-To: <4784D902.6000802@manicmethod.com>
References: <200801072047.m07KlXAs026116@cadmus.columbia.tresys.com> <1199884164.9393.210.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880153F432@exchange.columbia.tresys.com> <4784D902.6000802@manicmethod.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Joshua Brindle" <method@manicmethod.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
 
> Also with DEBUG=1 there is another warning in newrole.c about a
> shadowed var.

I didn't have pam-devel installed on my build machine so this wasn't
showing up for me.  I've fixed the shadowed declaration now.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
