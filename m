Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA27489
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 07:14:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA15266
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:13:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA15262
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:13:06 GMT
Date: Mon, 26 Aug 2002 07:13:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SRCINSTALLDIR
In-Reply-To: <20020824212254.143608CE4@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208260712460.10972-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 24 Aug 2002, Russell Coker wrote:

> The operation of policy/Makefile in the new release does not include the
> policy version number in the source, and thus is based on the assumption that
> a policy.conf file will support multiple versions of the policydb.
>
> This assumption does not hold for past versions, is there any reason that we
> can be sure it will hold for future versions?  If not then I suggest that the
> right thing to do is to have a version number in the policy.conf file name
> (maybe policy.conf.11 or whatever the version is)?
>
> Or do we consider it OK to have a source directory that doesn't contain the
> sources to all the binaries in the binary directory?

If we apply a version number to the source file, we should probably use a
separate and independent version number that tracks changes to the policy
language.  The binary policy version number tracks changes to the binary
policy format, so it may change without affecting the source file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
