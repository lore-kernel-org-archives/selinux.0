Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81GoSrT022561
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 12:50:29 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81GoReu009166
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:50:27 GMT
Subject: Re: Interpret security context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040901143631.18080.qmail@web51505.mail.yahoo.com>
References: <20040901143631.18080.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1094057331.13328.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 12:48:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 10:36, Park Lee wrote:
> Hi,
> In subsection 5.2.1 Object Labeling of <<The Flask Security
> Architecture: System Support for Diverse Security Policies>>, it says:
>    A security context, the first policy-independent data type, is a
> variable-length string which can be interpreted by any application or
> user with an understanding of the security policy.
>  
>         While, In subsection 2.1.Flask Concepts of <<Configuring the
> SELinux Policy>>, it says:
>    The content and format of a security context depends on the
> particular security model, so a security context is only interpreted
> by the security server.
>  
>         Then, Who can interpret the security context except security
> server? Can any application or user with an understanding of the
> security policy interpret the security context in the end?

No conflict there.  The context _can_ be interpreted by anything that
understands the policy; the context _is_ only interpreted by the
security server in the Flask architecture (i.e. it is _not_ interpreted
by the object managers).  The point is that the context intepretation
requires knowledge of the policy, while the object managers are policy
neutral.  
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
