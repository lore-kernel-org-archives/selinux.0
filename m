Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m98H6qvS019181
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 13:06:52 -0400
Received: from dmzms99802.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m98H5fk6023478
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 17:05:41 GMT
Message-Id: <738m08$no37d@dmzms99802.na.baesystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: user guide drafts: Maintaining SELinux Labels
Date: Wed, 8 Oct 2008 10:05:43 -0700
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Glenn Faden" <Glenn.Faden@sun.com>, "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Murray McAllister" <mmcallis@redhat.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Glenn Faden
> Sent: Wednesday, October 08, 2008 8:46 AM
> To: Daniel J Walsh
> Cc: Murray McAllister; SE Linux
> Subject: Re: user guide drafts: Maintaining SELinux Labels
> 
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Murray McAllister wrote:
> >
> >> Hi,
> >>
> >> The following are the first few drafts of the "Maintaining SELinux
> >> Labels" sections. Any comments and corrections are appreciated.
> >>
> >> Cheers.
> >>
> >> Copying Files and Directories
> >>
> >> When files and directories are copied, they inherit the SELinux
context
> >> of the parent directory they are copied to. This helps ensure files
and
> >> directories are labeled with the correct SELinux context after
being
> >> moved. The following example demonstrates copying a file from a
user's
> >> home directory to /var/www/html/, which is used by the Apache HTTP
> >> Server. Since the file is copied, it inherits the correct SELinux
> context:
> >>
> Is this true when using MLS policy? Assuming the policy allows a
subject
> to create a file in a directory, shouldn't the newly created file's
> SELinux context have the same sensitivity as the subject who wrote it?

> Or is the new file's type copied from the directory and the
sensitivity
> copied from the subject?

You are correct, the type is copied from the directory and the level is
copied from the subject. It might also be worth mentioning that the type
is copied from the directory as default behavior, which can be
overridden with type_transition statements.

> 
> --Glenn
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
