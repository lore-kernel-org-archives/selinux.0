Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12654
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 10:46:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05851
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 14:45:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA05847 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 14:45:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new Debian package
Date: Thu, 25 Apr 2002 16:46:44 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204250958130.13538-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204250958130.13538-100000@raven>
MIME-Version: 1.0
Message-Id: <20020425144644.5EA384626@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 16:00, Stephen Smalley wrote:
> On Thu, 25 Apr 2002, Russell Coker wrote:
> > Also with the current Makefile rules we need the following empty files:
> > file_contexts/program/custom.fc
> > file_contexts/program/kernel.fc
> > file_contexts/program/kmod.fc
> >
> > I haven't worked out how to remove this need so I've just added the empty
> > files to my package.
>
> Yes, I did the same in our internal tree (except I didn't need custom.fc,

Sorry, as you may have guessed custom.te is my file for machine-specific 
configuration which is outside the sample policy.  There are a few domains 
where I need to add some extra rules, and I find it easier to manage things 
by having those extra rules all in one file (where I can see all the 
additions to the standard policy) and having the main .te files for each 
domain just being copies of the default files.

> whatever that is, and I also needed an empty mail.fc since sendmail.fc
> covered both the daemon domain and the user program domains for sendmail).

I just removed mail.te.  It's not really needed.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
