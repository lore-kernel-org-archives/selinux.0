Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n350qmwt009110
	for <selinux@tycho.nsa.gov>; Sat, 4 Apr 2009 20:52:49 -0400
Received: from mail2.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n350qlMb021215
	for <selinux@tycho.nsa.gov>; Sun, 5 Apr 2009 00:52:47 GMT
Message-ID: <49D800D7.7060609@kaigai.gr.jp>
Date: Sun, 05 Apr 2009 09:52:39 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>  <49D4CB6E.1090900@manicmethod.com> <1238684951.32379.311.camel@gorn.columbia.tresys.com> <49D563A9.1000607@ak.jp.nec.com> <49D651A7.1000703@manicmethod.com>
In-Reply-To: <49D651A7.1000703@manicmethod.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> Again, I would like to get the reworks merged in this timing.
>> (In addition, it also makes RUBIX happy on Fedora 11 or later.)
>>
> 
> Fedora 11 is already frozen, new object classes shouldn't be working their way
> in to that, so we have a release cycle to adjust the permissions to match the
> implementation, both on the upstream sepostgres side and the RUBIX side before
> pushing those in to refpolicy.

Hmm... It would seem that I need to provide a development purpose
security policy package in the meanwhile.

The next development cycle in PostgreSQL will be open soon:
  http://wiki.postgresql.org/wiki/CommitFest_2009-First

I'll propose the newer design for the commit fest, but also continue
to maintain the current design on Fedora as far as the security policy
keeps existing object classes and permissions.

I believe the current design should be switched to the newer one
at some point in the future. In my hope, it should be done on
Fedora 12.

> Once some implementation starts and the security model settles it may be a
> different story, I just don't think it is appropriate to merge them at this
> point. (In particular I want to see if the new proposed object classes and perms
> will really work for RUBIX, and I want to see how much of the patch the upstream
> postgres project will take for the next release).

I also would like Andy to report whether the RUBIX with newer design and
security policy performs well, or not.
The development purpose security policy which contains newer object classes
and permissions will be available soon.

> As it stands we are going to have 3 selinux aware databases floating around
> using slightly different object classes and permissions, which is not ideal.

Agreed.

> Having all those in upstream refpolicy means it is harder to change them and the
> unused permissions are going to sit there causing confusion (even worse, they'll
> be unused by 2 of the 3 systems but still in use by the previous version of
> sepostgres).

I think the current design should be deprecated in the lifespan of distribution
if the upstream refpolicy once gets newer design.
In finally, I believe only 2 of the system can share the design.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
