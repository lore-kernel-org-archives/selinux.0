Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0R1nDXf000690
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2006 20:49:13 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0R1n7UM004076
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 01:49:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0D1D761B02
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 10:05:39 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17353-05 for <selinux@tycho.nsa.gov>;
	Fri, 27 Jan 2006 10:05:38 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8AB7261B01
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 10:05:38 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: apparent bug in setrans
Date: Fri, 27 Jan 2006 10:05:45 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200601241431.25155.russell@coker.com.au> <43D7AB15.8020204@redhat.com>
In-Reply-To: <43D7AB15.8020204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601271005.52076.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 26 January 2006 03:45, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > $ runcon -l s0:c1.c3 id
> > uid=500(rjc) gid=500(rjc) groups=500(rjc)
> > context=rjc:system_r:unconfined_t
>
> I am getting
>  runcon -l s0:c1.c7 id
> uid=0(root) gid=0(root)
> groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
> context=user_u:system_r:unconfined_t:s0:c1.c7
>  rpm -q libsetrans
> libsetrans-0.1.18-1

Thanks, version 0.1.18-1 has fixed that problem for me.  I haven't yet tested 
it on my MLS test system though.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
