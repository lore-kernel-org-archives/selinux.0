Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA27873
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 03:32:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA21003
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 07:31:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id HAA20999 for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 07:31:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: [patch] Re: auditdeny is painful
Date: Wed, 5 Jun 2002 13:19:26 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206041520480.3949-200000@raven>
In-Reply-To: <Pine.GSO.4.33.0206041520480.3949-200000@raven>
MIME-Version: 1.0
Message-Id: <20020606073214.F18567183@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 21:24, Stephen Smalley wrote:
> On Tue, 4 Jun 2002, Stephen Smalley wrote:
> > I suppose that we could introduce a dontaudit rule that automatically
> > generates auditdeny access vectors with the complement of the specified
> > set of permissions, and that uses the intersection of the permission sets
> > when multiple rules are specified for a single (type, type, class)
> > triple. This would likely be more suited to what a human would expect.
>
> I've attached a patch to checkpolicy and the example policy configuration
> that adds support for these 'dontaudit' rules and replaces all 'auditdeny'
> rules in the example configuration with equivalent 'dontaudit' rules.
> This patch has not yet been committed.  Feedback is welcome (as with the
> prior checkpolicy patch for optional sections).

Looks good to me.  I've just built some packages with it, and after a brief 
test they seem to work OK.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
