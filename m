Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA16463
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 03:51:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA20281
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 08:50:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA20277 for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2002 08:50:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs permissions
Date: Tue, 26 Feb 2002 08:30:05 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0202251322430.16566-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0202251322430.16566-100000@raven>
MIME-Version: 1.0
Message-Id: <20020226085127.A17831F5D7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2002 19:25, Stephen Smalley wrote:
> On Mon, 25 Feb 2002, Russell Coker wrote:
> > new hardware or drivers).  On a devfs system there are only three
> > programs that should create anything under /dev, they are init, the
> > devfsd startup script, and devfsd itself.
>
> So what happens to other programs that try to create sockets in /dev?  Are
> they transparently redirected through devfsd?

What other programs are there?  The one I've just thought of which I didn't 
think of before is GPM, is there anything else that's remotely common?  Is 
this common enough that it's painful to create a new rule for every program 
that needs to do so?

Most such things are probably broken by design anyway.

init has a good excuse because there's not much mounted at the time it starts 
work, gpm has a partial excuse because it's creating a socket as a 
replacement for a real mouse device.

> Given the behavior you describe, it doesn't sound as though the existing
> file_type_auto_trans rules for runtime files in /dev would work anyway
> when using devfs, so perhaps it doesn't matter that you are using devfs_t.

We'll see.  With some of these things it's very difficult to guess what 
requirements might come up without releasing a beta.  I'll write sample 
policy files according to my ideas, distribute them, and see what feedback I 
get back.  If I discover horrible problems or get a lot of negative feedback 
then I'll go back to your ideas.  ;)

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
