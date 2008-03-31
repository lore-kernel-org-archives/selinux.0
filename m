Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2V9OAYo009911
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 05:24:10 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2V9O8CR016640
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 09:24:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <jim@meyering.net>
Subject: Re: Bug#472590: ls in Debian/Unstable
Date: Mon, 31 Mar 2008 20:23:59 +1100
Cc: bug-coreutils@gnu.org, Michael Stone <mstone@debian.org>,
        472590@bugs.debian.org, SE-Linux <selinux@tycho.nsa.gov>
References: <200803251523.34329.russell@coker.com.au> <200803260824.17731.russell@coker.com.au> <877ifj9sgs.fsf@rho.meyering.net>
In-Reply-To: <877ifj9sgs.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803312024.03028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 31 March 2008 20:02, Jim Meyering <jim@meyering.net> wrote:
> I like Michael's suggestion.  Rephrasing it,
>
>     if (SELinux, with no other MAC or ACL)
>       use '.'
>     else if (any other combination of alternate access methods)
>       use '+'
>
> If someone who already has a copyright assignment on file for coreutils
> wants to write the patch (including doc update, tests, NEWS, ChangeLog,
> etc.), please speak up ASAP.  Otherwise I'll do it.

I still believe that as when running SE Linux all files will have contexts 
(the kernel code generates them if they are on a filesystem that doesn't 
support persistent storage of contexts or if they are unlabelled) then the SE 
Linux access controls should not be listed in "ls -l" output.

That said, the above suggestion makes sense and would work reasonably well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
