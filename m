Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4TKxdrT015654
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 16:59:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4TKv9Tg029068
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 20:57:09 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
	by jazzswing.ncsc.mil  with SMTP id i4TKv8PE029065
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 20:57:08 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 29 May 2004 20:59:37 -0000
Received: from highfield ([192.168.0.223]:32770 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.34 #1)
	id 1BUAHG-0000km-5h
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 20:17:58 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BUAsw-0000kl-M9
	for selinux@tycho.nsa.gov; Sat, 29 May 2004 20:56:54 +0000
Date: Sat, 29 May 2004 20:56:54 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Debian / SE/Linux packages: "Pre-Depends".
Message-ID: <20040529205654.GA2851@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

russell, hi,

regarding .deb packaging, i note that there are 1.12 versions of
packages now (hooray).

i asked someone who groks debian and makes a living out of it -
phil hands - about the note on
http://selinux.lemuria.org/install-2.6.html saying "you must install
libselinux1 first otherwise your system will break: mine did".

he instantly said "oh yes, that sounds like you need a Pre-Depends
on libselinux1 for all packages that use it".

libc6 has the dubious distinction of being one such package.

phil also said that judicious use of Pre-Depends is an absolute
must, because if you get _that_ wrong you can end up with
unrecoverable circular dependencies.

at least with "Depends" it's not so hard-and-fast, and thoroughly
wooly, or, more specifically, the use of "Depends" says that the
*installation process* of a package is NOT dependent on the
day-to-day running OF the package.

whereas "Pre-Depends" says that both the usage AND installation
process require the Pre-Dependencies to be fully installed and
set up before the installation can continue.


i believe that libselinux1 falls into this category, namely that
if libselinux1 is not installed, you _can_ expect things to break.

so, somewhere in coreutils-N.NN-seN, and all the other packages
that have libselinux1 as a dependency, i believe this should
be changed to "Pre-Depends".

also, i believe that selinux-policy-default requires a Pre-Depends
on policycoreutils, because if dpkg happens to get policycoreutils
pre-inst'd after selinux-policy-default, selinux-policy-default
will _happen_ to find that /usr/sbin/setfiles might not exist.

i think the same holds for checkpolicy, because selinux-policy-default
as part of its preinst process runs a make xxxx in /etc/selinux,
which uses checkpolicy.

if checkpolicy is set up _after_ selinux-policy-default, you have
a problem (/usr/sbin/checkpolicy doesn't exist).



also, i've installed policycoreutils 1.12-2 and it still overwrites
a version of genhomedircon which doesn't work.

the "patched" version of genhomedircon which is "special" to debian
takes a filename as input and does an OVERWRITE of that first argument.
see debian/genhomedircon and debian/rules which specifically 
overwrites the scripts/genhomedircon version.


the scripts/genhomedircon version however, takes a filename as
input and OUTPUTS onto stdout the file_contexts output.

if you use the broken debian version of genhomedircon, as mentioned
before (last week), you get NOTHING in file_contexts, and consequently
setfiles does zip.


fun and games.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
