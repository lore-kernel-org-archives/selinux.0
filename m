Subject: Re: [LTP] [PATCH] Fix running of the selinux tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jiri Palecek <jpalecek@web.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200904281303.20594.jpalecek@web.de>
References: <200904240037.n3O0b1CT023612@e6.ny.us.ibm.com>
	 <20090427231421.GA2262@us.ibm.com>  <200904281303.20594.jpalecek@web.de>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 14:57:45 -0400
Message-Id: <1241031465.18249.276.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-28 at 13:03 +0200, Jiri Palecek wrote:
> On Tuesday 28 April 2009 01:14:21 Serge E. Hallyn wrote:
> > Quoting Jiri Palecek > (jpalecek@web.de):
> > > Hello,
> > > 
> > > while running the ltp selinux tests on Debian, I found some problems:
> > > 
> > > 1) the testdomain attribute cannot have setcurrent permission to itself. This is because in Debian refpolicy, only domains with attribute set_curr_context can have setcurrent permission on own processes (otherwise, it's forbidden by neverallow). And AFAIK, it's impossible to specify that domains having attribute testdomain also have attribute set_curr_context. Moreover, I found only two tests (dyntrans and dyntrace) that actually need it so far, so I'm not convinced it has to be granted globally.
> > > 
> > > 2) the testscripts (eg. selinux_file.sh) have the test_file_t context, but they are to be run as sysadm_t. Sysadm_t therefore needs execute_no_trans permission on the test files.
> > > 
> > > Please correct me if I'm wrong.
> > 
> > Well we knew from the start that this method of trying to distribute
> > test policy wasn't going to be sustainable, but I think it's at the
> > point where we have to address it.
> > 
> > The way we were trying to handle policy changes over time was by
> > having 'misc/update_policy.sh' make distro- and version-specific
> > changes to the base refpolicy/ directory.  Jiri, if your part (1)
> > is a debian-specific fix,
> 
> Note that I'm not sure about this; I just assume it's Debian specific,
> because I assume it works for everybody else :) On the second sight, I
> just checked upstream refpolicy and it seems the offending neverallow
> was there at lest from 2006.

That's why the selinux-testsuite/README says you have to put
expand-check=0 in your /etc/selinux/semanage.conf file, which
test_selinux.sh does automatically.

> 
> > then another patch under misc/ probably
> > should've been used.  But as I say I think it's time to stop that
> > nonsense.  (I also notice a patch applied on Feb 2 by James which
> > makes some of the changes which misc/sbin_deprecated.patch also
> > does, thereby breaking its application.)
> > 
> > Chris, is it at all possible to distribute a module, never built
> > into the policy, but shipped with the sources, for the testsuite?
> > Then anyone who wanted to run the ltp testcases would install the
> > distro policy sources (yum install selinux-policy-sources,
> > apt-get source selinux-policy, whatever), compile the selinux-test
> > module, and the testsuite would
> > 
> > 	semodule -i selinux-test.pp; run-tests; semodule -r selinux-test
> > 
> > ?
> 
> It isn't like this now? I had the impression most of the policy needed to run ltp selinux tests was build from the ltp sources and loaded by
> 
>   semodule -i test_policy.pp
> 
> There are some remnants of the test policy in refpolicy, but these are only few macros and types.
> 
> > The testcases don't really change (as far as i know) so that's not
> > where the churn is.  (If it was, then keeping them in uptream policy
> > would be more painful)  The policy just needs to change to reflect
> > changes in the base policy.
> 
> Regards
>     Jiri Palecek
> 
> ------------------------------------------------------------------------------
> Register Now & Save for Velocity, the Web Performance & Operations 
> Conference from O'Reilly Media. Velocity features a full day of 
> expert-led, hands-on workshops and two days of sessions from industry 
> leaders in dedicated Performance & Operations tracks. Use code vel09scf 
> and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
