Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14403
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 10:58:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA05095
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:56:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA05089
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:56:14 GMT
Date: Fri, 1 Nov 2002 10:57:41 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Koichi ONOUE <koichi@osss.is.tsukuba.ac.jp>
cc: <selinux@tycho.nsa.gov>
Subject: Re: MLS
In-Reply-To: <20021101073100.066b9899.koichi@osss.is.tsukuba.ac.jp>
Message-ID: <Pine.LNX.4.33.0211011053240.16058-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Nov 2002, Koichi ONOUE wrote:

> I try to build and install example policy configuration with MLS.
> I add "policy/user" to below line.
>
>

  The user file is not part of this problem.

> but below error
>
> /usr/local/selinux/bin/checkpolicy: loading policy configuration from
> /etc/security/selinux/src/policy.conf
> ERROR 'permission transition is not defined for common file' at toke '}' on line 471:
> 	mounton		:	{ read write }
> /usr/local/selinux/bin/checkpolicy: error(s) encountered while parsing configuraion
> make: *** [/etc/security/selinux/policy.12-mls] Error 1
>
>
> Please tell me what I have to fix.
>

  In policy/mls, remove the line 'transition      :       write' that is
in the 'common file' class, at line 48 in the current distribution.

-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
