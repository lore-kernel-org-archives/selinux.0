Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25964
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 08:35:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA13919
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:33:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA13913 for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:33:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: /bin/login
Date: Fri, 16 Aug 2002 14:35:06 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208160728480.29385-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208160728480.29385-100000@raven>
MIME-Version: 1.0
Message-Id: <20020816123506.D4DEB3EDC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Aug 2002 13:39, Stephen Smalley wrote:
> On Fri, 16 Aug 2002, Russell Coker wrote:
> > During the login process we see the following prompts for a non-default
> > security context.  Shouldn't the last prompt be "Enter domain" not
> > "Enter type"?
>
> Yes and no.  As explained in the Security Model section of the Configuring
> the SELinux Policy report (as well as in the older policy report and in
> the Ottawa paper), the SELinux TE model does not internally distinguish
> domains from types and uses a single type attribute in the security
> context for both processes and objects.  Hence, "Enter type" is
> legitimate, as is name for the /etc/security/default_type file.  However,
> if we want to use the language of the traditional TE model, we could make
> this "Enter domain" and /etc/security/default_domain.  No big deal either
> way.

It's not just the issue of the language of the traditional TE model in this 
case.  All through the documentation we refer to "domain", so then having the 
login program refer to it as a type is confusing for users.

I am writing documentation for my SE Linux tutorial and this is something 
that will require extra explanation for the users...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
