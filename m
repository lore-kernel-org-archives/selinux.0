Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6R13R7R025474
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 21:03:27 -0400
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Subject: Re: Questions about the MLS to "read down"
From: Joe Nall <joe@nall.com>
In-Reply-To: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
Date: Thu, 26 Jul 2012 20:03:12 -0500
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <3138EE6F-F894-46F2-A233-E3F014B1257C@nall.com>
References: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 26, 2012, at 5:49 PM, Haiqing Jiang <hqjiang1988@gmail.com> wrote:

> Hi, all
> 
> I have the following denials. But from my understanding, the reading-down rule is not violated according to the scontext and tcontext. Could you help to explain why? Thanks. 
> 
> <5>[15423.456451] type=1400 audit(1342836229.562:2241): avc:  denied  { read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=127269 scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c16 tclass=lnk_file

s0:c42 and s0:c16 are incomparable. c42 doesn't dominate c16. There may be additional type issues as well.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
