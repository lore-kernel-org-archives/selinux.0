Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17136
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 19:20:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA02520
	for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2002 00:18:11 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA02516
	for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2002 00:18:07 GMT
Date: Mon, 23 Dec 2002 11:19:45 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Ed Street <blacknet@simplyaquatics.com>
Cc: Selinux <selinux@tycho.nsa.gov>
Subject: Re: Freeswan breaks lsm kernel build
Message-ID: <20021223001945.GI30209@snoopy.apana.org.au>
References: <000201c2a9dc$6fb3d170$0a01a8c0@simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000201c2a9dc$6fb3d170$0a01a8c0@simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 22, 2002 at 12:06:14PM -0500, Ed Street wrote:
> I am working with 2.4.20 kernel and applying lm_sensors, i2c, freeswan
> v1.99 and lsm.  After installing freeswan and I attempt to apply lsm
> (lsm_2002.12.12-2_all.deb) it does not apply cleanly.
> 
> Testing whether LSM Support for Linux patch for 2.4.20 applies (dry
> run):
> 1 out of 2 hunks FAILED -- saving rejects to file
> arch/i386/defconfig.rej
> LSM Support for Linux patch for 2.4.20 does not apply cleanly

Whats weird, it the same thing worked fine for me...

What version of FreeSWAN? I have:

ii  kernel-patch-freeswan       1.96-1.4                    IPSEC kernel support for FreeSwan

It is possible this might be old, I forgot to double check.

Also I patched the patched Debian kernel, not sure if this
was a factor.

My version of my 2.4.20 kernel is currently online my
archive, unstable distribution (note: I haven't
tested it myself, except I know it compiles):

deb http://www.microcomaustralia.com.au/debian/ unstable main selinux

This is the unstable distribution, it currently has the following extra
packages that I haven't yet been able to test, but plan to ASAP:

 kernel-patch-2.4-lsm     | 2002.12.12-2.bam.1 | unstable   | selinux
 coreutils                | 4.5.3-4.se1.bam.1  | unstable   | selinux
 evms                     | 1.2.1-1.bam.1      | unstable   | main
 kernel-source-2.4.20     | 2.4.20-2.bam.2     | unstable   | main
 fcron                    | 2.9.3-1.se1.bam.1  | unstable   | selinux
 kernel-image-2.4.20-i386 | 1:2.4.20-2.bam.2   | unstable   | main
 selinux-small            | 2002121210-1.bam.2 | unstable   | selinux

The stable distribution (and known to work) is:

deb http://www.microcomaustralia.com.au/debian/ stable main selinux

Also, on the topic of my archive, I am experimenting with these
files:

<URL:http://www.microcomaustralia.com.au/debian/selinux.status.unstable>
<URL:http://www.microcomaustralia.com.au/debian/selinux.status.stable>

For unstable and stable, respectively which will list which packages are
out-of-date compared with Russell's package (note: this might be because
I have backported the changes; A practise I might discontinue in future
so I can get more accurate results here).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
