Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5NqZRb008809
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:52:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5NprlU023957
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 23:51:54 GMT
Received: from hotmail.com (bay1-dav69.bay1.hotmail.com [65.54.244.204])
	by jazzswing.ncsc.mil  with ESMTP id hB5NprSX023954
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 23:51:53 GMT
From: "Stephen" <mridion@hotmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: new to the list
Date: Sat, 6 Dec 2003 10:52:27 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <BAY1-DAV69t3p2EkAkg00003aa9@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To answer myself
http://marc.theaimsgroup.com/?l=selinux&m=106676818318862&w=2

----- Original Message ----- 
From: "Stephen" <mridion@hotmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Sent: Saturday, December 06, 2003 10:44 AM
Subject: Re: new to the list


> Is the sysvinit patch available for download anywhere? I only see srpm's
in
> Daniel's directory. Is it likely to work with the current lsm patches or
> will it require the new kernel patches when they come out?
>
> Thanks
> Stephen
>
> ----- Original Message ----- 
> From: "Stephen Smalley" <sds@epoch.ncsc.mil>
> To: "Mark Shakespeare" <mshakes@llnl.gov>
> Cc: <selinux@tycho.nsa.gov>
> Sent: Saturday, December 06, 2003 7:09 AM
> Subject: Re: new to the list
>
>
> > On Fri, 2003-12-05 at 14:52, Mark Shakespeare wrote:
> > > I ran the patch for the Mkinitrd script,  then created an initrd using
> the
> > > command " mkinitrd  /boot/2.6.0-test6-selinx1.img 2.6.0-test6-selinux1
> > >
> > >   it mentions a /linuxrc file.....but gives no samples...
> > >
> > > Is there a sample /linuxrc file?    Where does it go?
> > >
> > > Does anyone have a cookbook installation guide for installing SE-Linux
> on RH9?
> >
> > That is created by the mkinitrd script on the initrd.  So if you ran the
> > patched mkinitrd script, you are done with that step.
> >
> > If you want an easier install (and more recent code), check out
> > ftp://people.redhat.com/dwalsh/SELinux, which has userland RPMs and some
> > sample scripts, and http://people.redhat.com/arjanv/2.5, which has
> > kernel RPMs.  But you'll need to upgrade to Fedora Core as your base
> > platform to easily use these RPMs.
> >
> > We hope to have an updated release on the NSA web site soon; many things
> > have changed since the October release (which is what you are using).
> > Note that the modified initrd is no longer necessary with the latest
> > code; Dan Walsh of RH created a patched /sbin/init program to perform
> > the initial policy load.
> >
> > -- 
> > Stephen Smalley <sds@epoch.ncsc.mil>
> > National Security Agency
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
> >
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
