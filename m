Message-ID: <5058A22E.7010407@redhat.com>
Date: Tue, 18 Sep 2012 12:32:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] selinux-testsuite:  Allow test domains to read /etc/passwd
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>  <5051FB6A.8040106@redhat.com> <20120915022200.GB6438@mail.hallyn.com> <1347975902.29192.17.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347975902.29192.17.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/18/2012 09:45 AM, Stephen Smalley wrote:
> On Sat, 2012-09-15 at 02:22 +0000, Serge E. Hallyn wrote:
>> Quoting Daniel J Walsh (dwalsh@redhat.com):
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>> 
>>> On 09/13/2012 10:08 AM, Stephen Smalley wrote:
>>>> Several test cases require the ability to read /etc/passwd to look
>>>> up usernames.  Recent Fedora introduced a separate type on
>>>> /etc/passwd and therefore we need to add an interface call to
>>>> test_global.te.  Fixes three test failures on Fedora 17.
>>>> 
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov> --- 
>>>> policy/test_global.te | 2 ++ 1 file changed, 2 insertions(+)
>>>> 
>>>> diff --git a/policy/test_global.te b/policy/test_global.te index 
>>>> 77121ae..fdfd291 100644 --- a/policy/test_global.te +++ 
>>>> b/policy/test_global.te @@ -88,3 +88,5 @@ 
>>>> selinux_compute_access_vector(testdomain) 
>>>> selinux_compute_create_context(testdomain) 
>>>> selinux_compute_relabel_context(testdomain) 
>>>> selinux_compute_user_contexts(testdomain) +
>>>> +auth_read_passwd(testdomain)
>>>> 
>>> Probably should use
>>> 
>>> auth_use_nsswitch(testdomain)
>>> 
>>> Since this will handle cases where users are listed in ldap or use
>>> sssd.
>> 
>> Stephen, would you like that instead?
> 
> No, it doesn't work - you cannot pass an attribute name to that interface.
> 

Ahh yes, you can not assign an attribute to an attribute.  That is right up
there with no assigning an attribute within a boolean as my least liked things
about our policy compiler.


I guess you need to add auth_use_nsswitch() for each type that gets set to
test_domain.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYoi4ACgkQrlYvE4MpobP60wCgl/6UDWf0MSTnjfr1psB6DsvB
hdIAoImqV09iWasmP1hnuNAiOl0Mf8O4
=lf6L
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
