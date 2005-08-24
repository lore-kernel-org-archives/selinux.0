Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OF1wOb007500
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 11:01:58 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430C88C5.5050306@trustedcs.com>
References: <430A33E5.1030100@redhat.com>
	 <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>
	 <430B3A7B.6020208@redhat.com>
	 <1124809493.7874.75.camel@moss-spartans.epoch.ncsc.mil>
	 <430C88C5.5050306@trustedcs.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 10:49:24 -0400
Message-Id: <1124894964.11553.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 09:48 -0500, Darrel Goeddel wrote:
> Our MITRE based translator really like the whitespace...  I agree that the
> whitespace is a pain, but we have been using this for quite a while and have
> not run into problems with any utilities that I am aware of.  My biggest gripe
> is having to quote arguments to commands when a context has whitespace...
> How about we allow for it, and let those who choose to use whitespace
> (unfortunately our translation scheme) deal with the repercussions :)

I'm still concerned about the implications for utilities that display
the contexts, and particularly for any scripts that filter output of
such utilities and expect to be able to extract context fields.  It
seems like we'd need to quote the context strings in the output always
to ensure that scripts won't break when someone switches from the
default libsetrans to the MITRE-based one.

Alternatively, your MITRE-based translator could wrap the MITRE
translation with a converter to eliminate whitespace (dropping it or
replacing it with e.g. underscores), so that libselinux and the
utilities (and users) would never have to deal with them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
