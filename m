Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01879
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 09:27:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA10272
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:27:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA10268
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:27:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs mysterious relabelling
Date: Tue, 28 May 2002 15:27:23 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>, devfs@oss.sgi.com
References: <Pine.GSO.4.33.0205280903080.1315-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205280903080.1315-100000@raven>
MIME-Version: 1.0
Message-Id: <20020528132723.B02AC41C7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 May 2002 15:04, Stephen Smalley wrote:
> On Fri, 24 May 2002, Russell Coker wrote:
> > On my systems I have devfsd do most of the device node labelling.
> >
> > I have noticed that often the system_u:object_r:fixed_disk_device_t
> > labels (for /dev/ide/host0/bus0/target0/lun0/*) will get changed to
> > system_u:object_r:devfs_t (the default context for devfs).
> >
> > It doesn't happen to the device node for the entire file system
> > /dev/ide/host0/bus0/target0/lun0/disc and the device node
> > /dev/ide/host0/bus0/target0/lun0/part5 (an extended partition).
> >
> > I believe that this is not a user-land issue, and it's something in the
> > kernel (but I have not proven this yet).
> >
> > Also it seems to happen more often when under load (setfiles on the root
> > file system usually does the job).
>
> This could happen if a devfs entry is evicted from the dcache and is later
> looked up again, causing the security context to be re-acquired from the
> devfs_contexts configuration.  Doesn't this issue also arise for the
> ownership and mode on devfs entries when they are managed by devfsd?

No!  Devfs preserves the results of chmod/chown operations until the next 
reboot.

I'm surprised though, I thought that devfs entries would be locked in the 
dcache...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
