MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon regressions
Date: Fri, 28 Sep 2007 11:00:57 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFB86@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
References: <20070927200712.950671948@tresys.com> <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil> <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Todd Miller" <tmiller@tresys.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Josh just pointed out that unlike file_contexts,
file_contexts.homedir isn't sorted via semanage_fc_sort().

This is probably the best solution, though it would mean
we lose the comments (they get stripped out during the
sorting for obvious reasons).

Thoughts?

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
