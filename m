Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16257
	for <selinux@tycho.nsa.gov>; Sat, 9 Mar 2002 08:04:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA26249
	for <selinux@tycho.nsa.gov>; Sat, 9 Mar 2002 13:03:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA26245
	for <selinux@tycho.nsa.gov>; Sat, 9 Mar 2002 13:03:39 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: automatic type transitions for pts in devfs
Date: Sat, 9 Mar 2002 14:04:34 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203060828430.24985-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203060828430.24985-100000@raven>
MIME-Version: 1.0
Message-Id: <20020309130435.3B011D12B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Mar 2002 14:41, Stephen Smalley wrote:
> On Wed, 6 Mar 2002, Russell Coker wrote:
> > It seems that the automatic type transitions for /dev/pts don't work on
> > devfs.  When the sshd (in sshd_t domain) opens /dev/pts/1 it does not get
> > changed to sshd_devpts_t domain.
>
> Right.  The initial labeling of pty nodes based on the allocating process
> domain is only implemented for the devpts filesystem at present, not the
[...]
> At present, we don't use devfs on our systems, so it hasn't (yet) been a
> priority to provide identical functionality in devfs.

I've tried patching that myself, but it seems that my skills are not up to it.

It seems that the filp->f_owner.pid is being set in the devfs initialisation 
code somehow at an earlier stage than in devpts, therefore by the time 
tty_fasync() is called it's already done and the set_fowner() call is skipped.

Could you give me a clue as to where I should look next?  Or would you 
recommend that I give up?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
