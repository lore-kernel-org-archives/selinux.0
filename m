Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14270
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 10:18:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA00739
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 14:18:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA00735
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 14:18:38 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: auditdeny is painful
Date: Tue, 4 Jun 2002 16:18:38 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206040908440.3949-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206040908440.3949-100000@raven>
MIME-Version: 1.0
Message-Id: <20020604141838.4C49073ED@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 15:28, Stephen Smalley wrote:
> you don't want audited, as with other rules.  When multiple auditdeny
> rules are specified for a single (type, type, class) triple, the union of
> the permission sets is used, as with other rules.

The problem is that it is the union of the audit rules, but when people are 
writing such rules they tend to do them as "don't audit" rules so we get the 
intersection instead.

> I suppose that we could introduce a dontaudit rule that automatically
> generates auditdeny access vectors with the complement of the specified
> set of permissions, and that uses the intersection of the permission sets
> when multiple rules are specified for a single (type, type, class) triple.
> This would likely be more suited to what a human would expect.

Sounds good to me!

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
