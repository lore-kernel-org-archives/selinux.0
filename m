Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DEPolF028163
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 10:25:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150207034.3677.28.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150207034.3677.28.camel@moss-tarheels.epoch.ncsc.mil>  <13450.1150204888@warthog.cambridge.redhat.com> <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil> <14647.1150205744@warthog.cambridge.redhat.com> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov,
        sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: Re: [PATCH] keys: randomize key serial numbers 
Date: Tue, 13 Jun 2006 15:25:45 +0100
Message-ID: <21861.1150208745@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> For example, the trojan could transmit an arbitrary binary stream very simply
> by setting itself up on a periodic timer, perhaps on a 100 ms interval.

Wouldn't it be much easier just to use AF_UNIX sockets or similar?  Or do we
have some sort of "firewall" for those?  Out of interest, do we handle the
create/create channel there?  You could have a trojan creating AF_UNIX sockets
using a name based on an increasing number sequence, and a spy probing their
existence by attempting to create them.  They don't even have to be permitted
to connect to one another.

Anyway, how about this for a patch description:

---
The attached patch causes key_alloc_serial() to generate key serial numbers
randomly rather than in linear sequence.

Using an linear sequence permits a covert communication channel to be
established, in which one process can communicate with another by creating or
not creating new keys within a certain timeframe.  The second process can
probe for the expected next key serial number and judge its existence by the
error returned.

This is a problem as the serial number namespace is globally shared between
all tasks, regardless of their context.

For more information on this topic, this old TCSEC guide is recommended:

	http://www.radium.ncsc.mil/tpep/library/rainbow/NCSC-TG-030.html
---

By the way, that URL gives me:

	Error 501
	transparent proxy not supporting non-transparent connections

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
