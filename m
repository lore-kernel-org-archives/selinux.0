Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5A26pY9003394
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 22:06:51 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5A26iTJ009807
	for <selinux@tycho.nsa.gov>; Sat, 10 Jun 2006 02:06:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Antill <james.antill@redhat.com>
Subject: Re: permissions on /proc/self/attrib/current
Date: Sat, 10 Jun 2006 12:06:36 +1000
Cc: Chuck Mead <csm@redhat.com>, selinux@tycho.nsa.gov
References: <4485C100.4030805@redhat.com> <1149632193.13928.71.camel@code.and.org>
In-Reply-To: <1149632193.13928.71.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606101206.36391.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 June 2006 08:16, James Antill <james.antill@redhat.com> wrote:
> On Tue, 2006-06-06 at 13:53 -0400, Chuck Mead wrote:
> > The file /proc/self/attrib/current is world read and write. Is this
> > correct? Why does it need world read and write?
>
>  Just my opinion but...
>
> /proc/self/attr/* are only used as part of SELinux policy, so it makes
> sense for their access control to be limited by just SELinux policy.

That's not the case.  When SE Linux is in permissive mode those files are not 
writable by other processes.  Showing the file as mode 0600 would be a closer 
representation of the non-SE access controls on those files than the current 
situation.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
