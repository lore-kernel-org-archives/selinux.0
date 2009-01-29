Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0TDhjMd008954
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2009 08:43:45 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n0TDhidD012998
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2009 13:43:44 GMT
Subject: Re: LTP SELinux policy error
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: ltp-list@lists.sourceforge.net, selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 08:42:42 -0500
Message-Id: <1233236562.9697.3.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> I'm trying to run the LTP SELinux tests using the latest CVS version of 
> LTP and current Fedora development, and get the following policy 
> compilation error:
> 
> ----
> Compiling targeted test_policy module
> 
> test_policy.te:1730: Warning: r_dir_perms is deprecated please use list_dir_perms instead.
> test_policy.te:1731: Warning: r_file_perms is deprecated please use read_file_perms instead.
> [lots of warnings similar to the above]
> 
> /usr/bin/checkmodule:  loading policy configuration from 
> tmp/test_policy.tmp
> test_policy.te":16:ERROR 'syntax error' at token 
> 'userdom_use_sysadm_terms' on line 3198:
> userdom_use_sysadm_terms(testdomain)
> # This allows read and write sysadm ttys and ptys.
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make[1]: *** [tmp/test_policy.mod] Error 1
> make[1]: Leaving directory `/usr/share/selinux/devel'
> make: *** [load] Error 2
> Failed to build and load test_policy module, aborting test run.
> ----
> 
> Is this likely to be fixed soon, and/or any suggestions for a workaround?

It won't compile with the current trunk refpolicy, since the current
release was a major, API breaking change.  I'll try to get a patch out
shortly.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
