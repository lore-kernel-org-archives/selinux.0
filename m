Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGRARb020383
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:27:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KGOiB2008339
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:24:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4KGOhwi008336
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:24:43 GMT
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <rcoker@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520161423.GJ8810@lkcl.net>
References: <20040519074242.GK7348@lkcl.net>
	 <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20040520145258.GF8810@lkcl.net> <200405210139.49261.rcoker@redhat.com>
	 <20040520161423.GJ8810@lkcl.net>
Content-Type: text/plain
Message-Id: <1085070386.521.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 12:26:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 12:14, Luke Kenneth Casson Leighton wrote:
>  sadly i cannot tell.  i have been meaning to ask:
> 
>  is it possible to run things to present more debug info at the TIME
>  that an avc message is placed in the logs?

You might get more information by enabling syscall auditing in your
kernel.  Boot with audit=1.

You could patch the audit daemon (if you are running one) or syslogd to
run whatever you want as it receives audit messages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
