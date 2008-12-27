Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBRJ4keD031377
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 14:04:46 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBRJ4jwv003339
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 19:04:46 GMT
Subject: Re: transition policy/logic for shell-, perl- and python-scripts
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: domg472 g472 <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5aebb9fb0812270301n5dacfe0dr73a71650e1a3c3a0@mail.gmail.com>
References: <1230370454.2932.11.camel@localhost.localdomain>
	 <5aebb9fb0812270301n5dacfe0dr73a71650e1a3c3a0@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 27 Dec 2008 20:04:37 +0100
Message-Id: <1230404677.2932.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-12-27 at 12:01 +0100, domg472 g472 wrote:
> A (executable) file is an "entrypoint" for domain transition.
> 
> source domain -> executable files type -> target domain
> 
> but domain transition is not default behaviour. Remember SELinux is
> least privilege
> 
> 1. deny access ( default )
> 2. run the executable file in the source domain (can_exec(source
> domain, executable files type)
> 3. Transition from a source domain to a target domain though a
> executable files type ( domain_auto_trans(source domain, executable
> files type, target domain)
> 
> the unconfined domain is designed to NOT transition. unconfined_t is
> not targeted, in other words it is (for the most part) exempted from
> SELinux.

How do you check if an entrypoint exists? Via security_check_context()?
I couldn't find any other function which could do the job. Or in general
how would you do it programmatically? What set of functions do you
recommend?

cheers,
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
