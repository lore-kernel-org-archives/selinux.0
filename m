Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h57Hb6I4008895
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 13:37:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h57Hb5tV012480
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 17:37:05 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h57Hb5al012477 for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 17:37:05 GMT
Received: from commander.av8.net (IDENT:dean@commander.av8.net [130.105.11.4])
	by citation.av8.net (8.9.3/8.9.3) with ESMTP id NAA14029
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 13:34:18 -0400
Date: Sat, 7 Jun 2003 13:35:33 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: Filtering duplicate message-ID's with procmail
Message-ID: <Pine.LNX.4.44.0306071333010.18878-100000@commander.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


# remove duplicate messages, ie. to me and mailing list
:0 Wh: msgid.lock
| formail -D 32768 $MAILDIR/cache.msgid

There are other recipes to look at. Sieve can also do this, I think, but
I'm not sure what the incantation is.

		--Dean

> Dean Anderson <dean@av8.com> wrote:
> > You can filter duplicate messages by rejecting duplicate message ids.
> >
> > There is a reason that mailers include the original sender on the cc-list:
> > It is so that you get the mail faster, and can think about composing a
> > response. Sometimes lists are very slow.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
