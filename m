Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBHhxRb004575
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 12:43:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBBHhwRV001375
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 17:43:58 GMT
Received: from smtp-mclean.mitre.org (smtp-mclean-x.mitre.org [192.80.55.71])
        by jazzband.ncsc.mil  with ESMTP id hBBHhvta001369 for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 17:43:57 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id hBBHhrx06955
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 12:43:53 -0500
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>, SE Linux <selinux@tycho.nsa.gov>,
   guttman@mitre.org (Joshua D. Guttman)
Subject: Re: Information flow models
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	<1070906232.6729.53.camel@colossus.columbia.tresys.com>
	<ogtu148yfom.fsf@divan.mitre.org>
	<1071069077.6729.108.camel@colossus.columbia.tresys.com>
	<ogt8ylky9mn.fsf@divan.mitre.org>
	<1071070628.6729.118.camel@colossus.columbia.tresys.com>
	<nha3cbsv6fv.fsf@malabar.mitre.org>
	<1071087506.6729.175.camel@colossus.columbia.tresys.com>
	<ogtr7zbebzr.fsf@divan.mitre.org>
	<1071158641.6729.185.camel@colossus.columbia.tresys.com>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 11 Dec 2003 12:43:49 -0500
In-Reply-To: <1071158641.6729.185.camel@colossus.columbia.tresys.com>
Message-ID: <nha4qw7jlm2.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@tresys.com> writes:

>   There are a lot of details required
>   for a flow to be valid: i.e. one of the types must be in the source
>   field of the rule, one of the types must be in the target field, there
>   must be an associated object class, and the permission on the object
>   class must map to a read and/or write. My graph representation simply
>   reflects this. If you have nodes with only types (or type plus role and
>   user) you lose a lot of information that is required to determine if a
>   multi-step path is valid.

Valid?  Could you explain what you mean by valid?  

Thanks.

        Joshua 
-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
