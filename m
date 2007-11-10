From: David Howells <dhowells@redhat.com>
In-Reply-To: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
References: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
Date: Sat, 10 Nov 2007 12:26:17 +0000
Message-ID: <24415.1194697577@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Ah, wait - this is an automatic allocation of a per-uid keyring upon a
> setuid() call, right?

Yes.

> and a single Linux uid might ultimately have a number of SELinux security
> contexts running on its behalf.

Indeed.  It's not something that anyone considered at the time, I suppose.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
