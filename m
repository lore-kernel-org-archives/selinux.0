Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04758
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 10:34:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14724
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:33:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA14720 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:33:25 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: setfiles patch
Date: Thu, 18 Apr 2002 16:34:23 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204180831400.26541-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204180831400.26541-100000@raven>
MIME-Version: 1.0
Message-Id: <20020418143424.05AE5181C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 14:33, Stephen Smalley wrote:
> On Thu, 18 Apr 2002, Russell Coker wrote:
> > I have attached a patch for setfiles which gives support for files larger
> > than 2G on i386, and which changes the support for file names on stdin to
> > use a "-s" option flag instead of specifying "-" as the partition name.
> >
> > The large file support is a bit of a quick hack, I need to have something
> > like #ifdef i386 around the definition of _LARGEFILE64_SOURCE, or maybe
> > some autoconf stuff.
> >
> > But it's quite functional as a sample, and if you have a i386 machine
> > with some >2G files you'll probably be very happy with this patch.
>
> setfiles should already work for large files.  The -D_FILE_OFFSET_BITS=64
> flag in the Makefile CFLAGS definition causes stat structures and calls to
> be transparently remapped to stat64.

Right, thanks for the advice.

I have relised my mistake, I was over-riding those CFLAGS in my build process.

I have attached my latest patch which just adds a "-s" switch for taking file 
names from standard input and a "-m" switch to not display the missed regular 
expressions afterwards.

Actually maybe it should be the other way around, use a "-m" if you want to 
see the unmatched regex's - they don't seem very useful to me.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
