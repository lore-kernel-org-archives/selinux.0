Message-ID: <53BEA077.5070503@tresys.com>
Date: Thu, 10 Jul 2014 10:17:27 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com> <53BE9F2A.9050906@tycho.nsa.gov>
In-Reply-To: <53BE9F2A.9050906@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 10:11 AM, Stephen Smalley wrote:
> On 07/09/2014 03:21 PM, Steve Lawrence wrote:
>> In January, we sent an RFC [1] to update userspace to integrate CIL
>> [2] and source policy. And in April, we sent an updated RFC [3] which
>> added support for high level languages and a tool to convert policy
>> package (pp) files to CIL. After getting some good feedback, we have
>> made some more changes, mostly to maintain ABI compatibility. The
>> major changes made since the last patchset are:
>>
>> - Change how semanage_set_root was re-added to use the source policy
>>   infrastructure. Fixes were made so that semanage.conf was looked for
>>   inside the root. Also adds an semanage_root() function to get the
>>   current root.
>> - In previous patchsets, the semanage_module_upgrade* and
>>   semanage_module_install_base* functions were removed from the API,
>>   and semanage_module_install* had modified parameters. However, these
>>   changes broke the API and ABI. To maintain ABI compatibility, we've
>>   now added symbolic versioning to support the old version of the
>>   functions, which now just call the new install functions. semodule
>>   is updated to support --base and --upgrade, but with the addition of
>>   a deprecation message. API compatability is not maintained.
>> - Likewise, symbolic versioning was added to support the old module
>>   enable/disable functions, which call the new enable/disable
>>   functions.
>> - Modify the libsepol Makefile to now make including CIL optional via
>>   the DISABLE_CIL build flag. This only affects libsepol (not
>>   libsemanage), primarily so that SE for Android does not need to
>>   include unused CIL cruft.
>>
>> With these changes, ABI compatibility is maintained. Additionally, we
>> have tested these changes with the userspace tests and against the
>> kernel test suite, and no new failures were discovered. We have
>> also tested this patchset with both Fedora 20 policy and with reference
>> policy and found no errors.
>>
>> Because of the size of the patchset (67 file changes, ~8300
>> insertions, ~1800 deletions), all the changes have been pushed to the
>> selinux git repository to the 'integration' branch for
>> comments/review. Unlike the previous RFCs, for simplicity there is now
>> only a single branch, containing three types of changes:
>>
>> Reverts
>>    Reverts changes made to master that conflict with the new source
>>    policy infrastructure (e.g. how paths are handled,
>>    enabled/disable modules). Rather than dealing with a large amount
>>    of conflicts with the source policy work, it was easier to just
>>    remove the commits that added conflicting features, rebase the old
>>    source policy work on top of that, and add back any features in a
>>    manner consistent with source policy. The only conflicts were
>>    related to enabling/disabling of modules, and semanage_set_root.
>>
>> Source Policy
>>    This is a rebase of the old src-policy branch on top of the
>>    reverted commits.  The goal of these changes is to improve the API
>>    for module handling, add support for source policies, module
>>    priorities, enabling/disabling of modules, and moving the policy
>>    store from /etc/selinux/<store>/ to /var/lib/selinux/<store>/.
>>
>> CIL Integration
>>    These changes build CIL into libsepol, and updates libsepol,
>>    libsemanage, semodule, and semanage to work with and understand CIL
>>    files and manage /var/lib/selinux and /etc/selinux. Switching to
>>    CIL has a few side effects, such as removing base modules,
>>    versions, and upgrades.
>>
>>    This also adds a new tool (installed to
>>    /usr/libexec/selinux/hll/pp), which is an HLL compiler that
>>    converts binary pp modules to CIL. The infrastructure to use this
>>    compiler (or any other HLL compiler) was added to compile HLL
>>    modules to CIL, which is accomplished by writing the HLL data to
>>    the stdin of the compiler and reading the equivilent CIL from
>>    stdout. The resulting CIL is then cached in the policy store so
>>    this compilation does not need to take place during future store
>>    updates. Cached CIL modules can be ignored using a new semodule
>>    flag (-C/--ignore-cache) or a new configuration option in
>>    semanage.conf (ignore-cache). Other configuration options were
>>    added to semanage.conf to manage the path to HLL compilers
>>    (compiler-directory) and the policy store (store-root). Semodule
>>    was also modified to support changing the policy store with the
>>    -S/--store-root option.
>>
>>    Lastly, the CIL integration changes required changes to the API,
>>    but symbolic versioning was used to maintain ABI compatibility.
>>    Because of this, the .so version is no longer incremented like in
>>    the previous version of this RFC.
>>
>> With these changes, it is possible to build and manage SELinux
>> policy using pp and CIL modules and the familiar semodule/semanage
>> tools.
>>
>> To make this easier to experiment with and test, below are the steps
>> needed to install the updated userspace and migrate a minimal Fedora 20
>> installation to the new policy store.
>>
>> Thanks, and we look forward to any questions/comments.
>>
>> - Steve
>>
>> [1] http://marc.info/?l=selinux&m=138921403805934&w=2
>> [2] https://github.com/SELinuxProject/cil/wiki
>> [3] http://marc.info/?l=selinux&m=139878606630921&w=2
>>
>>
>> Steps to Install SELinux Userspace with source policy, CIL, and HLL
>>
>> # Start with a fresh Fedora 20-x86_64 Mimimal Installation
>>
>> # Install SELinux userspace dependencies
>> $ yum install audit-libs-devel bison bzip2-devel dbus-devel
>> dbus-glib-devel flex flex-static gcc git glib2-devel libcap-ng-devel
>> libcgroup-devel libsepol-static pcre-devel python-devel python-IPy
>> setools-devel swig ustr-devel
>>
>> # Update to the latest targeted policy
>> $ yum update selinux-policy-targeted
>>
>> # Clone the repos and checkout branches
>> $ git clone -b integration https://github.com/SELinuxProject/selinux.git
>> $ git clone -b master https://github.com/SELinuxProject/cil.git
>>
>> # Create a symlink to the cil repo so CIL can be built into libsepol
>> $ ln -s ~/cil/ selinux/libsepol/cil
>>
>> # Install SELinux userspace with CIL integration and HLL support
>> $ make -C selinux LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap
>>
>> # Migrate to the new source policy infrastructure
>> $ ./selinux/libsemanage/utils/semanage_migrate_etc_to_var.py
>>
>> # List the installed modules, showing priority and HLL
>> $ semodule --list=full
> 
> Is the classorder bug?
> $ su <hangs forever>
> $ dmesg
>  systemd[1]: SELinux policy denies access.
> 
> 

The classorder bug has been fixed with the latest cil & integration
branch, and shouldn't have been a problem with fedora's policy since the
pp2cil tool should have output the classes in the correct order.

I'm not able to reproduce this problem. su works correctly and
immediately for me. What commands did you run before this?
