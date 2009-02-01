Date: Sun, 1 Feb 2009 16:54:29 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov
Subject: Re: [LTP] LTP SELinux policy error
Message-ID: <20090201225429.GB12455@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org> <1233236562.9697.3.camel@gorn.columbia.tresys.com> <1233247899.13403.23.camel@gorn.columbia.tresys.com> <1233252592.5109.144.camel@localhost.localdomain> <20090130171453.GA10745@us.ibm.com> <20090130173700.GA12069@us.ibm.com> <1233345509.6143.43.camel@defiant.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233345509.6143.43.camel@defiant.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (pebenito@ieee.org):
> On Fri, 2009-01-30 at 11:37 -0600, Serge E. Hallyn wrote:
> > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > > > > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > > > > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > > > > I'm trying to run the LTP SELinux tests using the latest CVS version of 
> > > > > > > LTP and current Fedora development, and get the following policy 
> > > > > > > compilation error:
> > > > > > > 
> > > > > > > ----
> > > > > > > Compiling targeted test_policy module
> > > > > > > 
> > > > > > > test_policy.te:1730: Warning: r_dir_perms is deprecated please use list_dir_perms instead.
> > > > > > > test_policy.te:1731: Warning: r_file_perms is deprecated please use read_file_perms instead.
> > > > > > > [lots of warnings similar to the above]
> > > > > > > 
> > > > > > > /usr/bin/checkmodule:  loading policy configuration from 
> > > > > > > tmp/test_policy.tmp
> > > > > > > test_policy.te":16:ERROR 'syntax error' at token 
> > > > > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > > > > userdom_use_sysadm_terms(testdomain)
> > > > > > > # This allows read and write sysadm ttys and ptys.
> > > > > > > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> > > > > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > > > > make: *** [load] Error 2
> > > > > > > Failed to build and load test_policy module, aborting test run.
> > > > > > > ----
> > > > > > > 
> > > > > > > Is this likely to be fixed soon, and/or any suggestions for a workaround?
> > > > > > 
> > > > > > It won't compile with the current trunk refpolicy, since the current
> > > > > > release was a major, API breaking change.  I'll try to get a patch out
> > > > > > shortly.
> > > > > 
> > > > > I updated the policy since its fairly old, though I didn't convert its
> > > > > raw rules over to use interfaces.  However this didn't completely fix
> > > > > it, as there is usage of a "unconfined_runs_test()", which isn't in the
> > > > > upstream refpolicy nor the fedora policy, as far as I can see.  One of
> > > > > the updates includes use of sysadm_entry_spec_domtrans_to(), which is in
> > > > > the upstream refpolicy, but doesn't seem to have made its way downstream
> > > > > to the fedora policy.  I have attached my work so someone familiar with
> > 
> > sysadm_entry_spec_domtrans is in fedora 10's policy sources, at least,
> > in modules/roles/sysadm.if.  (I don't have a fedora devel system
> > installed).
> 
> That has the opposite transition direction (the specified domain
> transitions to sysadm).

Just to make sure...

You're saying that in upstream refpolicy sysadm_entry_spec_domtrans(foo)
means foo may transition to sysadm_t, while in fedora 10 policy
sysadm_entry_spec_domtrans(foo) means sysadm_t may transition to
foo?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
