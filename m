Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA20338
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 13:45:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA03886
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 17:44:37 GMT
Received: from lyta.coker.com.au ([209.151.19.136])
	by jazzswing.ncsc.mil  with ESMTP id RAA03882
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 17:44:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: David@liss.co.uk
Subject: Re: SE Linux loading procedure.
Date: Wed, 26 Jun 2002 13:44:59 -0400
References: <20020626014343.27598.qmail@linuxmail.org> <20020626140224.C57FE1B0D@lyta.coker.com.au> <001b01c21d2f$7433dea0$1c00000a@liss.ltd.uk>
In-Reply-To: <001b01c21d2f$7433dea0$1c00000a@liss.ltd.uk>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020626174459.AFAC27C47@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Jun 2002 12:35, you wrote:
> > The NSA do not distribute Debian packages or RPM packages and are
> > unlikely
>
> to
>
> > ever do so.  I will be strongly encouraging them not to distribute Debian
> > packages.
>
> I've only been reading this list for about a month so I hope you don't mind
> me asking you this directly to avoid getting flamed over what may/may not
> be a previously well covered bone of contention:

I don't think that's any risk so I'll answer on the list.

> Why do you think that the NSA should not package SELinux? - Would they not
> have an interest in updating them on a regular basis or is something else?

If an NSA employee signs up to become a Debian developer and convinces me 
that they can do a better job of packaging it for Debian than I do then I 
would be prepared to transfer ownership.  However given legal issues that 
limit their ability to make fast new releases I think that is unlikely.  Also 
with the way the Debian community operates, even having an FBI employee as a 
developer would be regarded as controversial...  So I think that the NSA 
would not want their employees as Debian developers as it would result in 
controversy and possible bad PR.

So given that I will keep maintaining the official Debian packages, why would 
the NSA want to ship any Debian packages?  That would just result in 
confusion and it would be better for everyone if they didn't do so.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
