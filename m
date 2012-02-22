Message-ID: <4F4509BC.9030604@redhat.com>
Date: Wed, 22 Feb 2012 10:29:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: Another change we would like to make to libselinux
References: <4F3D16EF.6080904@redhat.com>  <1329857024.12501.85.camel@moss-pluto> <4F44114F.4080005@redhat.com>  <4F44ED53.5040807@tresys.com>  <4F44EEEF.8090506@redhat.com> <1329919701.15569.20.camel@moss-pluto>
In-Reply-To: <1329919701.15569.20.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/22/2012 09:08 AM, Stephen Smalley wrote:
> On Wed, 2012-02-22 at 08:34 -0500, Daniel J Walsh wrote:
>> Well I see for multiple reasons.
>> 
>> One the stupid algorithm for finding what was the currect policy
>> to read was spreading to multiple tools places.  (setools, 
>> sepolgen-ifgen, load_policy, audit2why, each one doing it
>> slightly differently.
> 
> So that's an argument for providing an interface that gives that
> full pathname of the policy file, not for using the kernel policy
> file by default.  BTW, we could likely have libsemanage create a
> symlink from /etc/selinux/$SELINUXTYPE/policy/policy to the
> policy.N file it just created.  And then you could just always use
> that pathname.
> 
That would help the problem.
>> We had apps like setroubleshoot that are trying to analyze the
>> policy at the time that an AVC happened and potentially analyzing
>> a different policy.  (Theoretically try for audit2allow/audit2why
>> also.)
> 
> I don't quite understand why that would happen, except for
> transient boolean changes, and how often do those occur these
> days?
> 
Well they might be getting more popular with booleans like
deny_ptrace.   But the fact remains we are checking a file that may or
may not be loaded into the kernel.
>> sepolgen-ifgen was not figuring out the correct policy to analyze
>> if policy.27 was installed but the kernel was looking at
>> policy.26
> 
> How did that happen?  If policy.27 exists and libsepol supports
> policy version 27, then load_policy will use policy.27 and
> downgrade it in memory before loading into the kernel.  It will not
> use the policy.26 file.
> 
Because we don't expose libsepol policy max function in a python
binding, or to libselinux in a reasonable way, so the code currently
reads policy version and reads down.  Since it starts at policy.26 it
does not find it.  Your previous complaint against my patch exposes
this.  Currently we have a hacky load_policy call that loads the
libsepol shared library with a dlopen and then gets the max_ver out of
it.  I am not sure I want to suck this call into any app that wants to
read policy.

>> We had the ability to analyze the loaded policy and no one was
>> using it.
> 
> The only reason we added the kernel policy pseudo file was to
> support checking that the loaded kernel policy matched the one on
> disk.
> 
Potentially this fix would allow the policy file to not be required
after boot.
>> I hate the algorithm for finding the path to the policy on disk.
>> And would rather only expose it to one tool load_policy.
> 
> This is the same as the first one.
> 

Maybe the best solution is for libsemanage to make the symbolic link.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9FCbwACgkQrlYvE4MpobMK1gCglSbrFcUGJW0E+Tj/Qi+3vPY0
swwAmgJ+siTpwfeLpxcWQDWLPjtfiOMe
=iGSC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
