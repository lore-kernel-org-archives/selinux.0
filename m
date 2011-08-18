Message-ID: <4E4CEC09.5020300@redhat.com>
Date: Thu, 18 Aug 2011 06:40:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: su vs runuser
References: <CAFPpqQEqJChweFaz-HyKVoUeBoL4ibER-dz=+p-FKYczyEFBKg@mail.gmail.com> <1313593741.28571.36.camel@moss-pluto>
In-Reply-To: <1313593741.28571.36.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/17/2011 11:09 AM, Stephen Smalley wrote:
> On Wed, 2011-08-17 at 09:30 -0500, Ted Toth wrote:
>> I've read that I should use runuser instead of su and I was having
>> a problem getting a script to transition properly until I changed
>> it to use runuser but I'm not clear on why this is. Can someone
>> help me with an elevator speech that I can use when trying to
>> explain this to others?
> 
> runuser runs in the same uid (i.e. it is not setuid-root) and
> security context as the caller - it isn't a trusted application.  It
> can only be used if the caller is already privileged.  It never
> requires authentication, and thus can be easily used in
> non-interactive scripts.
> 
> su is a setuid-root program that typically runs in a different
> security context than the caller so that it can read user
> authentication secrets (/etc/shadow) and switch identities even if
> the caller can't directly do so.  Early versions of Fedora/RHEL also
> put pam_selinux into /etc/pam.d/su, causing it to explicitly switch
> to the new user's security context, but that was later removed.  But
> even without that, there is a security context transition when you
> invoke su (to enter su's domain so that you can read /etc/shadow and
> switch uid) and when su invokes the user shell or command (to
> transition back to the original caller's domain).
> 

The actual first line of runuser.c is

#include "su.c"

So basically they are the exact same program, except, runuser has its
own version of the pam stack functions that just return success.

Bottom line.  runuser is su without the pam_stack, it does not try to
run anything that is in /etc/pam.d/su.

Pretty much you have to run runuser as root and really should be used in
init scripts.

If you don't need to use any of the functionality in the pam stack, use
runuser, if you need to user "setuid" privs and want stuff in the pam
stack to run use su.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5M7AkACgkQrlYvE4MpobMVQACfUXL2RVMSMtltRtHnMqsoUgN6
8TIAn3WfJJy7b4IxPoFU2jFffbcB1+3u
=1g8T
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
