Subject: Re: libsepol will not compile
To: "Jesse M. Bacon" <jesse.bacon@ce.apexsystemsinc.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <1463767911810.39859@ce.apexsystemsinc.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b16667b4-bb8c-6756-6d9a-915b917c34ac@tycho.nsa.gov>
Date: Fri, 20 May 2016 15:13:57 -0400
MIME-Version: 1.0
In-Reply-To: <1463767911810.39859@ce.apexsystemsinc.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2016 02:11 PM, Jesse M. Bacon wrote:
> I am having an issue with SELinux.  We have servers currently deployed
> with Red Hat Enterprise Linux on them and they required enhanced access
> controls.  I have already recommended that we use SELinux to increase
> the security of our access controls for users and files.  I am
> attempting to work through a book on SELinux in order to make
> recommendations about how it can be leveraged on these systems.  The
> book exercises lead me to an example where I am running "chcat -l --
> +Salaries myuser".
> 
> 
> RHEL 6.7 is unable to create the security context.  I am in mls mode.
>   I grabbed a source version of the most recent build of SELinux so that
> I could build libsepol and semanage from source and see if that made a
> difference.  I found that RedHat had a bug report where semanage is
> faulty within their distribution and that a patch had been issued and
> everything but it looks like the patch is for Fedora.
> 
>  
> 
> Reference:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1048524
> 
> 
> The latest version of SELinux requires a compiler in excess of what
> ships with RHEL 6.7.  I upgraded to the 6.1 version of gcc and installed
> all the dependencies and crossed my fingers and ran make.
>  Unfortunately libsepol cannot compile because:
> 
> """
> 
> util.c:127: error: 'low_bit' may be used uninitialized in this function
> 
> """
> 
> I can't get any of it to compile even when I set the LIBDIR to lib64 and
> run make with --disable-multilib.
> 
> 
> Forgive me, I'm a beginner, I've never written a driver or kernel
> module, and I don't know what that means.  The RedHat guide for SELinux
> provides a gist for MLS.  I can work through that and will.  I am
> concerned that there will be no way to get this running given the OS and
> the documentation and a clean source build.  
> 
> 
> In order to get e more current version of SELinux and gcc I will have to
> go to RHEL7.  RHEL7 features grub2 and I still have to figure out how to
> audit that at boot time and additionally there is a use after free
> vulnerability that has me worried about access control credentials
> getting snooped.  I can't let that happen and RedHat says the
> vulnerability does not affect RHEL 6.7.  That I believe, is a
> separate issue. 
> 
> 
> There are a lot of appliances affected by this, I will need help writing
> configuration scripts to get them all into MLS mode and enforcing.
> 
> 
> Please forgive me if this isn't proper forum for this.      
> 
> 
> My system is unable to create the MLS context when I run the chcat
> -l command using the RedHat supplied packages
> 
> """
> 
> libsepol.mls_from_string:  invalid MLS context s0-s0:Salaries (No such
> file or directory)

I don't think you need to upgrade your SELinux userspace or compiler or
RHEL version if you just want to use SELinux on existing systems.  I
certainly wouldn't start there.

Your problem could be as simple as not running mcstrans, the label
translation daemon, which would normally handle mapping something like
Salaries to a value understood by libsepol and the kernel. Do you have
mcstrans installed and running?
