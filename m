Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9ACeHW7013032
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 08:40:17 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9ACd1ib024998
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 12:39:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "abcde efghi" <svmdcv@gmail.com>
Subject: Re: glibc error on rhel4
Date: Tue, 10 Oct 2006 22:40:13 +1000
Cc: selinux@tycho.nsa.gov
References: <6a9b0ede0610100508o7c9d65c0t19b0185e8ffaf19a@mail.gmail.com>
In-Reply-To: <6a9b0ede0610100508o7c9d65c0t19b0185e8ffaf19a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610102240.15111.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 10 October 2006 22:08, "abcde efghi" <svmdcv@gmail.com> wrote:
> grep  -nri  "haithere"  *
>  *** glibc detected *** free(): invalid next size (fast):
> 0x0000000000616990 ***
>  Aborted (core dumped)
>
> uname -orp
> 2.6.9-42.ELsmp x86_64 GNU/Linux
>
> with selinux enabled i am getting this error.why is it so?

What happens when SE Linux is disabled?

What files were you grepping?  How big were they?

grep has problems if you try grepping a file that has a line significantly 
larger than memory, files like /var/log/lastlog and /var/log/faillog can get 
very big if you have large UIDs and cause grep to crash when running out of 
memory.  I've only tested this on 32bit systems, 64bit might get a slightly 
different result.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
