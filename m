Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NKMGrT012608
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 16:22:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NKLEv8014880
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 20:21:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: bash_profile: Permission denied
Date: Fri, 24 Sep 2004 06:22:07 +1000
Cc: "James R. Marcus" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov
References: <E6E16A6D4277CD459BBDE6713766033CB71F9E@exchange.mvalent.local> <4153143C.2090405@redhat.com>
In-Reply-To: <4153143C.2090405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409240622.07118.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2004 04:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> James R. Marcus wrote:
> >What is the right way to deal with this issue?  When root logs in should
> >they automatically be in the sysadm_r role or should these files be
> >labeled with staff_r?
>
> It is working the way it was designed.  In Fedora Core, we changed to
> use staff_* for the home directory, because
> we thought it was too confusing for the users.  There is a security risk

We should revert that change.  It causes too many other issues and does no 
good.

Now that the targeted policy is the default most people who don't want to know 
much about SE Linux will stick with targeted and never encounter this.

With the strict policy a user who logs in as root:staff_r:staff_t will 
discover that they can't do most things that they want to do as root and will 
have to run newrole before doing anything else, so there will be no extra 
confusion about lack of write access to /root.

Users who find newrole too confusing just have to run targeted policy, there 
is no other solution for them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
