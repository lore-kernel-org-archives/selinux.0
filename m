Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA05878
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:48:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA15874
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 19:47:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA15864 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 19:47:20 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Frank Mayer <mayerf@tresys.com>
Subject: Re: Proposal: install policy.conf
Date: Tue, 28 May 2002 21:48:26 +0200
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205281109490.1315-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205281109490.1315-100000@raven>
MIME-Version: 1.0
Message-Id: <20020528194826.E468A234F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 May 2002 17:19, Stephen Smalley wrote:
> On Fri, 24 May 2002, Frank Mayer wrote:
> > What we'd like to see is /etc/security/policy.conf treated as the
> > definitive policy for a system, allowing all sorts of tools to change,
> > create, or otherwise manage all or portions of the installed policy.
>
> Do we want to include something in the compiled policy (currently
> installed into /etc/security/selinux/policy.VERSION) that helps to
> associate it with a particular policy.conf?  For example, we could compute
> a message digest of the policy.conf file and include it in the compiled
> policy header.

I agree with your comments below, which is why I can't see any benefit in 
what you suggest above.  But of course if there's demand for such a thing, 
then why not.

Perhaps people who have different requirements should consider writing their 
own checkpolicy program?  Then you could reserve a section of the file for an 
identifier with a length field so they can store whatever they like,

> With regard to the issue of using policy.conf as the basis for tools that
> are used to create or change the policy, I'm somewhat concerned by the
> loss in modularity provided by the separation of .te files and the loss in
> higher level abstraction provided by the macros.  I suppose that we could
> extend the base language itself to provide direct constructs for "modules"
> and for some of the higher level abstractions currently expressed via
> macros.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
