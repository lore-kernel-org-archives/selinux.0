Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14022
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 07:50:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA01640
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:49:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA01636 for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:49:16 GMT
Date: Mon, 22 Jul 2002 07:50:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: policy_src_t
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIAENIKEAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0207220745520.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 19 Jul 2002, Frank Mayer wrote:

> Is the type policy_src_t being used?  It doesn't appear so.  We're trying to
> update our tools to work with the recent policy syntax changes, as well as
> create a policy for our tools themselves.  We need to read, modify, and
> re-install a policy in an operational system.  As previously indicated, that
> requires an installed policy.conf (we'll submit a proposed patch to the
> makefile to do this next week).
>
> In addition, for now we also need a known location for the policy source
> make directory.  It seems logical that this directory would also have
> policy_src_t.  If there are no specific plans to use this type, then we'll
> be glad to submit a proposed use.  If there are plans, we'd like to hear
> what they are so we can make our tools work within those plans. Thanks

The policy/file_contexts/types.fc file specifies the policy_src_t type for
/etc/selinux, /usr/lib/selinux, and /usr/share/selinux.  I think that
these entries are based on Russell Coker's SE-Debian package, which
installs the policy sources, unlike the existing upstream SELinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
