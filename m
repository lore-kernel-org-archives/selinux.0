Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AHd4rN011195
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 13:39:04 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AHcsmM008134
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 17:38:55 GMT
From: Jim Meyering <jim@meyering.net>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: does mv need a --context=CTX (-Z) option, too?
In-Reply-To: <1155225670.8018.12.camel@localhost.localdomain> (Karl
	MacMillan's message of "Thu, 10 Aug 2006 12:01:10 -0400")
References: <87hd0kc308.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0608100843530.4511@tachyon.snu.edu>
	<87y7twk4fb.fsf@rho.meyering.net>
	<1155225670.8018.12.camel@localhost.localdomain>
Date: Thu, 10 Aug 2006 19:39:03 +0200
Message-ID: <87slk4ij7s.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:

> On Thu, 2006-08-10 at 17:15 +0200, Jim Meyering wrote:
>> kmacmillan@mentalrootkit.com wrote:
>> > On Thu, 10 Aug 2006, Jim Meyering wrote:
>> >
>> >> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
>> >> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
>> >> Most of the time, mv would have no need, since it simply calls rename.
>> >> But when that fails, it reverts to using the very same copying code
>> >> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
>> >> understanding that it'd take effect solely for e.g., cross-device moves.
>> >> I.e., if you want to simulate a cross device move, you'd have to use
>> >> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
>> >> (-Z) option, then it follows that mv must accept it as well.
>> >>
>> >
>> > I think that mv should have that option. Actually, I think that the more
>> > pressing option is --preserve so that users can simulate the rename case
>> > across devices.
>>
>> Why would mv need a new --preserve option?
>> mv already tries to preserve as much as possible when
>> performing any cross-device copy.
>
> I had the impression that mv did not preserve contexts across devices,
> but I guess I was mistaken.

Red Hat's version may not, I don't remember off hand.
The version I'm working on for upstream most definitely does.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
