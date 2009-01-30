Date: Fri, 30 Jan 2009 11:14:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Morris <jmorris@namei.org>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov
Subject: Re: LTP SELinux policy error
Message-ID: <20090130171453.GA10745@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org> <1233236562.9697.3.camel@gorn.columbia.tresys.com> <1233247899.13403.23.camel@gorn.columbia.tresys.com> <1233252592.5109.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233252592.5109.144.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > I'm trying to run the LTP SELinux tests using the latest CVS version of 
> > > > LTP and current Fedora development, and get the following policy 
> > > > compilation error:
> > > > 
> > > > ----
> > > > Compiling targeted test_policy module
> > > > 
> > > > test_policy.te:1730: Warning: r_dir_perms is deprecated please use list_dir_perms instead.
> > > > test_policy.te:1731: Warning: r_file_perms is deprecated please use read_file_perms instead.
> > > > [lots of warnings similar to the above]
> > > > 
> > > > /usr/bin/checkmodule:  loading policy configuration from 
> > > > tmp/test_policy.tmp
> > > > test_policy.te":16:ERROR 'syntax error' at token 
> > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > userdom_use_sysadm_terms(testdomain)
> > > > # This allows read and write sysadm ttys and ptys.
> > > > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > make: *** [load] Error 2
> > > > Failed to build and load test_policy module, aborting test run.
> > > > ----
> > > > 
> > > > Is this likely to be fixed soon, and/or any suggestions for a workaround?
> > > 
> > > It won't compile with the current trunk refpolicy, since the current
> > > release was a major, API breaking change.  I'll try to get a patch out
> > > shortly.
> > 
> > I updated the policy since its fairly old, though I didn't convert its
> > raw rules over to use interfaces.  However this didn't completely fix
> > it, as there is usage of a "unconfined_runs_test()", which isn't in the
> > upstream refpolicy nor the fedora policy, as far as I can see.  One of
> > the updates includes use of sysadm_entry_spec_domtrans_to(), which is in
> > the upstream refpolicy, but doesn't seem to have made its way downstream
> > to the fedora policy.  I have attached my work so someone familiar with
> > the LTP test cases can use it to complete the fix.
> 
> Serge put together a patch and script under selinux-testsuite/misc that
> defines unconfined_runs_test() as well as converting some of the
> interfaces.  That was done so that the ltp testsuite could still be run
> on older distributions (w/ the older policy) and on newer distributions
> (w/ the patch applied to perform conversion).  It was originally done
> based on the deprecation of the sbin interfaces, which is why it is
> named that way even though it now includes more than just conversion of
> those interfaces.

(Sorry, this thread is rolling into my inbox delayed and out-of-order)

So the unconfined_runs_test() shouldn't actually be a problem (right,
Chris? pls let me know if you actually get compile failures as then
something went wrong with the build scripts).

But what could have happened with sysadm_entry_spec_domtrans_to()?  It
must have been in fedora's policy before, since it definately worked on
fedora 7 and 8.  Has it been removed?  (I'll fire up a f10 partition and
look through the policy sources...)

As for the list_dir_perms and read_file_perms, have those always macros
in the refpolicy?  If so, then a straight search-and-replace is fine.
If not, then we'll have to do another hook at the policy build to make
the substitutions only when the policy is new enough.  :(

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
