Message-ID: <4F3D14B3.9090502@redhat.com>
Date: Thu, 16 Feb 2012 09:37:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Force avc_has_perm to return success if enforcing == 0;
References: <4F3AD084.5060304@redhat.com> <1329402340.25057.3.camel@moss-pluto>
In-Reply-To: <1329402340.25057.3.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/16/2012 09:25 AM, Stephen Smalley wrote:
> On Tue, 2012-02-14 at 16:22 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> I would like to patch libselinux to always return 0 on
>> avc_has_perm if the machine is in permissive mode.
>> 
>> This will allow Userspace Object Managers to work even if the
>> system is totally mislabeled and processes as running with bad
>> context. Currently if a program like dbus asks with a bad process
>> label it can get denials even in permissive mode.
>> 
>> Does anyone see a problem with this?
> 
> I'm not fond of it.  Permissive mode is just supposed to control
> whether permission is granted, not to hide other kinds of errors.
> Consider how difficult debugging of an actual failure will be if it
> only shows up in enforcing mode even though it has nothing to do
> with policy.
> 
Well I guess I can only due the return in the audit_has_perm not the
audit_has_perm_noaudit, since then the audit message will get
generated but dbus,passwd,xserver ... will allow the access.

If an app calls audit_has_perm_noaudit, it will still return failure.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk89FLMACgkQrlYvE4MpobNF/wCeP6Mu+zaa9AlNxFKnr20ClPaj
0kYAn243TIM6fcwHel6CdnfEDB3YXDeZ
=UnKT
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
