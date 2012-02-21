Message-ID: <4F44114F.4080005@redhat.com>
Date: Tue, 21 Feb 2012 16:49:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: Another change we would like to make to libselinux
References: <4F3D16EF.6080904@redhat.com> <1329857024.12501.85.camel@moss-pluto>
In-Reply-To: <1329857024.12501.85.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/21/2012 03:43 PM, Stephen Smalley wrote:
> On Thu, 2012-02-16 at 09:47 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Currently we have lots of apps trying to figure out which policy
>> is installed on the system,  We have a function 
>> selinux_binary_policy_path which returns a path like 
>> '/etc/selinux/targeted/policy'
>> 
>> Then these apps do stuff like:
>> 
>> VER=`cat /sys/fs/selinux/policyver` while [ -e
>> '/etc/selinux/targetd/policy. + $VER' ]; do VER=$VER-1 done
>> 
>> While we have had /sys/fs/selinux/policy for a while now.
>> 
>> I wanted to add an interface to return this path, but I was
>> trying to figure out a name selinux_loaded_policy_path for
>> example, but as Eric pointed out to me,
>> selinux_binary_policy_path is what most users would expect to
>> return this.  If you look at the man page it even suggest this.
>> 
>> man selinux_binary_policy_path ... selinux_binary_policy_path() -
>> binary policy file loaded into kernel
>> 
>> 
>> Currently the users of this function are the libselinux package, 
>> setools and policycorutils (sepolgen-ifgen).
>> 
>> 
>> I am torn between adding stealing this function to return the 
>> /sys/fs/selinux/policy and then adding
>> selinux_installed_policy_path for the original function, then
>> updating the effected packages.
>> 
>> The problem with this is we would have different behaviour
>> between older versions of the library. The other options would be
>> to come up with a better name for the new function and fix the
>> man pages.
>> 
>> Suggestions welcomed.
> 
> Most applications should not be using /sys/fs/selinux/policy, as
> that requires the kernel to generate the policy image from its
> in-core data structures and is expensive.  So you certainly should
> not change selinux_binary_policy_path() to return that pathname.
> That also would be an incompatible interface change due to the
> version suffix, as you note.
> 
> So I think you need a new interface.  selinux_kernel_policy_path()
> or selinux_active_policy_path() or selinux_loaded_policy_path()
> seem fine to me.
> 

Right now we added selinux_current_policy_path and we are using it as
the default for seinfo, audit2allow, sepolgen-ifgen

It currently looks like

const char *selinux_current_policy_path(void)
{
	int rc = 0;
	int vers = 0;
	static char policy_path[PATH_MAX];

	snprintf(policy_path, sizeof(policy_path), "%s/policy", selinux_mnt);
	if (access(policy_path, F_OK) != 0 ) {
		vers = security_policyvers();
		do {
			/* Check prior versions to see if old policy is available */
			snprintf(policy_path, sizeof(policy_path), "%s.%d",
				 selinux_binary_policy_path(), vers);
		} while ((rc = access(policy_path, F_OK)) && --vers > 0);

		if (rc) return NULL;
	}

	return policy_path;
}


Although Eric wants to make some changes to it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9EEU8ACgkQrlYvE4MpobPk3ACePR4lD5RG9eFSMHz0ghJDey+b
tWkAoNzpy203Z99/tb1aI0aVYaoug5P3
=vdSB
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
