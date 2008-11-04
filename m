Subject: [RFC] Kernel .config options for building LTP SECURITY TESTS
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Serge Hallyn <serue@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, SE Linux <selinux@tycho.nsa.gov>,
        Li Zefan <lizf@cn.fujitsu.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 17:16:05 +0530
Message-Id: <1225799165.5269.59.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Serge & Stephen,

Are there any more .config options required to be set/unset for
compiling 2.6.27 with all LSM enabled, apart from below:

CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_FILE_CAPABILITIES=y
CONFIG_SECURITY_ROOTPLUG=y
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y
CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=y
CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE=19
CONFIG_SECURITY_SMACK=y

I would like to run the filecaps and selinux tests in LTP and may be any
SMACK tests in future. Will it create a problem if kernel is built with
both below options set:

CONFIG_SECURITY_SMACK=y
CONFIG_SECURITY_SELINUX=y

A great help would be in the form of a patch in updating:
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/selinux-testsuite/README

in terms of exact SELinux policy(s) and userspace tool(s) to be
installed (from where to get and where to put) to build and run the
SELinux testsuite, supposing that a new kernel is built and no SELinux
policies/uerspace tools existed there before.


Regards--
Subrata



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
