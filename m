Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2V9hkvb012217
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 05:43:46 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2V9hhCR023194
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 09:43:44 GMT
From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au
Cc: bug-coreutils@gnu.org, Michael Stone <mstone@debian.org>,
        472590@bugs.debian.org, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#472590: ls in Debian/Unstable
In-Reply-To: <200803312024.03028.russell@coker.com.au> (Russell Coker's
	message of "Mon, 31 Mar 2008 20:23:59 +1100")
References: <200803251523.34329.russell@coker.com.au>
	<200803260824.17731.russell@coker.com.au>
	<877ifj9sgs.fsf@rho.meyering.net>
	<200803312024.03028.russell@coker.com.au>
Date: Mon, 31 Mar 2008 11:43:42 +0200
Message-ID: <871w5r9qk1.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:
> On Monday 31 March 2008 20:02, Jim Meyering <jim@meyering.net> wrote:
>> I like Michael's suggestion.  Rephrasing it,
>>
>>     if (SELinux, with no other MAC or ACL)
>>       use '.'
>>     else if (any other combination of alternate access methods)
>>       use '+'
>>
>> If someone who already has a copyright assignment on file for coreutils
>> wants to write the patch (including doc update, tests, NEWS, ChangeLog,
>> etc.), please speak up ASAP.  Otherwise I'll do it.
>
> I still believe that as when running SE Linux all files will have contexts
> (the kernel code generates them if they are on a filesystem that doesn't
> support persistent storage of contexts or if they are unlabelled) then the SE
> Linux access controls should not be listed in "ls -l" output.

I do understand your sentiment.
If you raise the issue with the Austin Group, they'll at least
consider whether to adjust that part of the POSIX ls specification.

> That said, the above suggestion makes sense and would work reasonably well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
