Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i920uArT006076
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 20:56:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i920t24L013316
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:55:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: bash_profile: Permission denied
Date: Sat, 2 Oct 2004 10:56:05 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "James R. Marcus" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov
References: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local> <41530866.4020306@redhat.com> <1096670260.4161.18.camel@wintermute.xmldesign.de>
In-Reply-To: <1096670260.4161.18.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410021056.05616.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 08:37, Erich Schubert <erich@debian.org> wrote:
> > The problem is probably that you are logging as staff_r and the
> > directory is sysadm_r.
>
> What is the preferred way for having login being done as staff_r, but
> still having some profile files for root/staff_r?
> (staff_r doesn't necessarily need to write them, but i'd like him to be
> able to read them. So i can at least have a macro for "newrole -r
> sysadm_r" or a bash history entry...)

You can use the boolean staff_read_sysadm_file to enable staff_t (and other 
semi-privileged domains) to have getattr and search access to 
sysadm_home_dir_t:dir and have getattr and read access to sysadm_home_t:file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
