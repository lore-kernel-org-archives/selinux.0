Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SL6drT014425
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 17:06:39 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SL68Vb020555
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 21:06:09 GMT
Subject: Re: SeLinux packages compiled smoothly on ppc (after some help ..)
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: russell@coker.com.au
Content-Type: text/plain
Message-Id: <1091048795.19088.100.camel@debby>
Mime-Version: 1.0
Date: Wed, 28 Jul 2004 23:06:35 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry I have to paste  below the content from the archives - By a stupid
accident ("rm -rf *" in the wrong directory: I did this dozens of times
the last 2 days: This time in the wrong dir :) I lost all my mails ... I
had to let nsa Majordomo send me the archives of the messages from the
last few days.

Here's Russell Cokers archived message that I will answer  below (I hope
I didn't destroy the correct formatting of Russell's message):

######################################################
On Wed, 28 Jul 2004 08:36, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> dpkg_1.10.22_powerpc.deb
> ssh_3.8.1p1-7_powerpc.deb

Looks like you got the wrong version of these two.

> fakeroot apt-get source --compile dpkg=1.10.22-se1
>
> works not with 2.95, but with 3.4.
> The build with 2.95 ended with:
> ______________________________________
> checking for initscr in -lncurses... yes
> checking if TIOCNOTTY is defined in sys/ioctl.h... yes
> checking for va_copy... no
> checking for va_list assignment copy... configure: error: no
> make: *** [/home/shorty/testone/dpkg-1.10.22/build/configure-stamp] Error 1
> Build command 'cd dpkg-1.10.22 && dpkg-buildpackage -b -uc' failed.
> E: Child process failed
> ______________________________________

File a FTBFS bug against dpkg in the Debian BTS.


> And this:
> I patched the openssh sources only with the openssh-selinux.patch.gz
> and *not* with the
> ssh.diff.gz
> that can be found in the same directory on
> http://www.coker.com.au/newselinux/

Then you need to run "autoconf" before building it, otherwise you don't get SE 
Linux support.

> And please let me know in case someone would like to upload ppc packages
> like the ones above. With detailed guidance on how exactly to build them
> I'd enjoy to help here, and make them available for others, too ...

Please make them available for the benefit of other people.

#########################################################


I have a problem in downloading the openssh sources from
http://selinux.lemuria.org/newselinux/ssh/
with a 
apt-get source openssh

This command will download me a package from the debian mirrors I have
in my sources list, but not the package from
<http://selinux.lemuria.org/newselinux>
that I also have in my sources list.

Is there a possibility to downlowd the openssh sources from
http://selinux.lemuria.org/newselinux manually and then create the
debian/ dir in the unpacked openssh dir with dpkg-source, or a with
similar tool?

I know I could simply try replace the original 
openssh_3.8.1p1-7.diff.gz from the debian mirror with the 
http://selinux.lemuria.org/newselinux/ssh/openssh_3.8.1p1-7.se1.diff.gz

But I'm not sure whether this will mess up the resulting binary ... so
if possible I'd like to run a standard build with one of the
apt/dpkg/whatever tools on Debian

Second:
The compile errors probably will disappear if I run "autoconf" as you
told -- But is it neccessary to run "autoconf" for every build I was
reporting yesterday, or definitely just for the 2 (dpkg, ssh) you were
mentioning?

Thanks in anticipation

Note:
Sorry for the slightly pedantic procedure here: But I'd like to make the
resulting packages available for others, too ...

Note 2:
Those who sent me private mails the last 2 days are invited to send them
again to me, if possible: I lost, as I said, all mails this afternoon: I
have all mails that were double-sent to me *and* this list (Thanks to
nsa Majordomo :) ...


Thanks in anticipation

Regards
Wolfgang

-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
