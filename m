From: David Howells <dhowells@redhat.com>
In-Reply-To: <26342.1195138409@redhat.com>
References: <26342.1195138409@redhat.com> <473B5928.6090800@redhat.com> <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil> <24415.1194697577@redhat.com> 
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
Date: Thu, 15 Nov 2007 14:58:23 +0000
Message-ID: <26367.1195138703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> Does it need to be accessible from kernel space?  Can I pass a userspace
> buffer pointer through to the LSM?

In fact, is the best way to do it to have a prototype like:

	int security_key_getsecurity(struct key *key, char **_buffer);

Where the buffer is allocated by this function and attached to *_buffer and
the length returned if successful (though that last is unnecessary if a
NUL-terminated string is being returned); and if an error occurs, then that is
returned instead.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
