Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA03757
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 12:52:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA16832
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:50:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA16827 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:50:56 GMT
Date: Tue, 24 Sep 2002 12:52:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: david caplan <dac@tresys.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy and login names
In-Reply-To: <GBEAJBKHFOBIBBJBCGAGKEKGCFAA.dac@tresys.com>
Message-ID: <Pine.GSO.4.33.0209241246010.23277-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 24 Sep 2002, david caplan wrote:

> We just ran across the case where we were trying to add a login name with a
> '.' in it.  When we tried to add the user to the policy, checkpolicy choked
> on the '.' in the id.  The parser expects an Identifier, which is defined to
> be a letter followed by a combination of letter|digit|_ of any length.
>
> Is there a compelling reason that this definition can't be changed?  I'm not
> sure if changing it would cause problems elsewhere in the policy mechanism.
> There don't appear to be problems with using '.'s and '-'s in login names as
> far as RedHat/Linux is concerned. I can't find any "standard" definition for
> what are valid characters in a login name.  Some applications, such as ps,
> that have problems with the characters just use the uid instead.  Others,
> such as sendmail/pop and ssh, don't have a problem (at least in the versions
> we're using).

No, we can certainly extend the checkpolicy scanner to accept more general
strings for identifiers.  The only restriction for a user name would be
that you can't use a colon, since that is a field separator in the
security context.  Feel free to submit a patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
