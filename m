Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23439
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 12:06:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA01289
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:05:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA01283 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:05:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: file_contexts
Date: Wed, 20 Mar 2002 18:06:19 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203201134310.11981-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203201134310.11981-100000@raven>
MIME-Version: 1.0
Message-Id: <20020320170620.06E973CEFF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 17:41, Stephen Smalley wrote:
> > I think that the solution is to remove the need for ordering
> > dependencies!
> >
> > If you change the definition of the format to not have the regex's
> > automatically be right-anchored (which requires inserting '$' at
> > appropriate places in the current fc file) then you can check for the
> > regular expression which gives the largest rm_eo value!
>
> I haven't looked into this closely, but it isn't clear to me how that
> would solve the problem.  I would expect the /.* entry to then take

First you replace "/.*" with "/", as without right anchoring "/" would match 
everything, but with a length of 1.  Anything else that matches would be a 
better match.

> precedence over all other entries.  Even without that entry, you would
> have the same problem with other entries that provide a default for a
> given directory tree, e.g. /var(|/.*), that are overridden by more

You replace "/var(|/.*)" with "/var".

> specific entries that occur later.  I'm also not sure how that would
> address the multiple hard link problem.

You are right it would not solve the problem apart from in a few specific 
cases.

> In any event, it appears that we only need to set up ordering properly in
> the types.fc file and within each individual domain .fc file, and that the
> ordering among the domain .fc files is irrelevant.

With the current sample policy the ordering among the .fc files is not 
relevant, with the next version who knows...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
