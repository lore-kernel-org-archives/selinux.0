Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3RNEPmV020698
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 19:14:25 -0400
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3RNEONn028559
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 23:14:24 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3RNBtRo019975
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 17:11:55 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n3RNELib088370
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 17:14:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n3RNEKeA017183
	for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2009 17:14:21 -0600
Date: Mon, 27 Apr 2009 18:14:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Jiri Palecek >" <"<jirka"@debian.POK.IBM.COM>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>,
        SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [LTP] [PATCH] Fix running of the selinux tests
Message-ID: <20090427231421.GA2262@us.ibm.com>
References: <200904240037.n3O0b1CT023612@e6.ny.us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200904240037.n3O0b1CT023612@e6.ny.us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jiri Palecek > ("<jirka"@debian.POK.IBM.COM):
> Hello,
> 
> while running the ltp selinux tests on Debian, I found some problems:
> 
> 1) the testdomain attribute cannot have setcurrent permission to itself. This is because in Debian refpolicy, only domains with attribute set_curr_context can have setcurrent permission on own processes (otherwise, it's forbidden by neverallow). And AFAIK, it's impossible to specify that domains having attribute testdomain also have attribute set_curr_context. Moreover, I found only two tests (dyntrans and dyntrace) that actually need it so far, so I'm not convinced it has to be granted globally.
> 
> 2) the testscripts (eg. selinux_file.sh) have the test_file_t context, but they are to be run as sysadm_t. Sysadm_t therefore needs execute_no_trans permission on the test files.
> 
> Please correct me if I'm wrong.

Well we knew from the start that this method of trying to distribute
test policy wasn't going to be sustainable, but I think it's at the
point where we have to address it.

The way we were trying to handle policy changes over time was by
having 'misc/update_policy.sh' make distro- and version-specific
changes to the base refpolicy/ directory.  Jiri, if your part (1)
is a debian-specific fix, then another patch under misc/ probably
should've been used.  But as I say I think it's time to stop that
nonsense.  (I also notice a patch applied on Feb 2 by James which
makes some of the changes which misc/sbin_deprecated.patch also
does, thereby breaking its application.)

Chris, is it at all possible to distribute a module, never built
into the policy, but shipped with the sources, for the testsuite?
Then anyone who wanted to run the ltp testcases would install the
distro policy sources (yum install selinux-policy-sources,
apt-get source selinux-policy, whatever), compile the selinux-test
module, and the testsuite would

	semodule -i selinux-test.pp; run-tests; semodule -r selinux-test

?

The testcases don't really change (as far as i know) so that's not
where the churn is.  (If it was, then keeping them in uptream policy
would be more painful)  The policy just needs to change to reflect
changes in the base policy.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
