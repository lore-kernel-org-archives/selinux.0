Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23441
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 10:19:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA27902
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 14:17:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA27894 for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 14:17:36 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: makefile patch
Date: Thu, 29 Aug 2002 16:19:01 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208290844400.2189-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208290844400.2189-100000@raven>
MIME-Version: 1.0
Message-Id: <20020829141901.911CE9273@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Aug 2002 14:45, Stephen Smalley wrote:
> On Wed, 28 Aug 2002, Russell Coker wrote:
> > In the post-install script of my selinux-policy-default package I have
> > the following:
> >   make -s -C /etc/selinux install
> >   make -s -C /etc/selinux load || true
> >
> > This results in the policy being compiled twice when using the NSA
> > Makefile, I've attached a patch to fix this.
>
> This breaks if you don't already have a tmp directory pre-created.  Try
> removing your tmp directory and doing a make (or a make policy.conf).

Right: I added the "mkdir -p tmp" line in the following to solve that.

Basically I just put in a "mkdir -p tmp" wherever it is used when it might 
not have been created.

tmp/program_used_flags.te: $(wildcard domains/program/*.te) domains/program
        mkdir -p tmp
        ( cd domains/program/ ; for n in *.te ; do echo "define(\`$$n')"; 
done ) > $@

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
