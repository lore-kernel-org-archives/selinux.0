Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i78FJurT020743
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 11:19:57 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i78FJKDs026557
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 15:19:21 GMT
Subject: Re: Build error pam on ppc
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1091835108.5709.102.camel@debby>
References: <1091728350.2840.49.camel@debby>
	 <200408061646.12198.russell@coker.com.au> <1091835108.5709.102.camel@debby>
Content-Type: text/plain
Message-Id: <1091978380.14489.141.camel@debby>
Mime-Version: 1.0
Date: Sun, 08 Aug 2004 17:19:41 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-08-07 at 01:31, Wolfgang Pfeiffer wrote:
> On Fri, 2004-08-06 at 08:46, Russell Coker wrote:
> > On Fri, 6 Aug 2004 03:52, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > > Hi All
> > >
> > > When I built *successfully* pam on ppc with
> > >
> > > fakeroot apt-get source --compile pam=0.77-0.se5
> > >
> > > I got this error, that I *ignored*:
> > >
> > > ----------------------------------------
> > >
> > > mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib
> > > /usr/bin/install -m 755 libpamc.so
> > > /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib/libpamc.so.0.77
> > > /sbin/ldconfig
> > > /sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~:
> > > Permission denied make[2]: *** [install] Error 1
> > 
> > I recall getting the same error on i386.  I just ignored it, but probably we 
> > should have a bug report filed about that if you can reproduce it on the 
> > version of PAM that's in Debian.
> 
> I'll try to compile a stock Debian PAM this weekend, and if I see this
> error on that build, too, I'll file a bug report ... 
                        
                                                    [ ... ]

For all of the following please note that I tried the following builds
all as non-root, with "fakeroot", as seen below. 
(For those not being acquainted with the Debian tool:
"fakeroot  -  run a command in an environment faking root privileges for
file manipulation" [Excerpt from "man fakeroot"])

And please note also that the latest PAM versions for Debian and
SE-Linux differ: Stock-debian/unstable is at version pam_0.76, whereas
SE-PAM is at  0.77, IINM ...

The whole issue seems to be one for the se-linux PAM:
SE-pam is getting built successfully with gcc-3.0, gcc-3.3 and gcc-2.95,
but according to the logs I have always with this error line:
/sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~: Permission denied

SE-pam doesn't seem to get built here with gcc-3.4

I tried the SE-builds with something like this:
fakeroot apt-get source --compile pam=0.77-0.se5 &> $<some-build.log>


                       Default Debian Builds:

I built the stock-debian-PAM always successfully with something like

fakeroot apt-get source --compile pam=0.76-22 &> <some-build>.log

... but only with gcc-2.95 and gcc-3.3 for stock-Debian pam (I admit I
got fed up with it after all these builds ... :)

Please note that in all builds, even the successful ones where the
packages were built, whether those for the stock Debian or the SE-Pam
one, there were errors: 
I grepped the build log-files for both the stock Debian and the SE-Pam
one with this:
grep -iR -A 5 -B 5 " error " . > ~/pam-build-errors

The resulting file is here:
<http://www.geocities.com/wolfgangpfeiffer/pam-build-errors.log>

The file names referred to in the latter log file are hopefully
self-explaining enough, as I hope .. please let met know if that's an
ugly lie ..

If you need the complete log file for one or all builds please let me
know: I put it/them on my website too if needed ... 

HTH

Best Regards
Wolfgang
-- 
Profile: http://profiles.yahoo.com/wolfgangpfeiffer

3 more reasons for Linux:
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.whitehouse.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.fbi.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.defenselink.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
