Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06473
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 09:54:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA26817
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:53:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA26813 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:53:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Fri, 22 Mar 2002 15:54:45 +0100
Cc: selinux <selinux@tycho.nsa.gov>
References: <20020320171217.2BF8A3CF33@lyta.coker.com.au> <Pine.GSO.4.33.0203201230580.11981-100000@raven> <20020322140833.GD2123@vnl.com>
In-Reply-To: <20020322140833.GD2123@vnl.com>
MIME-Version: 1.0
Message-Id: <20020322145445.497E5EFD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Mar 2002 15:08, Dale Amon wrote:
> On Wed, Mar 20, 2002 at 12:48:40PM -0500, Stephen Smalley wrote:
> > When a new package is installed on a system running SELinux, I expected
> > chcon or the modified file utilities to be used to set the security
> > context appropriately for its files in a similar manner to the use
> > of chown/chmod or the existing file utilities for setting the Unix
> > attributes.  But it also seems necessary to update the setfiles
> > configuration for future installations, resets, or major policy changes.
> > So perhaps a hacked setfiles is a good idea.
>
> Perhaps a 'setfiles --dump > file_contexts' capability is in order?

Making that generate a list suitable for setsid or chcon would be easy.  
Making it generate something that approximates the original file_contexts 
would be very difficult.  Also there are lots of files that won't be on a 
typical system which are in file_contexts, how would a setfiles --dump handle 
them?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
