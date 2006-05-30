Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4UGe9YV024736
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 12:40:09 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4UGe8JA028642
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 16:40:08 GMT
Received: by ug-out-1314.google.com with SMTP id y2so780785uge
        for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 09:40:07 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: R: SELinux and SID
Date: Tue, 30 May 2006 18:40:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1149003652.524.64.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <447c7567.74c94b41.609e.687a@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>
> -----Messaggio originale-----
> Da: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Inviato: Tuesday, May 30, 2006 5:41 PM
> A: Joshua Brindle
> Cc: Mario Fanelli; SeLinux Mailing List
> Oggetto: Re: SELinux and SID
>
> On Tue, 2006-05-30 at 08:19 -0400, Joshua Brindle wrote:
> > Mario Fanelli wrote:
> > >
> > > I read that SELinux uses extended attributes to maintain SID/file 
> > > mapping, but I have a Fedora Core 5 with an ext3 filesystem but if I 
> > >  use getfattr command on any file I don't obtain nothing thatresembles

> > > SID. Am I wrong?
> > >
> > > Where does SELinux store SID?
> > >
> > You have to tell it what attribute name you want
> > 
> > $ getfattr -n security.selinux .
> > # file: .
> > security.selinux="system_u:object_r:root_t:s0\000"
>
> Note btw that security context strings are stored on the filesystem, not
> the (non-persistent non-global) SIDs (which are only stored in the
> in-core inodes).  Older versions of SELinux (pre-2.6) stored a separate
> persistent SID in the on-disk inodes (with a per-fs mapping from
> persistent SIDs to contexts), but that was eliminated when we migrated
> to using xattrs.
>
> getfattr only displays attributes in the user namespace by default.  To
> display all attributes on a file, you'd do something like:
> $ getfattr -m "" -d /path/to/file
>
> Or to see attribute in just the security namespace:
> $ getfattr -m "^security" -d /path/to/file
>
> -- 
> Stephen Smalley
> National Security Agency
> --

But are the SID invalidate to any reboot? If two object have the same
security context, SID are equals?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
