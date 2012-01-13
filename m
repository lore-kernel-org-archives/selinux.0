Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0DFgB2u019321
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2012 10:42:11 -0500
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Jan 2012 10:42:11 -0500
Message-ID: <1326469331.28979.15.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote:
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid
> 
> Enjoy!

We have made a few updates to the source code repositories and the wiki
page.  A repo sync will refresh your copy of the source code if you
already have a copy.  The changes are:
- Merged latest AOSP master branch and resolved conflicts.  This also
resolves a build problem due to a change in AOSP that wasn't reflected
in our trees.
- Updated sepolicy to allow building with latest checkpolicy. This
allows building on Fedora 16 in addition to Fedora 15 and 14.
- Added support for x86-based builds, see:
http://selinuxproject.org/page/SEAndroid#Building_for_the_x86-based_Emulator

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
