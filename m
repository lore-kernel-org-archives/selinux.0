Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i62InlrT015405
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 14:49:47 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i62InVks012431
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 18:49:31 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 2 Jul 2004 18:49:27 -0000
Date: Fri, 2 Jul 2004 18:46:29 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jan Gehring <pr0gm4@linoratix.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Compiling error - sysvinit
Message-ID: <20040702184628.GD2814@lkcl.net>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com> <20040702071544.GA3277@lkcl.net> <20040702092526.GD3277@lkcl.net> <20040702190146.78697fe7.pr0gm4@linoratix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040702190146.78697fe7.pr0gm4@linoratix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 02, 2004 at 07:01:46PM +0200, Jan Gehring wrote:
> Hello Luke,
> > > under what system are you doing the compiling, if debian,
> > > have you done apt-get build-dep sysvinit?
> I have build my system by own. Some parts are from the linux-from-scratch project.
> (http://www.linoratix.com)
> 
> > 
> >  jan, you will need to install the package libselinux1-dev
> >  (if debian) or equivalent for whatever-system-you-have.
> well i have build und installed libselinux.
> 
> $ ls /lib/libselinux.so.1
> /lib/libselinux.so.1
> 
> $ ls /usr/lib/libselinux.*
> /usr/lib/libselinux.a	/usr/lib/libselinux.so
> 
> /usr/lib/libselinux.so is a symlink to /lib/libselinux.so.1
> 
> perhaps i have to add some other some other symlinks?
 
 symlinks no, _header_ files yes.

 you will also need /lib/libselinux* of course as well.


 do you have any files /usr/include/selinux/* ?

 if no, then nothing will compile, end of story.

 therefore, in your case, i would recommend that you obtain the
 source code of libselinux, compile and install it, making sure
 that you get the library into /lib (with a symlink in /usr/lib)
 and the installation of the library FROM SOURCE will put the
 header files there as well.

 ... you _are_ no doubt aware that this is a standard procedure
 for building _any_ program from source: you must have all the source
 dependencies installed...

 l.



> > > On Fri, Jul 02, 2004 at 01:48:50PM +0200, Jan Gehring wrote:
> > > > Hello ml,
> > > > 
> > > > i tried to compile sysvinit-2.85 but i get the following error.
> > > > 
> > > > root@maracuja src # make LDFLAGS="-s -lselinux" CFLAGS="-D_GNU_SOURCE"
> > > > cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
> > > > [...]
> > > > init.c:97: error: `SELINUXMNT' undeclared (first use in this function)
> > > > [...]
> > > > init.c:123: error: `SELINUXPOLICY' undeclared (first use in this function)
> > > > make: *** [init.o] Error 1
> 
> [cut]
> 
> 
> Thanks for any help
> Jan
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
