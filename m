Message-ID: <47879D39.4000802@redhat.com>
Date: Fri, 11 Jan 2008 11:45:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Stefan Schulze Frielinghaus <stefan@seekline.net>,
        Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-01-11 at 10:32 -0500, Stephen Smalley wrote:
>> On Fri, 2008-01-11 at 09:37 -0500, Daniel J Walsh wrote:
> Stefan Schulze Frielinghaus wrote:
>>>>> On Thu, 2008-01-10 at 14:23 -0500, Daniel J Walsh wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>>
>>>>>> Stephen Smalley wrote:
>>>>>>> On Wed, 2008-01-09 at 12:51 -0500, Todd Miller wrote:
>>>>>>>> Daniel J Walsh wrote:
>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>>>> Hash: SHA1
>>>>>>>>>
>>>>>>>>> I have a working demonstration of  My version of RBAC in Rawhide/FC8.
>>>>>>>>> In my view of the world, users have two roles.  User Role and Admin
>>>>>>>>> Role. 
>>>>>>>>>
>>>>>>>>> So I might login as a staff_t user and be able to transition to
>>>>>>>>> webadm_r:webadm_r.
>>>>>>>>>
>>>>>>>>> In Rawhide right now staff_t can only run sudo to become root.
>>>>>>>>> Staff_t is not allowed to execute su.  staff_t users should not know
>>>>>>>>> the root password. I have hacked up a script /usr/bin/webadm which
>>>>>>>>> executes newrole -r webadm_r -t webadm_t and newrole's pam has
>>>>>>>>> pam_rootok. 
>>>>>>>>>
>>>>>>>>> Now I edit the /etc/sudoers and allow
>>>>>>>>>
>>>>>>>>> dwalsh ALL=(ALL) /usr/bin/webadm
>>>>>>>>>
>>>>>>>>> This allows me to use sudo to become webadm_t as root.  (Policy
>>>>>>>>> obviously has to be correct.  But this is very cumbersome for the
>>>>>>>>> administrator and does not scale.
>>>>>>>>>
>>>>>>>>> I think we need to add SELinux support to sudo, so the administrator
>>>>>>>>> could easily add something to /etc/sodoers like
>>>>>>>>>
>>>>>>>>> dwalsh ALL=(ALL) ROLE=webadm_r TYPE=webadm_t /bin/sh
>>>>>>>>>
>>>>>>>>> then sudo would execute the code that newrole does to very the
>>>>>>>>> transition and
>>>>>>>>>
>>>>>>>>> setexeccon(dwalsh:webadm_t:webadm_t)
>>>>>>>>> exec(/bin/sh)
>>>>>>>>>
>>>>>>>>> I was told that you are the upstream maintainer of sudo, so I wanted
>>>>>>>>> your input/help on making sudo selinux aware.
>>>>>>>> I suppose it depends on what you really want to be able to do.  Do you
>>>>>>>>
>>>>>>>> a) wish to be able to run arbitrary commands via sudo but be able to
>>>>>>>>    specify a role and type ala newrole via -r and -t flags?
>>>>>>>>
>>>>>>>> or
>>>>>>>>
>>>>>>>> b) want to be able to force a command run by sudo to use a role and type
>>>>>>>>    that is specified in the sudoers file?
>>>>>>>>
>>>>>> I don't want the user to even know about webadm_r:webadm_t or care.  He
>>>>>> will just know that when he is UID 0 he can only use certain directories.
>>>>>>
>>>>>> Allowing someone to specfify
>>>>>>
>>>>>> sudo -r webadm_r -t webadmin_t /bin/sh
>>>>>>
>>>>>> Is not important.
>>>>>>
>>>>>> Having them say
>>>>>>
>>>>>> sudo /bin/sh
>>>>>>
>>>>>> and ending up with staff_u:webadm_r:webadm_t is important.
>>>>> The idea with specifying the role and type at the sudo level is quiet
>>>>> good and important I think. Just imagine a scenario where you have one
>>>>> admin who takes care about the web-server and email-server. So you would
>>>>> have a webadmin_t and mailadmin_t type. If the admin wants to execute
>>>>> something like "sudo vim" (e.g. to change the config files) he would
>>>>> only have on role/type e.g. the webadmin_t but could _not_ change to
>>>>> mailadmin_t. You could easily fix this while creating a secondary Linux
>>>>> user to get around this but I think this wouldn't be nice and could
>>>>> possibly end up with dozens/hundreds/... of Linux user accounts (which
>>>>> are hard to manage, keep clean and isn't user friendly ...).
>>>>>
> Well this is actually what I would like to avoid.  I would prefer one
> domain that allows the administrator to admin both the httpd and mailman
> 
> I am adding to Fedora policy admin interfaces so you can easily creat an
> administrator policy that looks something like.
> 
> userdom_base_user_template(myadm)
> apache_admin(myadm_t)
> mailman_admin(myadm_t)
> mysql_admin(myadm_t)
> gen_require(`
>         type staff_t;
> ')
> allow staff_t webadm_t:process transition;
>>> You don't want staff_t to directly transition to webadm_t.  It should
>>> have to go through an intermediary, like newrole_t or sudo_t.
> 
>> Also, how are you handling the tty/pty and fd relationships (usually
>> addressed by newrole by relabeling the tty/pty and re-opening the fds
>> into its own type)?  That was a major problem with the old sudo selinux
>> patch.
I don't, Currently I am executing newrole in the shell script described
above.  I want to sudo to a handle all the transition/relabeling stuff.
The demo I have right now the user has to execute

sudo /usr/bin/webadm
/usr/bin/webadm looks like

#!/bin/sh
newrole -r webadm_r -t webadm_t

And I have to add pam_rootok to newroles pam or the user has to
continuously authenticate.
> 
> You load this policy module and create a staff user with the myadm_r,
> and now use sudo to get a shell that can manage mysql, mailman, and
> apache.  The user then does not need to think about, I am administrating
> the apache so I need to execute some bizare commands to become root, and
> then later that shell is no good for managing mailman or mysql.
> 
> 
>>>>>>>> Doing a) is probably easier than b) though the two are not mutually
>>>>>>>> exclusive.
>>>>>>> Didn't we used to have a) in Fedora (before Fedora 5, IIRC)?  And didn't
>>>>>>> it suffer from a number of problems?  Have to go back to the
>>>>>>> fedora-selinux archives and/or bugzillas to recapture the history there.
>>>>>>>
>>>>>>> Also, while integration with sudo might be useful, it seems more
>>>>>>> pressing to integrate with policykit given its increasing adoption by
>>>>>>> distributions, right?
>>>>>>>
>>>>>> No sudo and policykit serve two different problems.  I am looking for
>>>>>> sudo as a tool for use by actual administrators.  You need to get
>>>>>> something configured as the root user.  Currently you use su to do this.
>>>>>> And give out the root password.  With SELinux we can confine the user to
>>>>>> the particular files/processes that they can effect while running as the
>>>>>> root user.  The beauty of using SELinux in this manner is I can allow
>>>>>> the administrator to configure the system with tools like
>>>>>> vi/emacs/grep/cat/sed ...  While controlling which files he can modify
>>>>>> and which processes he can transition to (initscripts).
>>>>>>
>>>>>> policykit needs policy to confine apps that are doing things on behalf
>>>>>> of the user.  So the user wants to change the clock.  Some how the user
>>>>>> authenticates himself the PolicyKit and the PolicyKit/Dbus executes
>>>>>> commands as root on behalf of the user.  The big caviat here is that we
>>>>>> need to make sure the tools ONLY do the things for the user that they
>>>>>> are defined to do.  So if the user is allowed to change the Time on his
>>>>>> machine, the script that runs on his behalf had better only be able to
>>>>>> change the time.
>>>>>>
>>>>>> Whether or not SELinux gets involved in the authorization is up for debate.
>>>>> I would really appreciate something like this. It makes it very easy to
>>>>> allow only certain people to access/admin the stuff they need to. It is
>>>>> always good to know that an webserver-admin can only damage the
>>>>> webserver and not the whole system ;-)
>>>>>
>>>
- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeHnTkACgkQrlYvE4MpobOYHACg3d6EByKukZDtfn063OG4aXVT
JzwAoJQCyFi7M/KjmhOu3ID6iJanFiQh
=cfP1
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
