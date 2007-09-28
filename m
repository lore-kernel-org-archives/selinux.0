MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon regressions
Date: Fri, 28 Sep 2007 10:23:54 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
In-Reply-To: <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
References: <20070927200712.950671948@tresys.com> <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil> <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Looking again at the output, the order differs - the libsemanage
> genhomedircon puts the specific user entries first and then the
> generic /home entries, which seems wrong given that later entries take
> precedence for matchpathcon.  genhomedircon script does the opposite.

This change was present in the modified diff Dan sent and I preserved
that change in the patch set.  At the time I had thought it was moved
to make the output better match the python script but that appears not
to be the case.

It is easy to change back but I'm sure there was a reason for the move.
Perhaps Dan can shed some light on this.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
