Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n74C6Ntk016319
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 08:06:23 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n74C5dQQ025006
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 12:05:41 GMT
Subject: Re: Just a quick thought.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A781970.7000106@redhat.com>
References: <4A781970.7000106@redhat.com>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 08:05:56 -0400
Message-Id: <1249387556.2932.4.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-04 at 07:20 -0400, Daniel J Walsh wrote:
> Now that we have labelling equivalence should we just add a 
> 
> /lib64 /lib
> /usr/lib64 /usr/lib
> /usr/local/lib64 /usr/local/lib
> 
> Seems we could simplify policy and prevent many mistakes.  Might speed up regex matching a little bit.
> 
> 
> grep 64 /etc/selinux/targeted/contexts/files/file_contexts | wc
>     259     735   18694
> 
> 
> If were were more agressive
> 
> /usr/local /usr
> /opt /usr

Makes sense to me.  But is there a way for the policy to specify an
equivalence, or is it currently limited to the semanage cli?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
