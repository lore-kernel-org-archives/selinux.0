Message-ID: <47A38A68.8070001@redhat.com>
Date: Fri, 01 Feb 2008 16:08:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I have spit out my current diffs in policy on fedoraproject.org
References: <47A33458.505@redhat.com>	 <1201878327.4568.158.camel@moss-spartans.epoch.ncsc.mil>	 <200802011107.29538.paul.moore@hp.com> <1201894768.21440.10.camel@gorn.columbia.tresys.com>
In-Reply-To: <1201894768.21440.10.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Fri, 2008-02-01 at 11:07 -0500, Paul Moore wrote:
>> On Friday 01 February 2008 10:05:27 am Stephen Smalley wrote:
>>> On Fri, 2008-02-01 at 10:01 -0500, Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> http://people.fedoraproject.org/~dwalsh/Policy/
>>>>
>>>> Patch is now up to 28000 lines.
>>>>
>>>> {snip}
>>>>
>>>> Going forward this is going to get more difficult.  I think we need
>>>> more people with the ability to update the reference policy.  Even
>>>> if they just cherry pick through the differences in my patches and
>>>> upstream.  I don't believe one person can keep up with the volume
>>>> of changes.
>>> Maybe create a fedora branch of refpolicy?
>> Does this actually solve the problem, or just move the patch problem 
>> from outside refpolicy SVN into a branch within refpolicy?  The changes 
>> still need to get merged into the trunk and I'm not sure a branch helps 
>> that any (maybe it does, I guess it all depends on how Chris works).
> 
> That doesn't help me; on many things I need more information on the
> change, so a patch format works.  Some of the problems are that the
> patches are divided by module, not by changeset.  Its better than one
> big mega patch, but still suboptimal, especially if a changeset crosses
> modules.  I still suggest using quilt.
> 
> I'd suggest using trac's bug system on the refpolicy site so we can have
> tracking of patches without flooding the mail list, however I'm sure Dan
> isn't interesting in entering in 147 bugs (unless there is a nice
> command line tool that can do this that I don't know of).
> 

The problem is something like  quilt works if you sit down and do one
massive change to policy, like removing the role separation on homedirs.
 But I get 10 Bugzilla's a day that I make changes to in the same pool.
 Then back port these fixes into F7, F8 and RHEL5.  I am also adding
additional policy components all the time.  A lot of times while I am
fixing an AVC Bugzilla, I will notice that the policy really needs a
higher level function like auth_use_nsswitch(), I make the change while
I am in there.

So it would be tough to change the way  I am working.  What we really
could use is some volunteers review and  package up changes in a way
that Chris would like to see them.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkejimgACgkQrlYvE4MpobOFQQCg3u0coLduGjwDnjAv2A/AT9l3
wNoAnjqZzuCDItJGpz3EADqMRdO38RE9
=OWij
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
