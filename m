Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71Io2tg001215
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 14:50:02 -0400
Received: from nz-out-0102.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k71InrXQ012905
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 18:49:53 GMT
Received: by nz-out-0102.google.com with SMTP id n29so295038nzf
        for <selinux@tycho.nsa.gov>; Tue, 01 Aug 2006 11:50:02 -0700 (PDT)
Message-ID: <80d7e4090608011150u48b0e124m1046145a1450b8a3@mail.gmail.com>
Date: Tue, 1 Aug 2006 12:50:01 -0600
From: "Stephen John Smoogen" <smooge@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: gnuTAR support for SELinux context (beta)
Cc: "James Antill" <jantill@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1154453240.2103.27.camel@code.and.org>
	 <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/1/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2006-08-01 at 13:27 -0400, James Antill wrote:
> >  This is just a quick note to let you know that we've got beta
> > packages[1] for creating/extracting tar archives with SELinux context in
> > them (note that these packages are also based on rawhide, so will have
> > other changes).
> >  This should be able to extract any archives you've previously made with
> > star.
> >
> >  You can create archives with just selinux context information by using
> > --selinux, or with full xattr support using --xattrs. In a similar vein
> > you can ignore any selinux context information by using --no-selinux
> > when you extract, or --no-xattrs to ignore all xattr information.
> >
> > [1] http://people.redhat.com/jantill/
>
> What about just saving the selinux contexts by default if they are
> present on the files being archived (and likewise extracting them by
> default if present in the archive)?  Otherwise, users have to take
> explicit action to save and restore the file contexts and will continue
> to "lose" them by default.

Doesn't the xattr support use an internally different tar format than
the normal one? [From my reading of the star pages.] Would this stop
it being readable from say Debian, Solaris etc that didn't know about
this format

-- 
Stephen J Smoogen.
CSIRT/Linux System Administrator

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
