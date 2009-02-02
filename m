Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n12DeESm005565
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 08:40:14 -0500
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n12Db7uU024817
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 13:37:08 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n12Dbleh010637
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 08:37:47 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n12DdxqK164660
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 08:39:59 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n12Dcv7R009048
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 08:38:58 -0500
Subject: Re: [LTP] LTP SELinux policy error
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: James Morris <jmorris@namei.org>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov
In-Reply-To: <1233247899.13403.23.camel@gorn.columbia.tresys.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 02 Feb 2009 19:09:42 +0530
Message-Id: <1233581984.5934.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.

Regards--
Subrata

On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > I'm trying to run the LTP SELinux tests using the latest CVS version of 
> > > LTP and current Fedora development, and get the following policy 
> > > compilation error:
> > > 
> > > ----
> > > Compiling targeted test_policy module
> > > 
> > > test_policy.te:1730: Warning: r_dir_perms is deprecated please use list_dir_perms instead.
> > > test_policy.te:1731: Warning: r_file_perms is deprecated please use read_file_perms instead.
> > > [lots of warnings similar to the above]
> > > 
> > > /usr/bin/checkmodule:  loading policy configuration from 
> > > tmp/test_policy.tmp
> > > test_policy.te":16:ERROR 'syntax error' at token 
> > > 'userdom_use_sysadm_terms' on line 3198:
> > > userdom_use_sysadm_terms(testdomain)
> > > # This allows read and write sysadm ttys and ptys.
> > > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > make: *** [load] Error 2
> > > Failed to build and load test_policy module, aborting test run.
> > > ----
> > > 
> > > Is this likely to be fixed soon, and/or any suggestions for a workaround?
> > 
> > It won't compile with the current trunk refpolicy, since the current
> > release was a major, API breaking change.  I'll try to get a patch out
> > shortly.
> 
> I updated the policy since its fairly old, though I didn't convert its
> raw rules over to use interfaces.  However this didn't completely fix
> it, as there is usage of a "unconfined_runs_test()", which isn't in the
> upstream refpolicy nor the fedora policy, as far as I can see.  One of
> the updates includes use of sysadm_entry_spec_domtrans_to(), which is in
> the upstream refpolicy, but doesn't seem to have made its way downstream
> to the fedora policy.  I have attached my work so someone familiar with
> the LTP test cases can use it to complete the fix.
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
