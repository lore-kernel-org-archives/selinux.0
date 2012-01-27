Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0RKo9pl021729
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2012 15:50:09 -0500
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Jan 2012 15:50:08 -0500
Message-ID: <1327697408.7597.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote:
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid

We have made further updates to the source code repositories and the
wiki page.  You can refresh your sources by downloading the latest
local_manifest.xml file, dropping it into your .repo subdirectory, and
running repo sync -j1 again.

Some of the notable changes:
- We have added lightly modified versions of libsepol and checkpolicy to
the tree so that you can build on MacOS X in addition to Linux.  You
need to download the new local_manifest.xml file to pick up the new
libsepol and checkpolicy projects.

- All of our changes are now wrapped with HAVE_SELINUX conditionals.
Therefore, you must add HAVE_SELINUX := true to your BoardConfig.mk or
specify HAVE_SELINUX=true on the make command line.  We have added
HAVE_SELINUX := true to the board configs for the emulator, Nexus S, and
Motorola Xoom (wingray) devices.

- Our changes to the bionic C library have been merged by AOSP.  Thus,
it is no longer necessary to use our bionic tree, and it has been
dropped from the local_manifest.xml file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
