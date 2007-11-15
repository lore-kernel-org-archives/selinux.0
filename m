From: David Howells <dhowells@redhat.com>
In-Reply-To: <473B5928.6090800@redhat.com>
References: <473B5928.6090800@redhat.com> <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil> <24415.1194697577@redhat.com> 
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
Date: Thu, 15 Nov 2007 12:17:41 +0000
Message-ID: <363.1195129061@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh <dwalsh@redhat.com> wrote:

> David, we need a method of querying the keyring to see what the selinux
> context that is associated with it.  For debugging purposes.  Currently
> we can not tell whether the policy is correct or not, since we have no
> way to ask the keyring for its label.

That's probably easy enough.  What form does a context take?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
