Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23077
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:41:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA08294
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:40:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA08290
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:40:23 GMT
Date: Wed, 20 Mar 2002 11:41:14 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: file_contexts
In-Reply-To: <20020319174854.18E9E2387@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201134310.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 19 Mar 2002, Russell Coker wrote:

> I think that the solution is to remove the need for ordering dependencies!
>
> If you change the definition of the format to not have the regex's
> automatically be right-anchored (which requires inserting '$' at appropriate
> places in the current fc file) then you can check for the regular expression
> which gives the largest rm_eo value!

I haven't looked into this closely, but it isn't clear to me how that
would solve the problem.  I would expect the /.* entry to then take
precedence over all other entries.  Even without that entry, you would
have the same problem with other entries that provide a default for a
given directory tree, e.g. /var(|/.*), that are overridden by more
specific entries that occur later.  I'm also not sure how that would
address the multiple hard link problem.

In any event, it appears that we only need to set up ordering properly in
the types.fc file and within each individual domain .fc file, and that the
ordering among the domain .fc files is irrelevant.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
