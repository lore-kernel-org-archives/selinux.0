Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02178
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 14:10:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA09338
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:09:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA09328 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:09:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: NSA SE enabled devfsd
Date: Wed, 6 Mar 2002 19:06:41 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>, devfs@oss.sgi.com
References: <20020306121639.699FC2158@lyta.coker.com.au> <200203061639.g26GdN312918@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200203061639.g26GdN312918@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <20020306191008.948291F082@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Mar 2002 17:39, Richard Gooch wrote:
> > > I have hacked support for SE Linux into devfsd.
> >
> > I have found one problem with my current code.  devfsd wants to
> > re-apply it's permissions to device nodes whenever it's restarted
> > and whenever you do "killall -1 devfsd" to tell it to reload it's
> > config.
>
> I'm open to (clean) suggestions on what to do about this. Perhaps a
> separate signal to reload the config file but don't generate the
> synthetic events?

Sounds reasonable.

> But before I make such a change, tell me why you're reloading the
> config file, but don't want to change permissions? Normally, you just
> send SIGHUP when /var is mounted (if that's where your permissions
> have been saved).

If you decide to change your policy or add support for some type of device 
node that was not previously supported then you have to reload the config.

Changing the policy does not necessarily require that existing permissions 
need to be changed.

> > Also this is not an issue that is restricted to SE Linux.  Currently
> > if I run "killall -1 devfsd" it will be equivalent to "mesg n" for
> > all users!
>
> But in general devfsd should be configured to *not* touch permissions
> for PTY's, so this shouldn't be a problem. What are you doing?

The following is in my devfsd.conf to change the group of the pts devices to 
group tty:
REGISTER        ^pts/.*         PERMISSIONS     -1.tty  0600

Is there any better way to do this?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
