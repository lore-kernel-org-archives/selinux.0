Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA27865
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 03:32:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA01567
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 07:32:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA01562
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 07:32:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: [patch] Re: 2 checkpolicy bugs
Date: Wed, 5 Jun 2002 13:42:48 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205311507140.25673-200000@raven>
In-Reply-To: <Pine.GSO.4.33.0205311507140.25673-200000@raven>
MIME-Version: 1.0
Message-Id: <20020606073215.2E9A771A0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 May 2002 21:16, Stephen Smalley wrote:
> On Fri, 24 May 2002, Russell Coker wrote:
> > I consider that there are two bugs in checkpolicy, firstly it doesn't
> > accept a valid configuration with no special SIDs assigned to any TCP or
> > UDP ports.
>
> I've attached a patch to checkpolicy and the example policy configuration
> that makes many of the policy components optional, and adds keywords as
> necessary to avoid ambiguities among the various kinds of context
> configurations.  This patch has not yet been committed.  Feedback is
> welcome.

This patch seems great to me!  Having the labels at the start of each line 
makes a lot of sense and will make tracking problems easier.

What we need now is a patch to make it display entire lines of policy.conf on 
errors.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
