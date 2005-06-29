Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TIoCgA015355
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 14:50:13 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TInJ79019245
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 18:49:19 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506291817.j5TIHQ7f013656@gotham.columbia.tresys.com>
References: <200506291817.j5TIHQ7f013656@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:46:59 -0400
Message-Id: <1120070819.20484.40.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I still don't agree with this - how do you know how to expand these if it is not
> tied to a specific user? 

That's my point exactly - matchpathcon doesn't have the necessary data,
and it will be difficult for it to perform this operation. Expansions
should be performed by programs that know how to do that.

useradd knows the user being added, and the home directory, for example.

We could have a program that walks the fstab, and collects data
on where certain mount points are, and then perform an expansion to
configure that..

We could detect a change in some gconf key that configures a path,
and have it perform an expansion.

I suppose only the sysadm could do this for now, maybe not so 
in the future.

> Additionally, all of this is caused by using file
> contexts for runtime labeling, which I have pointed out repeatedly is a
> questionable security practice.

You've done no such thing - you've pointed out that
automated relabeling without timing control by the sysadmin
is potentially dangerous. I don't see why that means that
automated relabeling (as in..performed internally, and not by
chcon) in general is a bad thing. I'm not sure what you mean by
"runtime labeling".

> Fundamentally wrong seems a little strong - this is just a space / time tradeoff
> not a major architectural decision.

But why? 
What's the gain of doing the same work over and over again?
I mentioned that I don't want to concat files together, but 
at least that way performing the expansion happens once, when
relevant - not on every matchpathcon invocation...

> More importantly, we have just decided to remove specific user information from
> the policy and leaving it in the file contexts seems strange.

The file contexts serves a different purpose.
I agree with you in that I don't like having hundreds of files there,
but at the same time I don't see an alternative.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
