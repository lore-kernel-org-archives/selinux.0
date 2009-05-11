Subject: Re: [PATCH] Update ltp selinux test script and policy
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1241532614.3023.320.camel@localhost.localdomain>
References: <1241532614.3023.320.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 May 2009 14:46:08 +0530
Message-Id: <1242033368.6102.96.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-05 at 10:10 -0400, Stephen Smalley wrote: 
> ***********************
> Warning: Your file, ltp-refpolicy-redhat.tgz, contains more than 32 files after decompression and cannot be scanned.
> ***********************
> 
> 
> Note:  This does not obsolete or replace the other two patches I have
> posted (Fix LTPBIN definition in selinux_file.sh, Fix MLS handling in
> selinux tests), but rather should be applied on top of them.
> 
> Attached is a patch and a tar file to update the ltp selinux test script
> and policy so that we no longer conditionally patch the test policy when
> we run the test script.  The patch does the following:
> - Disable patching of the policy in the test script.
> - Change the refpolicy Makefile to redirect to a rhel/N/ subdirectory if
> running on a redhat release and move the rhel-specific definitions
> there.
> - Change the refpolicy Makefile to only include test_bounds.te if the
> checkpolicy supports policy.24 (and thus typebounds statements).
> - Merge the sbin_deprecated.patch into the test policy.
> - Further update the test policy to build cleanly on f11, while
> preserving backward compatibility on f10.
> - Added open permissions as necessary to the test policy (enabled in
> f11).
> - Update the ioctl test policy to reflect the updated
> selinux_file_ioctl() logic in the kernel.
> - Added a missing permission to the wait test policy that was causing it
> to wrongly report PASS.
> 
> The tar file contains a new
> testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5
> subdirectory to preserve a legacy copy of the test policy that works on
> redhat 5.  The top-level refpolicy Makefile will redirect to this
> subdirectory when it detects redhat 5.  Similar subdirectories can be
> added for other stable releases going forward as needed.
> 
> Subrata, please cvs add the new subdirectory and its files.  Also,

Done.

> please cvs remove the following:
> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.te

Removed.

> (generated file, should not be in the repository)
> ltp/testcases/kernel/security/selinux-testsuite/misc/*

Done for this too.

Regards--
Subrata

> 
> Thanks.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
