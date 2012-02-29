Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1TFxEG2018681
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 10:59:14 -0500
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Feb 2012 10:59:13 -0500
Message-ID: <1330531153.20078.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote: 
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid

We have updated the source code repositories and the wiki page.  A repo
sync -j1 will refresh your copy of the source code if you already have a
copy.  The changes since the last update are:

- (code) Merged the latest AOSP master branch.  Note that some of our
changes have been merged into the AOSP master branch since our last
update.  In particular, the base set of init/ueventd and toolbox changes
under system/core have been merged.  However, you still need to use our
system/core tree to pick up some of the subsequent changes that have not
yet been merged.

- (code) Updated libsepol and checkpolicy to the latest upstream
release.

- (code) Minor cleanups for the chown -R implementation.

- (wiki) Added instructions for building on MacOS X.

- (wiki) Added links to the slides and video from our talk at the
Android Builders Summit.

- (wiki) Added a note about the need to generate your own keys for
production builds to the section on Building for a Device.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
