Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19854
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 18:06:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA21533
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 23:03:51 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id XAA21529
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 23:03:49 GMT
Date: Fri, 3 Jan 2003 10:06:16 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: automake gone?
Message-ID: <20030102230616.GB13385@snoopy.apana.org.au>
References: <se0fbfcb.098@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <se0fbfcb.098@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 30, 2002 at 03:37:56AM -0600, Joshua Brindle wrote:
> Thanks for putting that back :). The archive there is the 2002102211
> one, are you planning on adding automake support in the newest
> (20021212) archive? If not can you give me the info to do it? Thank you

Sorry I have been slow to respond, I have been busy the last week
or so.

I think I had instructions on what I did in one of my earlier E-Mails.
Mostly this just involves copying configure.in and all Makefile.am's
across from my version, however, there was on directory which required
significant source code modifications.

IIRC, the same *.c file was compiled many times with different
parameters to gcc, but automake doesn't make this very easy; I renamed
the *.c file to a *.h file, and created several different *.c files that
#define the appropriate values before #include the *.h file. I think
this directory was the only real problem I encountered, everything
else was very straightforward.

You will also need to change the version number in configure.in

Once this is done, run autoreconf to update th other files.

I don't think I will have time to keep this up-to-date with the latest
SE-Linux version, so it would be good if somebody could take over.

This was based on Russell's version, I am not sure how different
Russell's version is to the upstream code (if it is different).

To test it out, run "make distcheck", this will create a *.tar.gz file,
extract it, and try to compile it *in another directory*. If there are
any missing files, they will be highlighted here. It may have problems
locating the kernel source, I wasn't sure what the best way was of
solving this problem, so I hardcoded the default directory in
configure.in.

If you have problems, then please show me the full command line used and
the full error displayed, and I might be able to help.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
