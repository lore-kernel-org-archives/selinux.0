Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA17406
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 20:51:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBN1pqI11429
	for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2002 01:51:52 GMT
Received: from khaipur.xiat.org (adsl-66-125-68-98.dsl.anhm01.pacbell.net [66.125.68.98])
        by jazzband.ncsc.mil  with ESMTP id gBN1ppf11425 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2002 01:51:51 GMT
Date: Sun, 22 Dec 2002 17:36:02 -0800
From: Paul Krumviede <pwk@acm.org>
To: blacknet@simplyaquatics.com, "'Brian May'" <bam@snoopy.apana.org.au>
cc: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: Freeswan breaks lsm kernel build
Message-ID: <124674592.1040578562@localhost>
In-Reply-To: <000301c2aa19$336d7170$0a01a8c0@simplyaquatics.com>
References: <000301c2aa19$336d7170$0a01a8c0@simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.96 is very old. i haven't tried the latest selinux release, but
the previous release and frees/wan 1.98 seemed to work
fine. but i think i did things in a different order: i started with
a clean kernel tree, added/built selinux, and then added/built
frees/wan.

i've been meaning to try the latest selinux release with
a recent frees/wan with all of its fun patches (in particular,
x.509 support). one objective is to play with enhancing the
ipsec policy to include the x.509 stuff; this will require at
least thinking about what to do about openssl.

-paul

--On Sunday, 22 December, 2002 19:21 -0500 Ed Street 
<blacknet@simplyaquatics.com> wrote:

> Hello,
>
> Freeswan version 1.99
>
> => -----Original Message-----
> => From: Brian May [mailto:bam@snoopy.apana.org.au]
> => Sent: Sunday, December 22, 2002 7:20 PM
> => To: Ed Street
> => Cc: Selinux
> => Subject: Re: Freeswan breaks lsm kernel build
> =>
> =>
> => On Sun, Dec 22, 2002 at 12:06:14PM -0500, Ed Street wrote:
> => > I am working with 2.4.20 kernel and applying lm_sensors,
> => i2c, freeswan
> => > v1.99 and lsm.  After installing freeswan and I attempt to
> => apply lsm
> => > (lsm_2002.12.12-2_all.deb) it does not apply cleanly.
> => >
> => > Testing whether LSM Support for Linux patch for 2.4.20 applies (dry
> => > run):
> => > 1 out of 2 hunks FAILED -- saving rejects to file
> => > arch/i386/defconfig.rej
> => > LSM Support for Linux patch for 2.4.20 does not apply cleanly
> =>
> => Whats weird, it the same thing worked fine for me...
> =>
> => What version of FreeSWAN? I have:
> =>
> => ii  kernel-patch-freeswan       1.96-1.4
> => IPSEC kernel support for FreeSwan
> =>
> => It is possible this might be old, I forgot to double check.
> =>
> => Also I patched the patched Debian kernel, not sure if this
> => was a factor.
> =>
> => My version of my 2.4.20 kernel is currently online my
> => archive, unstable distribution (note: I haven't
> => tested it myself, except I know it compiles):
> =>
> => deb http://www.microcomaustralia.com.au/debian/ unstable main selinux
> =>
> => This is the unstable distribution, it currently has the
> => following extra
> => packages that I haven't yet been able to test, but plan to ASAP:
> =>
> =>  kernel-patch-2.4-lsm     | 2002.12.12-2.bam.1 | unstable   | selinux
> =>  coreutils                | 4.5.3-4.se1.bam.1  | unstable   | selinux
> =>  evms                     | 1.2.1-1.bam.1      | unstable   | main
> =>  kernel-source-2.4.20     | 2.4.20-2.bam.2     | unstable   | main
> =>  fcron                    | 2.9.3-1.se1.bam.1  | unstable   | selinux
> =>  kernel-image-2.4.20-i386 | 1:2.4.20-2.bam.2   | unstable   | main
> =>  selinux-small            | 2002121210-1.bam.2 | unstable   | selinux
> =>
> => The stable distribution (and known to work) is:
> =>
> => deb http://www.microcomaustralia.com.au/debian/ stable main selinux
> =>
> => Also, on the topic of my archive, I am experimenting with these
> => files:
> =>
> => <URL:http://www.microcomaustralia.com.au/debian/selinux.statu
> => s.unstable>
> => <URL:http://www.microcomaustralia.com.au/debian/selinux.statu
> => s.stable>
> =>
> => For unstable and stable, respectively which will list which
> => packages are
> => out-of-date compared with Russell's package (note: this
> => might be because
> => I have backported the changes; A practise I might
> => discontinue in future
> => so I can get more accurate results here).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
