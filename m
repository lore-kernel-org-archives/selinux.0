Message-ID: <475D6C01.4050804@redhat.com>
Date: Mon, 10 Dec 2007 11:40:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: system_u:system_r:system_chkpwd_t:UNCLASSIFIED, how did I get
 here?
References: <475ACE83.30609@gmail.com>	 <1197298556.18120.53.camel@moss-spartans.epoch.ncsc.mil> <cadfc0e40712100729t633a31ebwc15fa7fbb592df24@mail.gmail.com>
In-Reply-To: <cadfc0e40712100729t633a31ebwc15fa7fbb592df24@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
>  sudo /usr/sbin/semanage login -l
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> __default__               system_u                  UNCLASSIFIED
> root                      root                      UNCLASSIFIED-SystemHigh
> system_u                  system_u                  UNCLASSIFIED-SystemHigh
> 
> So I did:
> sudo /usr/sbin/semanage login -m -s "user_u" __default__
> 
> and now life is good
> id -Z
> user_u:user_r:user_t:UNCLASSIFIED
> 
> Dan, I'd think that the policy spec file should probably do this for
> mls as it does similar a thing to set the default login user for
> targeted.
> 
> 
> On Dec 10, 2007 8:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Sat, 2007-12-08 at 11:04 -0600, Ted X Toth wrote:
>>> I'm running F8 with MLS reference policy (in permissive right now) and
>>> I'm trying to understand how I get into this context. I can understand
>>> how at some point while authenticating a transition to
>>> system_u:system_r:system_chkpwd_t would occur by virtue of running
>>> unix_chkpwd but then why wouldn't a transition to user_u:user_r:<*>_t
>>> happen? Also I'd like to understand how policy for pam, since it's a
>>> bunch of shared libraries, works. Are there any good sources of
>>> information on writing policy for shared libraries?
>> getdefaultcon in libselinux/utils can help you with investigating what
>> context will be returned for a given user and from-context (i.e. context
>> of the login process).
>>
>> First question is why is the user being mapped to system_u?  Bad seusers
>> configuration?  semanage login -l
>>
>> As for chkpwd, get_ordered_context_list() first asks the kernel for the
>> full set of reachable contexts for the user via security_compute_user(),
>> which merely checks process transition permission.  Thus, the chkpwd
>> context is included in that set since it is reachable (since the login
>> process does in fact transition to it when executing unix_chkpwd).  But
>> it normally gets pruned from the final list based
>> on /etc/selinux/$SELINUXTYPE/contexts/default_contexts.  However, if no
>> matches are found there, it will return the original list from the
>> kernel, and thus you could end up there (in permissive mode).  There has
>> been some talk of overhauling get_ordered_context_list.
>>
>> With regard to pam, there are no domain transitions on function calls,
>> only on execve, so there are no domain transitions when invoking pam
>> modules, only when those modules invoke helper programs like
>> unix_chkpwd.  The pam modules themselves run within the domain of the
>> caller.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>

I am not sure houw you got this since the defaults for mls are

 more /etc/selinux/mls/seusers
system_u:system_u:s0-s15:c0.c1023
root:root:s0-s15:c0.c1023
__default__:user_u:s0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHXWwBrlYvE4MpobMRAo16AKCyvztnjdUNxByMR5LpBoZaGBO1dwCg3BWX
d4OmjvF3ZOsyGQKSxSU/+Ac=
=vy3I
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
