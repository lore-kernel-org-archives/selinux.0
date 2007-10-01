MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon regressions
Date: Mon, 1 Oct 2007 13:43:47 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFCDE@exchange.columbia.tresys.com>
In-Reply-To: <470120CD.5050009@redhat.com>
References: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com> <470120CD.5050009@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Joshua Brindle" <jbrindle@tresys.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> This patch makes sure /root gets labeled even if it is using the
> default context.

That looks reasonable to me.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
