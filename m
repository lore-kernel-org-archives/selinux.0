Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KFGAXZ000713
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 11:16:10 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KExae3002626
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 14:59:40 GMT
Date: Wed, 20 Oct 2004 16:10:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: sds@epoch.ncsc.mil, nsa <SELinux@tycho.nsa.gov>
Subject: Re: Virtualization and SELinux
Message-ID: <20041020151031.GB21185@lkcl.net>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098274225.12118.20.camel@jsingh.india.ensim.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jaspreet, hi,

i think what you will need to do is to apply selinux permissions
to the chrooted environment [try it!]:

1) copy (cp -ax) /etc/selinux/ and /usr/share/selinux to
   /home/virtual/siteNum

2) chroot /home/virtual/siteNum /bin/bash

3) cd /etc/selinux/src as usual

4) run make relabel.

5) delete /usr/share/selinux.

alternatively, if you don't want to copy /usr/share/selinux over
in the first place, cp -ax /etc/selinux to /home/virtual/siteNum
then do the chroot, then manually do:

setfiles /etc/selinux/src/file_contexts/file_contexts /

i do something similar to this from a boot / recovery CD, already.

i _expect_ that then programs which are in the chroot environment will
act as normal.

the only thing that you _might_ have to do is add to the [non-chrooted!]
selinux policy a .te and .fc for a shell program to be used in
/etc/passwd which can chroot your users and drop them into the right
user context: i don't know exactly what to suggest there.


btw by doing the chrooted environment you should, in 1) above,
ONLY set up and copy over a subset of the policy which is
APPROPRIATE for the users for /home/virtual/siteNum.

then you might be able, of course, to remove things not needed
from the "main" policy.

l.


On Wed, Oct 20, 2004 at 05:40:25PM +0530, Jaspreet Singh wrote:
> Hi, 
> 
> I am have my box up and running with (customized) targeted-selinux
> policies ( spl. thanx to Stephen Smalley and Colin Walters ;-)
> 
> But, now I am stuck in issues of selinux with virtualization. I need to
> virtualize my box to support multiple sites (name and ip-based) e.g
> 
> /home/virtual/siteNum/etx/passwd ..
> /home/virtual/siteNum/home/USERS .. 
> 
> and different sites can have same user name right ... and these users
> can easily be looked against multiple passwd for normal authentication.
> But how bout SELinux ..  i know even the /usr/sbin/genhomedircon can be

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
