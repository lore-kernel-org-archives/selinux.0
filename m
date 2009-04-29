Subject: Re: [LTP] LTP SELinux policy error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        ltp-list@lists.sourceforge.net, selinux@tycho.nsa.gov,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1233581984.5934.39.camel@subratamodak.linux.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
	 <1233581984.5934.39.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 14:39:04 -0400
Message-Id: <1241030344.18249.270.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-02 at 19:09 +0530, Subrata Modak wrote:
> Thanks.
> 
> Regards--
> Subrata

Subrata - this patch never should have been applied.  Chris said that it
was incomplete, and I noted that it conflicted with Serge's
conditionally applied patch.  Please revert this, as it breaks the
selinux ltp testsuite and the resulting policy will not build.

> 
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
> > 
> > ------------------------------------------------------------------------------
> > This SF.net email is sponsored by:
> > SourcForge Community
> > SourceForge wants to tell your story.
> > http://p.sf.net/sfu/sf-spreadtheword
> > _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
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
