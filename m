Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11659
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:54:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24869
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:53:32 GMT
Received: from mail.lemuria.org ([213.191.74.130])
        by jazzband.ncsc.mil  with ESMTP id QAA24865 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:53:32 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 8E183BB8B
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:48:18 +0200 (CEST)
Date: Fri, 19 Apr 2002 18:52:05 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
Message-ID: <20020419185205.A11916@lemuria.org>
References: <20020419143800.B18906@lemuria.org> <20020419130224.B2E2544E9E@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020419130224.B2E2544E9E@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 19, 2002 at 03:02:24PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 19, 2002 at 03:02:24PM +0200, Russell Coker wrote:
> > But please tell me if there's a reason why it's not there, and I'm dumb
> > and/or compromising the system's security. In order for this to work
> > on debian, I also added to file_contexts:
> >
> > /etc/init.d(|/.*)               system_u:object_r:initrc_exec_t
> 
> I tried that once, but decided it was a bad idea and changed it back.

Why was it a bad idea? Even without the auto transition, these files
are, IMHO, special enough and should have a domain. For example, you
may want to restrict run_init to only being able to execute
initrc_exec_t files.


> > The weird part is that SOME of the program.te files have a
> > domain_auto_trans line which serves essentially the same purpose. Does
> 
> Which ones are you referring to?

snort is one example I know by heart. I dig the utils, such as
ifconfig, but some daemons have this, too.


> I've put in the following:
> domain_auto_trans({ initrc_t inetd_t tcpd_t }, ftpd_exec_t, ftpd_t)
> 
> Better one line than 3.

yes. I'm still learning syntax, and just discovered that the policy
files understand lists. :)


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
