Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QE08rT012920
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 10:00:08 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QE060g013389
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 14:00:06 GMT
Message-ID: <412DECD3.5040701@tresys.com>
Date: Thu, 26 Aug 2004 09:59:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fedora and udev
References: <200408222125.38169.russell@coker.com.au>	<4128B637.8040900@tresys.com> <20040822173457.GD13842@lkcl.net>	<20040823224444.GI4694@kroah.com> <412A74A6.9070206@tresys.com>	<20040824094157.GF25356@lkcl.net> <20040824163048.GA1715@kroah.com> <412DEC4A.6090101@redhat.com>
In-Reply-To: <412DEC4A.6090101@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Gregkh will not accept anything with #ifdefs in .c files.

Joshua Brindle

Daniel J Walsh wrote:

> Rewritten patch.
> 
> Dan
> 
> 
> ------------------------------------------------------------------------
> 
> --- udev-030/udev-add.c.selinux	2004-08-25 16:47:52.000000000 -0400
> +++ udev-030/udev-add.c	2004-08-26 07:59:42.007575846 -0400
> @@ -50,6 +50,11 @@
>  
>  #define LOCAL_USER "$local"
>  
> +#ifdef WITH_SELINUX
> +#include <selinux/selinux.h>
> +static int selinux_enabled=-1;
> +#endif
> +
>  /* 
>   * Right now the major/minor of a device is stored in a file called
>   * "dev" in sysfs.
> @@ -92,7 +97,25 @@
>  			break;
>  		*pos = 0x00;
>  		if (stat(p, &stats)) {
> +#ifdef WITH_SELINUX
> +			if (selinux_enabled) {
> +				int seretval = 0;
> +				security_context_t scontext=NULL;
> +				seretval = matchpathcon(p, S_IFDIR, &scontext);
> +				if (seretval < 0) {
> +					dbg("matchpathcon(%s) failed\n", p);
> +				} else {
> +					seretval=setfscreatecon(scontext);
> +					if (seretval < 0)
> +						dbg("setfiles %s failed with error '%s'",
> +						    p, strerror(errno));
> +					/* after mkdir, free the context */
> +					freecon(scontext);
> +				}
> +			}
> +#endif
>  			retval = mkdir(p, 0755);
> +									
>  			if (retval != 0) {
>  				dbg("mkdir(%s) failed with error '%s'",
>  				    p, strerror(errno));
> @@ -117,6 +140,25 @@
>  	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
>  	    (stats.st_rdev == makedev(major, minor))) {
>  		dbg("preserve file '%s', cause it has correct dev_t", file);
> +#ifdef WITH_SELINUX
> +		/* lkcl: maybe someone would like to do the same thing with se/linux
> +		 * security contexts (check they are the same) but hey, not me!
> +		 */
> +		if (selinux_enabled) {
> +			security_context_t scontext=NULL;
> +			retval = matchpathcon(file, mode, &scontext);
> +			if (retval < 0) {
> +				dbg("matchpathcon(%s) failed\n", file);
> +			} else {
> +				retval=setfilecon(file, scontext);
> +				if (retval < 0)
> +					dbg("setfiles %s failed with error '%s'",
> +					    file, strerror(errno));
> +				freecon(scontext);
> +			}
> +		}
> +#endif
> +
>  		if (udev_preserve_owner)
>  		  goto exit;
>  		else
> @@ -129,6 +171,23 @@
>  		dbg("already present file '%s' unlinked", file);
>  
>  create:
> +#ifdef WITH_SELINUX
> +	if (selinux_enabled) {
> +		int seretval = 0;
> +		security_context_t scontext=NULL;
> +		seretval = matchpathcon(file, mode, &scontext);
> +		if (seretval < 0) {
> +			dbg("matchpathcon(%s) failed\n", file);
> +		} else {
> +			retval=setfscreatecon(scontext);
> +			if (retval < 0)
> +				dbg("setfiles %s failed with error '%s'",
> +				    file, strerror(errno));
> +			freecon(scontext);
> +		}
> +	}
> +#endif
> +						    
>  	retval = mknod(file, mode, makedev(major, minor));
>  	if (retval != 0) {
>  		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
> @@ -307,6 +366,23 @@
>  
>  		dbg("symlink(%s, %s)", linktarget, filename);
>  		if (!fake) {
> +#ifdef WITH_SELINUX
> +			if (selinux_enabled) {
> +				int seretval = 0;
> +				security_context_t scontext=NULL;
> +				seretval = matchpathcon(filename, S_IFLNK, &scontext);
> +				if (seretval < 0) {
> +					dbg("matchpathcon(%s) failed\n", filename);
> +				} else {
> +					seretval=setfscreatecon(scontext);
> +					if (seretval < 0)
> +						dbg("setfscreatecon %s failed with error '%s'",
> +						    filename, strerror(errno));
> +					freecon(scontext);
> +				}
> +			}
> +#endif
> +			
>  			unlink(filename);
>  			if (symlink(linktarget, filename) != 0)
>  				dbg("symlink(%s, %s) failed with error '%s'",
> @@ -406,6 +482,13 @@
>  	char *pos;
>  	int retval;
>  
> +#ifdef WITH_SELINUX
> +	int seretval=0;
> +	security_context_t prev_scontext=NULL;
> +	if (selinux_enabled < 0 )
> +		selinux_enabled = (is_selinux_enabled() > 0);
> +#endif
> +
>  	memset(&dev, 0x00, sizeof(dev));
>  
>  	dev.type = get_device_type(path, subsystem);
> @@ -441,6 +524,24 @@
>  
>  	dbg("name='%s'", dev.name);
>  
> +#ifdef WITH_SELINUX
> +	/* record the present security context, for file-creation
> +	 * restoration creation purposes.
> +	 *
> +	 * we're going to assume that between now and the time that
> +	 * this context is restored that the only filecreation of any
> +	 * kind to occur will be mknod, symlink and mkdirs.
> +	 */
> +
> +	if (selinux_enabled)
> +	{
> +		prev_scontext=NULL;
> +		seretval = getfscreatecon(&prev_scontext);
> +		if (seretval < 0) {
> +			dbg("getfscreatecon failed\n");
> +		}
> +	}
> +#endif
>  	switch (dev.type) {
>  	case 'b':
>  	case 'c':
> @@ -477,6 +578,17 @@
>  		break;
>  	}
>  
> +#ifdef WITH_SELINUX
> +	if (selinux_enabled) {
> +		/* reset the file create context to its former glory */
> +		if (seretval == 0) {
> +			if ( setfscreatecon(prev_scontext) < 0 )
> +				dbg("setfscreatecon failed\n");
> +			freecon(prev_scontext);
> +		}
> +	}
> +#endif
> +
>  exit:
>  	sysfs_close_class_device(class_dev);
>  
> --- udev-030/Makefile.selinux	2004-07-09 13:59:09.000000000 -0400
> +++ udev-030/Makefile	2004-08-25 16:47:52.000000000 -0400
> @@ -25,6 +25,8 @@
>  # Leave this set to `false' for production use.
>  DEBUG = false
>  
> +# Set this to compile with Security-Enhanced Linux support.
> +WITH_SELINUX = true
>  
>  ROOT =		udev
>  DAEMON =	udevd
> @@ -172,6 +175,13 @@
>  
>  CFLAGS += -I$(PWD)/libsysfs
>  
> +ifeq ($(strip $(WITH_SELINUX)),true)
> +	LIB_OBJS +=	\
> +			-lselinux
> +	CFLAGS += \
> +		-DWITH_SELINUX
> +endif
> +
>  all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
>  	@extras="$(EXTRAS)" ; for target in $$extras ; do \
>  		echo $$target ; \


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
