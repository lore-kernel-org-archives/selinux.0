Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA29899
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 13:48:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA19171
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 17:47:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA19167
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2001 17:47:52 GMT
Date: Wed, 6 Jun 2001 13:47:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Rajan Ravindran <rajancr@us.ibm.com>
cc: selinux@tycho.nsa.gov
Subject: Re: policy
In-Reply-To: <OF91F9E67A.CC87EF75-ON85256A5E.0049C6D1@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010606133554.3546W-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 1 Jun 2001, Rajan Ravindran wrote:

> While I do relabel my file system, I'm getting some errors as
> 
> invalid context system_u:object_r:sysadm_netscape_rw_ti on line number 65
> 
> similar errors (by appending 'i' at the end of type field in the context)
> at different line numbers.

I haven't seen this error, and nothing springs to mind as a 
possible cause.  Try using gdb on the setfiles program,
setting a breakpoint immediately after the sscanf call (line 458),
and a breakpoint before the security_context_to_sid call (line 553).
Examine context at each breakpoint.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
