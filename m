From: David Howells <dhowells@redhat.com>
In-Reply-To: <1195151192.18480.67.camel@moss-spartans.epoch.ncsc.mil>
References: <1195151192.18480.67.camel@moss-spartans.epoch.ncsc.mil> <23847.1195142675@redhat.com> <1195138926.18480.28.camel@moss-spartans.epoch.ncsc.mil> <26342.1195138409@redhat.com> <473B5928.6090800@redhat.com> <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil> <24415.1194697577@redhat.com> <26367.1195138703@redhat.com> <26736.1195148091@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
Date: Thu, 15 Nov 2007 19:04:31 +0000
Message-ID: <5386.1195153471@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +	rc = security_sid_to_context(ksec->sid, &context, &len);
> > +	if (!rc)
> > +		rc = len;
> > +	*_buffer = context;
> > +	return len;
> 
> return rc?

Good point.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
