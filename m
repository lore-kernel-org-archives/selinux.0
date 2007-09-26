MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I am concerned about putting genhomedircon changesinlibsemanage into Fedora 8.
Date: Wed, 26 Sep 2007 17:41:58 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFA00@exchange.columbia.tresys.com>
In-Reply-To: <1190838018.15779.170.camel@moss-spartans.epoch.ncsc.mil>
References: <200709262001.l8QK1Skx029939@tex.courtesan.com> <1190836803.15779.159.camel@moss-spartans.epoch.ncsc.mil> <1190838018.15779.170.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> - A diff of file_contexts.homedirs generated via libsemanage vs. the
> old /usr/sbin/genhomedircon script shows differences on rawhide.  Not
> sure who is right.  Diff below.

It looks like the new genhomedircon is being overzealous in its
replacemen
of system_u.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
