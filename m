Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23525
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 12:12:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA01555
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:11:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA01551 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:11:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Wed, 20 Mar 2002 18:12:16 +0100
Cc: selinux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203201145570.11981-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203201145570.11981-100000@raven>
MIME-Version: 1.0
Message-Id: <20020320171217.2BF8A3CF33@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 17:47, Stephen Smalley wrote:
> On Wed, 20 Mar 2002, Russell Coker wrote:
> > Another thing is that I need to patch setfiles to take a list of file
> > names on standard input.  Checking the entire file system after replacing
> > a single package does not make sense.
>
> I'd suggest using chcon or chsid for that purpose.  Just provide a script
> with each package that runs chcon/chsid with the appropriate context for
> each file installed by the package.  I would also recommend updating the
> setfiles configuration for any future 'make relabel' commands, but not
> necessarily running it each time.

I don't like that idea at all.  Having two sources for the same data is 
guaranteed to cause you trouble.

What benefit is there to using chsid instead of a hacked setfiles?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
