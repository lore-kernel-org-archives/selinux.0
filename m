Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OAUnBe001849
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 06:30:49 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OAUi3M009854
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 10:30:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ken YANG <spng.yang@gmail.com>
Subject: Re: can not boot with strict policy
Date: Tue, 24 Apr 2007 18:10:45 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <462CA1F0.2000400@gmail.com>
In-Reply-To: <462CA1F0.2000400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704241710.50133.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 23 April 2007 22:09, Ken YANG <spng.yang@gmail.com> wrote:
> make && make install && make load && \
> "modify /etc/selinux/config to use new policy" && \
> touch /.autorelabel
>
>
> and reboot, but "kernel panic" occur:
>
> "......
> avc: denied {execute} for pid=1 comm="init" name="libsepol.so.1"
> scontext=system_u:system_r:init_t:s0 tcontext=user_u:object_r:lib_t:s0
> tclass=file
> Kernel panic - not syncing: Attempted to kill init!

Did you try booting in permissive mode?  The process of converting from 
targeted to strict is not well tested and not guaranteed to work in enforcing 
mode.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
