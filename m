Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA27570
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 20:32:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA12781
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 00:30:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA12777 for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 00:30:56 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: selinux question
Date: Wed, 24 Jul 2002 02:32:19 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020717025148.GA25379@snoopy.apana.org.au> <20020723131932.EE9B4116C@lyta.coker.com.au> <1027470348.8943.77.camel@scrooge>
In-Reply-To: <1027470348.8943.77.camel@scrooge>
MIME-Version: 1.0
Message-Id: <20020724003219.D2A766C96@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Jul 2002 02:25, Brian May wrote:
> On Tue, 2002-07-23 at 23:19, Russell Coker wrote:
> > I've run into a similar issue, some scripts such as dh_installdocs call
> > "cp -a" which tries to do such a chsid and fails.  I think that "cp -a"
> > should not preserve sids to avoid breaking compatability in such
> > situations. Generally when "cp -a" is called you don't even want to
> > preserve the UID, just the mode.
>
> I have to ask why does dh_installdocs use cp -a, and not cp -dR.
>
> It doesn't need to copy ownership or group, or permissions, as these
> will be reset later on by dh_fixperms.
>
> It doesn't want to copy SIDs, as even if (or when) tar supported this, I
> don't think you want Debian packages to come supplied with built in
> SIDs.

Good point.  I've filed a bug report against dh_installdocs.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
