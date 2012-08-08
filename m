Message-ID: <1344459345.25533.15.camel@localhost>
Subject: Re: A filename to label translation daemon
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, lennart@poettering.net, dwalsh@redhat.com
Date: Wed, 08 Aug 2012 16:55:45 -0400
In-Reply-To: <1344456337.22629.17.camel@moss-pluto.epoch.ncsc.mil>
References: <1344454290.25533.12.camel@localhost>
	 <1344456337.22629.17.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-08-08 at 16:05 -0400, Stephen Smalley wrote:
> On Wed, 2012-08-08 at 15:31 -0400, Eric Paris wrote:

> Not sure how this helps systemd, as it runs first (by definition) and
> loads the file_contexts configuration before it starts any other
> daemons, right?  Now if you wanted systemd to export this as a service
> to everything else, that might make sense.

If we agree a label daemon is useful and practical I'm sure we can find
a way to get systemd to either use it or be the label daemon.  It might
be as easy as getting systemd to activate it earlier than it normally
activates things.  Although maybe the code needs to live in systemd
itself.  I don't know right now.  I'm still in the, "is this as good an
idea as it seems" stage?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
