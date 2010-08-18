Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7IBqo19029799
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 07:52:50 -0400
Received: from g4t0015.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o7IBrCX9017361
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 11:53:12 GMT
Subject: Re: Problem about audit-test-2090 + refpolicy-2.20091117
From: Paul Moore <paul.moore@hp.com>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy-mailing-list
 <refpolicy@oss1.tresys.com>
In-Reply-To: <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl>
References: <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 18 Aug 2010 07:52:47 -0400
Message-ID: <1282132367.4122.8.camel@flek>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-18 at 10:26 +0000, TaurusHarry wrote:
> Hi SELinux exports,
> 
> When I am trying to build the lspp_test.pp provided by
> audit-test-2090/utils/selinux-policy/lspp_test.* along with the
> refpolicy-20091117 source code, I copied lspp_test.* files to
> policy/modules/apps/ and then modified policy/modules.conf to declare
> "lspp_test = module", but I run into below error message ...

Is there any reason why you copied the lspp_test policy files to the
refpolicy sources and tried to build it there?  I'm not completely sure
that this is the cause of your problem but I can say for certain that
this is not a tested procedure for building the lspp_test module.

The normal procedure is to build the lspp_test policy module separately
from the system's main SELinux policy, e.g. build and install the normal
system's SELinux policy (refpolicy-20091117 in your case) and after you
have verified that everything is working correctly you can change to the
directory audit-test-*/utils/selinux-policy directory and use the
Makefile located their to build the lspp_test module.

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
