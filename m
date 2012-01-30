Message-ID: <4F26E23C.7080809@redhat.com>
Date: Mon, 30 Jan 2012 13:32:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: restorecon -R default
References: <201201290001.10792.russell@coker.com.au> <1327939865.23069.10.camel@moss-pluto>
In-Reply-To: <1327939865.23069.10.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/30/2012 11:11 AM, Stephen Smalley wrote:
> On Sun, 2012-01-29 at 00:01 +1100, Russell Coker wrote:
>> http://www.youtube.com/watch?v=ZThVfm3JXdM
>> 
>> A few years ago Paul Wayper gave an excellent introductory
>> lecture about SE Linux (see the above URL).  He notes that he
>> habitually uses -R for restorecon every time.
>> 
>> It seems to me that the case where -R is not desired will be
>> extremely rare. It seems most uncommon that someone will have a
>> directory with the wrong label, a subdirectory tree that is
>> either too big to scan quickly (and which is known to have the
>> correct labels) or which has labels which by design don't match
>> the file contexts.
>> 
>> Therefore I think we should make the common case be the default
>> and require that anyone who doesn't want that functionality
>> specifically request it. chcon uses the -h flag for changing the
>> context of a sym-link instead of the target, that might be a
>> reasonable option to use for consistency.
> 
> Seems like it might prove surprising to users, both given the
> prior default behavior of restorecon and the default behaviors of
> similar Unix commands like chown/chmod.  I don't think we
> can/should change it.
> 

I agree, we should not change it.  If a user wants to change the
default he can easily add

alias restorecon='restorecon -R'


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8m4jwACgkQrlYvE4MpobNnBACeK+GjXZMR8uiHfenHSfoq5rRZ
ONAAoKdkgR7Px7mvPwmiOrmK0W4R98DB
=6p5K
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
