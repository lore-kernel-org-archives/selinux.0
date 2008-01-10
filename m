Message-ID: <478670A8.5080902@redhat.com>
Date: Thu, 10 Jan 2008 14:23:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com> <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2008-01-09 at 12:51 -0500, Todd Miller wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> I have a working demonstration of  My version of RBAC in Rawhide/FC8.
>>> In my view of the world, users have two roles.  User Role and Admin
>>> Role. 
>>>
>>> So I might login as a staff_t user and be able to transition to
>>> webadm_r:webadm_r.
>>>
>>> In Rawhide right now staff_t can only run sudo to become root.
>>> Staff_t is not allowed to execute su.  staff_t users should not know
>>> the root password. I have hacked up a script /usr/bin/webadm which
>>> executes newrole -r webadm_r -t webadm_t and newrole's pam has
>>> pam_rootok. 
>>>
>>> Now I edit the /etc/sudoers and allow
>>>
>>> dwalsh ALL=(ALL) /usr/bin/webadm
>>>
>>> This allows me to use sudo to become webadm_t as root.  (Policy
>>> obviously has to be correct.  But this is very cumbersome for the
>>> administrator and does not scale.
>>>
>>> I think we need to add SELinux support to sudo, so the administrator
>>> could easily add something to /etc/sodoers like
>>>
>>> dwalsh ALL=(ALL) ROLE=webadm_r TYPE=webadm_t /bin/sh
>>>
>>> then sudo would execute the code that newrole does to very the
>>> transition and
>>>
>>> setexeccon(dwalsh:webadm_t:webadm_t)
>>> exec(/bin/sh)
>>>
>>> I was told that you are the upstream maintainer of sudo, so I wanted
>>> your input/help on making sudo selinux aware.
>> I suppose it depends on what you really want to be able to do.  Do you
>>
>> a) wish to be able to run arbitrary commands via sudo but be able to
>>    specify a role and type ala newrole via -r and -t flags?
>>
>> or
>>
>> b) want to be able to force a command run by sudo to use a role and type
>>    that is specified in the sudoers file?
>>
I don't want the user to even know about webadm_r:webadm_t or care.  He
will just know that when he is UID 0 he can only use certain directories.

Allowing someone to specfify

sudo -r webadm_r -t webadmin_t /bin/sh

Is not important.

Having them say

sudo /bin/sh

and ending up with staff_u:webadm_r:webadm_t is important.

>> Doing a) is probably easier than b) though the two are not mutually
>> exclusive.
> 
> Didn't we used to have a) in Fedora (before Fedora 5, IIRC)?  And didn't
> it suffer from a number of problems?  Have to go back to the
> fedora-selinux archives and/or bugzillas to recapture the history there.
> 
> Also, while integration with sudo might be useful, it seems more
> pressing to integrate with policykit given its increasing adoption by
> distributions, right?
> 
No sudo and policykit serve two different problems.  I am looking for
sudo as a tool for use by actual administrators.  You need to get
something configured as the root user.  Currently you use su to do this.
And give out the root password.  With SELinux we can confine the user to
the particular files/processes that they can effect while running as the
root user.  The beauty of using SELinux in this manner is I can allow
the administrator to configure the system with tools like
vi/emacs/grep/cat/sed ...  While controlling which files he can modify
and which processes he can transition to (initscripts).

policykit needs policy to confine apps that are doing things on behalf
of the user.  So the user wants to change the clock.  Some how the user
authenticates himself the PolicyKit and the PolicyKit/Dbus executes
commands as root on behalf of the user.  The big caviat here is that we
need to make sure the tools ONLY do the things for the user that they
are defined to do.  So if the user is allowed to change the Time on his
machine, the script that runs on his behalf had better only be able to
change the time.

Whether or not SELinux gets involved in the authorization is up for debate.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeGcKgACgkQrlYvE4MpobP4BgCgw9H0QT/+1MkpIeDNPwrX1ITI
QWgAoOMR9omLPgmCkNP86Rt+wh0+F1fJ
=kCk7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
