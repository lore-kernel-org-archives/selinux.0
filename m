Subject: Re: [LTP] [PATCH] Fix running of the selinux tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Jiri Palecek >" <"<jirka"@debian.POK.IBM.COM>,
        "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>,
        SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <20090427231421.GA2262@us.ibm.com>
References: <200904240037.n3O0b1CT023612@e6.ny.us.ibm.com>
	 <20090427231421.GA2262@us.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Apr 2009 08:22:47 -0400
Message-Id: <1240921367.18249.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-27 at 18:14 -0500, Serge E. Hallyn wrote:
> Quoting Jiri Palecek > ("<jirka"@debian.POK.IBM.COM):
> > Hello,
> > 
> > while running the ltp selinux tests on Debian, I found some problems:
> > 
> > 1) the testdomain attribute cannot have setcurrent permission to itself. This is because in Debian refpolicy, only domains with attribute set_curr_context can have setcurrent permission on own processes (otherwise, it's forbidden by neverallow). And AFAIK, it's impossible to specify that domains having attribute testdomain also have attribute set_curr_context. Moreover, I found only two tests (dyntrans and dyntrace) that actually need it so far, so I'm not convinced it has to be granted globally.
> > 
> > 2) the testscripts (eg. selinux_file.sh) have the test_file_t context, but they are to be run as sysadm_t. Sysadm_t therefore needs execute_no_trans permission on the test files.
> > 
> > Please correct me if I'm wrong.
> 
> Well we knew from the start that this method of trying to distribute
> test policy wasn't going to be sustainable, but I think it's at the
> point where we have to address it.
> 
> The way we were trying to handle policy changes over time was by
> having 'misc/update_policy.sh' make distro- and version-specific
> changes to the base refpolicy/ directory.  Jiri, if your part (1)
> is a debian-specific fix, then another patch under misc/ probably
> should've been used.  But as I say I think it's time to stop that
> nonsense.  (I also notice a patch applied on Feb 2 by James which
> makes some of the changes which misc/sbin_deprecated.patch also
> does, thereby breaking its application.)
> 
> Chris, is it at all possible to distribute a module, never built
> into the policy, but shipped with the sources, for the testsuite?
> Then anyone who wanted to run the ltp testcases would install the
> distro policy sources (yum install selinux-policy-sources,
> apt-get source selinux-policy, whatever), compile the selinux-test
> module, and the testsuite would
> 
> 	semodule -i selinux-test.pp; run-tests; semodule -r selinux-test
> 
> ?
> 
> The testcases don't really change (as far as i know) so that's not
> where the churn is.  (If it was, then keeping them in uptream policy
> would be more painful)  The policy just needs to change to reflect
> changes in the base policy.

While I think that would be a better way forward for maintainability, it
won't help with the continued use of the ltp selinux tests as a
regression test on updates to existing distribution releases (e.g. RHEL
4.x and 5.x).  So we'll at least have to keep a legacy test policy in
the ltp tree for that purpose.

Also, I expect it will be painful to convert the current test policy
into a form fully acceptable to refpolicy, as it was never fully
converted over to using interfaces for all references to external types
and doing so requires creating a number of interfaces that will only
ever be used by the test policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
