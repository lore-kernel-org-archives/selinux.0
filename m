Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA18406
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 20:25:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA27817
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 01:25:13 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzband.ncsc.mil  with ESMTP id BAA27813
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 01:25:12 GMT
Date: Fri, 14 Dec 2001 01:32:03 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: John Scroggins <dataefx@earthlink.net>, selinux@tycho.nsa.gov
Subject: Re: Undefined refs in compile attempt
Message-ID: <20011214013203.GB16720@vnl.com>
References: <20011212014335.GA16538@vnl.com> <Pine.GSO.4.33.0112120840590.6865-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0112120840590.6865-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, I'm making progress. I thought I'd report in just in case
our friend writing the book wants to follow what I do.

First, I took the newest version as Dr. Smalley suggested and
applied his two patches. I also applied the patch from Andrew
Morton on LKML to try to fix the problem that has shown up
because of the new, more restrictive binutils.

That failed. I believe the problem might be that there are
occurences of the problem that are in the lsm patch or the
selinux patches as it has to do with module exit code I
believe.

My second choice was to backoff to an older binutils and
do the ld using that.

  533  tar zxf 2001121010-SELINUX/lsm-selinux-2001121010.tgz 
  537  cd selinux/
  538  patch -p1 < ../2001121010-SELINUX/util-linux.patch
  545  cd ../lsm
  547  patch -p1 < ../2001121010-SELINUX/AndrewMorton-exit.patch 

  550  cd ../selinux/module/
  552  make insert
  554  cd ../../lsm
  555  patch -p1 < ../2001121010-SELINUX/module.patch 

  558  cp -a ../20011213-collective.config .config
  559  make oldconfig
  560  make menuconfig

	Downgrade to binutils_2.11.92.0.7-2_i386.deb

  562  make dep
  564  make bzImage
  565  make modules

Now since I am not building for this machine, I move everything
to a target "root" which I'll later tar up and copy over
to the test machine:

  571  cp -a System.map ../Selinux/boot/System.map-2.4.16-lsm 
  572  cp -a arch/i386/boot/bzImage ../Selinux/boot/vmlinuz-2.4.16-lsm 
  574  make INSTALL_MOD_PATH=/usr/src/Selinux/ modules_install

Since selinux doesn't have this feature, I edited the makefile and
added it. After I'm done I'd be happy to supply any patchfiles I
create in the process.

  577  cd ../selinux/module
	Patch Makefile to have ROOT variable

  587  make ROOT=/usr/src/Selinux/usr/local install

At this point I'm not yet clear whether I can
continue on the kernel factory or have to complete the
commands in the README over on the target machine. I'm
hoping not as it would be terribly awkward if I have to
move the source tree across just to finish.

So, I'm on to the next RTFM and RTFC step.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
