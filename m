Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59HqmrT021496
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 13:52:48 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i59HqjQd006260
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 13:52:46 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 9 Jun 2004 17:52:41 -0000
Date: Wed, 9 Jun 2004 17:50:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Magnus Therning <magnus-work@therning.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040609175001.GC5727@lkcl.net>
References: <20040609144404.GJ5477@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040609144404.GJ5477@philips.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ha ha, another debian victiiim .

0) make sure you're really a debian/unstable (apt-get dist-upgrade?)

1) install, at your own risk of course, the 2.6.6-selinux1 kernel
from http://hands.com/~lkcl/selinux.

2) DO NOT add selinux.lemuria.org/newselinux to your /etc/apt/sources.list

3) DO add selinux.lemuria.org/walters to your /etc/apt/sources.list

4) DO install the (probably downgraded) cron, logrotate, coreutils etc.
   from /walters
   
5) use the 1.12 .debs for libselinux1 and selinux-policy-default
   and selinux-utils policycoreutils etc. they are the latest and they
   ARE in [ftp/http].*.debian.org

6) once you have installed the 1.12 selinux-policy-default and stuff,
   YOU MUST go to http://sf.net/projects/selinux and download a
   replacement genhomedircon from the
   selinux-usr/policycoreutils//scripts/ directory.

   the version presently released is brain-dead and does something
   different and unexpected.

i recommend you clean out everything you can find prior to doing all
this.

i ALSO recommend that you DO NOT install SE/Linux on an ext2 filesystem.

make sure you use ext3 for all partitions (well, i get away with /boot
as an ext2) how do i put this this is REALLY IMPORTANT there is a bug
somewhere in the extended attributes stuff and i got a repeatable and
quite seriously corrupted filesystem.

if you really really can't get it to work let me know and i can upload
a set of pre-installed tar.gz'd partitions which only come to 124 mbytes
total, there are only about 160 packages preinstalled.

l.

On Wed, Jun 09, 2004 at 04:44:04PM +0200, Magnus Therning wrote:
> I have run into some problems with getting a Debian box up and running
> with SELinux. Maybe someone can offer some insights?
> 
> Installing selinux-default-policy failed, make complains about 'chsid'
> not being present. These are the problems I run into when trying to
> complete the installation of the policies:
> 
>  1. The makefile in /etc/selinux uses 'chsid'. This is the line:
> 
>       chsid system_u:object_r:policy_config_t /ss_policy
> 
>     Apparently that tool has been replaced by 'chcon'.
> 
>       chcon -u system_u -r object_r -t policy_config_t /ss_policy
> 
>     On a standard kernel this gave the following error message:
>       
>       chcon: invalid security context
> 
>  2. The path to 'load_policy' is wrong in /etc/selinux/Makefile it now
>     lives in /usr/sbin rather than /usr/bin. Also the variable
>     LOADPOLICY isn't used at all, instead every reference to
>     'load_policy' is written like this:
> 
>       $(BINDIR)/load_policy
> 
>     A little silly (-:
> 
>  3. 'make relabel' fails on a standard kernel:
> 
>       load_policy: security_load_policy failed
> 
>     After rebooting using my SE-kernel 'make relabel' also fails:
> 
>       security:  policydb magic number 0x8 does not match expected magic number 0xf97cff8c
>       load_policy: security_load_policy failed
> 
> Now I am stuck :-( I simply don't know where to look for a thread to
> pull to clean up the mess.
> 
> /M
> 
> -- 
> Magnus Therning  mailto:therning@sourceforge.natlab.research.philips.com
> +31-40-2745179  http://pww.innersource.philips.com/magnus/
> OpenPGP:0x4FBB2C40
> 
> X-Windows: ...The art of incompetence. 



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
