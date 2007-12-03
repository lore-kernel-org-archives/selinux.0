MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: libsemanage patch
Date: Mon, 3 Dec 2007 15:03:03 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455C55@exchange.columbia.tresys.com>
In-Reply-To: <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil>
References: <4754599A.8060605@redhat.com> <6FE441CD9F0C0C479F2D88F959B0158801455C46@exchange.columbia.tresys.com> <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Given that getline() returns the length read (not to be confused with
> the buffer length), why not just:
> 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
> 		if (temp[len-1] == '\n') temp[len-1] = 0;

That is probably the simplest fix.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
