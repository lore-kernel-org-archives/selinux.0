Subject: Re: SELinux Packages and Library interactions...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0731C41F@de01exm68.ds.mot.com>
References: <4A9DE7FE.9000008@tycho.nsa.gov>
	 <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com>
	 <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E01459A64@exchange2.columbia.tresys.com>
	 <D06FE0A2807BC145B0D38744789D4F5D0731C41F@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 08:52:15 -0400
Message-Id: <1251982335.13634.69.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-02 at 15:37 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> Can someone point me to a nice diagram that describes the detailed
> interaction of all the SELinux packages and libraries (policycoreutils,
> checkpolicy, libselinux, libsepol, libsemanage, etc).
> 
> I am just trying to better understands what piece does what and how the
> pieces interact with each other. 
> 
> Thanks in advance.

Not sure about a diagram, but the basic descriptions and relationships
can be summarized as follows:

1. libsepol is the binary policy manipulation library.  It doesn't
depend upon or use any of the other components.

2. checkpolicy is the policy compiler.  It uses libsepol to generate the
binary policy.  checkpolicy uses the static libsepol since it deals with
low level details of the policy that have not been
encapsulated/abstracted by a proper shared library interface.

3. libselinux is the runtime SELinux library that provides interfaces
(e.g. library functions for the SELinux kernel APIs like getcon(), other
support functions like getseuserbyname()) to SELinux-aware applications.
libselinux may use the shared libsepol to manipulate the binary policy
if necessary (e.g. to downgrade the policy format to an older version
supported by the kernel) when loading policy.

4. libsemanage is the policy management library.  It uses libsepol for
binary policy manipulation and libselinux for interacting with the
SELinux system.  It also exec's helper programs for loading policy and
for checking whether the file_contexts configuration is valid
(load_policy and setfiles from policycoreutils) presently, although this
may change at least for the bootstrapping case (for rpm).

5. sepolgen is a python module/library that forms the core of the modern
audit2allow (a rewrite).

6. policycoreutils is a collection of policy utilities (originally the
"core" set of utilities needed to use SELinux, although it has grown a
bit over time), which have different dependencies. sestatus, secon,
run_init, and newrole only use libselinux.  load_policy and setfiles
only use libselinux and libsepol.   semodule and semanage use
libsemanage (and thus bring in dependencies on libsepol and libselinux
as well).  setsebool uses libselinux to make non-persistent boolean
changes (via the kernel interface) and uses libsemanage to make
persistent boolean changes.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
