Subject: Re: [RFC] Kernel .config options for building LTP SECURITY TESTS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: subrata@linux.vnet.ibm.com
Cc: Serge Hallyn <serue@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>, Li Zefan <lizf@cn.fujitsu.com>
In-Reply-To: <1225799165.5269.59.camel@subratamodak.linux.ibm.com>
References: <1225799165.5269.59.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 09:47:28 -0500
Message-Id: <1225810048.11720.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-11-04 at 17:16 +0530, Subrata Modak wrote:
> Hi Serge & Stephen,
> 
> Are there any more .config options required to be set/unset for
> compiling 2.6.27 with all LSM enabled, apart from below:
> 
> CONFIG_SECURITY=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_FILE_CAPABILITIES=y

These are fine.

> CONFIG_SECURITY_ROOTPLUG=y

Don't enable rootplug - it doesn't honor the security= option.  See
below.  Plus it is just a toy example for an article that was published
long ago.  I don't really understand why it is in mainline.

> CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0

This has to be set to a positive value if you want to test this check.
Fedora kernels set it to 65536.

> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y

These are fine.

> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=y

You don't want this one unless you are running Fedora 3 or 4.  On
anything newer, it will cause unnecessary policy expansion.

> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE=19
> CONFIG_SECURITY_SMACK=y
> 
> I would like to run the filecaps and selinux tests in LTP and may be any
> SMACK tests in future. Will it create a problem if kernel is built with
> both below options set:
> 
> CONFIG_SECURITY_SMACK=y
> CONFIG_SECURITY_SELINUX=y

By default, if you boot with multiple LSMs compiled into the kernel, the
kernel won't boot succesfully - there can be only one (aside from
explicit internal "stacking" e.g. as is done for combining SELinux or
Smack with capabilities).  Unless you use the security= option to select
one at boot.  SELinux and Smack will honor the security= option.

> A great help would be in the form of a patch in updating:
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/selinux-testsuite/README
> 
> in terms of exact SELinux policy(s) and userspace tool(s) to be
> installed (from where to get and where to put) to build and run the
> SELinux testsuite, supposing that a new kernel is built and no SELinux
> policies/uerspace tools existed there before.

The existing ltp selinux testsuite presumes that you have an existing
SELinux policy + userspace tools.  I've only ever used it on Fedora and
RHEL, and principally on the latest Fedora.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
