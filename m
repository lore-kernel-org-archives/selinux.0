Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523SHrT000755
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:28:17 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i533S2eD016756
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 23:28:02 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 08:41:35 -0000
Date: Tue, 1 Jun 2004 08:39:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: installing x-window-system on my loovely minimalist system
Message-ID: <20040601083901.GI8312@lkcl.net>
References: <20040531215339.GR3170@lkcl.net> <200406011323.26802.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406011323.26802.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 01:23:26PM +1000, Russell Coker wrote:
> On Tue, 1 Jun 2004 07:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > okay, just for fun, i began to install x-windows.
> >
> > bizarrely i get these (wheeee):
> >
> > allow initrc_t sysadm_tmp_t:file { read };
> > 	#EXE=/bin/cat  NAME=XF86Config-4   :  read
> >
> > allow ldconfig_t lib_t:file { read };
> > 	#EXE=/sbin/ldconfig  NAME=libXft.so.2.1.1   :  read
> > 	#EXE=/sbin/ldconfig  NAME=libfontconfig.so.1.0.4   :  read
> > 	#EXE=/sbin/ldconfig  NAME=libXft.so.2.1.1   :  read
> 
> When you use apt or dselect to install packages several packages will have 
> their files installed at one pass, then the postinst scripts will be run for 
> the packages.
> 
> In Debian file labelling is done just before the postinst, so you have files 
> from packages liba and libb installed but not labeled, you run liba's 
> postinst (which first correctly labels files in liba), but ldconfig tries 
> reading the files from libb which fails.
> 
> Maybe I should just put a dontaudit rule in dpkg.te?
 
 *shrug*  :)

> > allow ldconfig_t usr_t:file { read };
> > 	#EXE=/sbin/ldconfig  NAME=libXrandr.so.2.0   :  read
> > 	#EXE=/sbin/ldconfig  NAME=libXTrap.so.6.4   :  read
> >
> > allow ldconfig_t usr_t:lnk_file { read unlink };
> > 	#EXE=/sbin/ldconfig  NAME=libXrandr.so.2   :  read
> > 	#EXE=/sbin/ldconfig  NAME=libXrandr.so.2   :  unlink
> 
> That is wrong.  What directories are those files in?

sez:~# locate libXrandr
/usr/X11R6/lib/libXrandr.so.2
/usr/X11R6/lib/libXrandr.so.2.0

sez:~# locate libXTrap.so.6.4
/usr/X11R6/lib/libXTrap.so.6.4
sez:~# 

> On my system it's in /usr/X11R6/lib and the following file_contexts entry 
> correctly matches it:
> 
> /usr/X11R6/(.*/)?lib(64)?/.*\.so.* --   system_u:object_r:shlib_t
 
sez:~# ls --context /usr/X11R6/lib/libXTrap.so.6.4
-rw-r--r--  root     root     system_u:object_r:shlib_t
/usr/X11R6/lib/libXTrap.so.6.4
sez:~# ls --context /usr/X11R6/lib/libXrandr.so.2.0
-rw-r--r--  root     root     system_u:object_r:shlib_t
/usr/X11R6/lib/libXrandr.so.2.0
sez:~# ls --context /usr/X11R6/lib/libXrandr.so.2  
lrwxrwxrwx  root     root     system_u:object_r:lib_t
/usr/X11R6/lib/libXrandr.so.2
sez:~# 

well, somehow, one of them doesn't match - libXrandr.so.2 is
a lib_t type (is that because it's a symbolic link?) and
what happened to libXtrap.so.6 symbolic link??


hey, i gotta question for you.

is there possibly a delay in the journalling ext3 file system
on extended attributes?

is there any way that old extended attributes could be read from
the filesystem because of delays in the journalling filesystem
not writing them down immediately?

> > allow xprint_t sysadm_xserver_tmp_t:dir { search };
> > 	#EXE=/usr/bin/Xprt  NAME=.X11-unix   :  search
> > 	#EXE=/usr/bin/Xprt  NAME=.X11-unix   :  search
> 
> I had been in a rush when I wrote the policy for xprint.  I've attached a new 
> policy file which should work better, please try it out and let me know how 
> it goes.

 ah ha, okie.
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
