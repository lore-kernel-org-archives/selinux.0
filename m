Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CCoorT001557
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 08:50:50 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CCoTDC003135
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 12:50:29 GMT
Subject: Re: Policy flexibility & multiple Policy issue
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040711095847.82412.qmail@web51506.mail.yahoo.com>
References: <20040711095847.82412.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1089636639.22449.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 08:50:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 05:58, Park Lee wrote:
> Hi,
>       I reread the <<The Flask Security Architecture: System Support
> for Diverse Security Policies>>,in its introduction section there are
> some words:"Supporting policy flexibility in the operating system is a
> hard problem that goes beyond just supporting multiple policies." 
>       
>       Then I was confused with the following question:"What is exactly
> the difference between supporting policy flexibility and supporting
> multiple policies in the operating system?"  Before we support policy
> flexibility in the operating system, must we support multiple
> policies?

You can develop a system that supports several different policies
without providing genuine flexibility.  Read the remainder of the
paragraph that begins with the sentence you quoted, and read the next
section of the paper.  Policy flexibility goes beyond merely supporting
some list of known policies.  Hence, a policy flexible system will
support multiple policies, but not every system that supports multiple
policies is policy flexible.  This is all discussed in detail in the
paper.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
