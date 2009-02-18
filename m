Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1IGvFoQ028442
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 11:57:15 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1IGrqxJ005896
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:53:52 GMT
Message-ID: <499C3DE1.70606@redhat.com>
Date: Wed, 18 Feb 2009 11:57:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Chris PeBenito <cpebenito@tresys.com>
Subject: Re: Patch to libsemanage to remove labeling of /root
References: <496C9A96.1080805@redhat.com> <499B1D53.4030602@manicmethod.com> <499B1EB7.40202@redhat.com> <499B1ECE.2040509@manicmethod.com> <499B2091.8000303@redhat.com> <499B20AA.8050902@manicmethod.com> <499B2956.6090104@redhat.com> <499C2D9F.4040806@manicmethod.com> <499C32C8.2020700@redhat.com> <499C3558.6090609@manicmethod.com>
In-Reply-To: <499C3558.6090609@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> Joshua Brindle wrote:
>>>>> Daniel J Walsh wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>>
>>>>>> Joshua Brindle wrote:
>>>>>>> Daniel J Walsh wrote:
>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>>> Hash: SHA1
>>>>>>>>
>>>>>>>> Joshua Brindle wrote:
>>>>>>>>> Daniel J Walsh wrote:
>>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>>>>> Hash: SHA1
>>>>>>>>>>
>>>>>>>>>> Policy should label /root with one label and this should not be
>>>>>>>>>> effected
>>>>>>>>>> by the passwd database.
>>>>>>>>>>
>>>>>>>>>> In Fedora policy we label this as admin_home_t.  Having this
>>>>>>>>>> label
>>>>>>>>>> vary
>>>>>>>>>> depending on policy ends up with lines like
>>>>>>>>>>
>>>>>>>>>> dontaudit * user_home_t:dir search_dir_perms
>>>>>>>>>> dontaudit * admin_home_t:dir search_dir_perms
>>>>>>>>>> dontaudit * sysadmin_home_t:dir search_dir_perms
>>>>>>>>>> dontaudit * staff_home_t:dir search_dir_perms
>>>>>>>>>>
>>>>>>>>>> Labeling this directory as user_home_t, opens the system to
>>>>>>>>>> possible
>>>>>>>>>> security risks since some domains have to be able to write to
>>>>>>>>>> user_home_t when they would never be allowed to write to
>>>>>>>>>> admin_home_t.
>>>>>>>>> The comment right above the added lines seems to indicate that was
>>>>>>>>> suppose to be root before, why is / excluded? Are we going to
>>>>>>>>> start a
>>>>>>>>> huge whitelist for genhomedircon?
>>>>>>>>>
>>>>>>>>>                 if (strcmp(pwent->pw_dir, "/") == 0) {
>>>>>>>>>                         /* don't relabel / genhomdircon checked
>>>>>>>>> to see
>>>>>>>>> if root
>>>>>>>>>                          * was the user and if so, set his home
>>>>>>>>> directory to
>>>>>>>>>                          * /root */
>>>>>>>>>                         continue;
>>>>>>>>>                 }
>>>>>>>> No just /root
>>>>>>>>
>>>>>>>> /root should not be labeled based on genhomedircon.
>>>>>>>>
>>>>>>> Why are the exact same lines there for "/" then?
>>>>>>>
>>>>>>>
>>>>>> Well I guess we do want to protect / and /root.
>>>>>>
>>>>>> Others should be fixed by looking at the parent, so if I added /var
>>>>>> as a
>>>>>> homedir it would blow up saying it conflicts with the previous
>>>>>> definition of /var.
>>>>>>
>>>>> I don't think I understand the problem we are trying to solve here...
>>>> Right now we do not know what /root is going to be labeled.
>>>>
>>>> Sometime it is labeled admin_home_t sometimes sysadm_home_dir_t other
>>>> times user_home_dir_t.
>>>>
>>>> I believe this is wrong.   It is not a "USER" home dir, it is something
>>>> far more special.
>>>>
>>>> Allowing it to be set by an application like genhomedircon, prevents us
>>>> from knowing what the label should be.
>>>>
>>> Chris and I talked about this and we both think the same thing,
>>> genhomedircon is not in the business of knowing who is and is not an
>>> administrative user, "special" user, etc. root _is_ a user, and on an
>>> SELinux system can be an unprivileged user.
>>>
>>> I think hardcoding in the library the specialness of /root is a bad
>>> idea, what if someone changes roots default role to user_r to make it
>>> unprivileged? They'd also need to change the file context entries
>>> explicitly with this patch rather than genhomedircon simply updating the
>>> entries.
>> The problem with treating /root as the same as every other homedir, is
>> confined daemons all consider /root their home dir, so they want to be
>> able to read/write contents in the homedir.  Lots of domains look at the
>>  homedir and or getstarted in the /root directory and end up causing an
>> AVC looking at the current working directory.  So we end up with a
>> dontaudit_search_admin_home_dir.  Which will not work if the context of
>> the homedir varies.
>>
> 
> I don't see where the source of the problem is coming in here. Is it
> because end users are changing the role of root and there are all of a
> sudden denials? If end users are changing roots role they probably would
> need to add some policy.
> 
>> Allowing user_r on the /root directory would be a bad idea since he
>> would be able to modify .bash_profile and other scripts that could
>> effect the way that a real admin works.
>>
> 
> There are legitimate use cases where root should be unprivileged
> (embedded systems, appliances, etc). We allow that flexibility and can't
> undermine it in a hard coded way in the library.
> 
>> So I will carry the patch and eventually would like to get rid of
> 
> I really don't think you should do this. My objections to merging it are
> rendered moot if the primary selinux distribution ships it anyway.
> 
>> genhomedircon all together an move to a mechanism where an admin can
>> specify where his homedirs are and where is altermate directories are.
>>
> 
> So why not add this feature now? A simple variable in semanage.conf
> should suffice.
> 
>> /home == /export/home
>>
>> Which would then duplicate all of the contexts prefixed with /home to
>> /export/home
>>
>> Similarly
>>
>> /var/www == /src/www
>>
>> This would give administrators greater flexibility and would get us out
>> of the business of guessing what a homedir, is.
>>
Case in point.

https://bugzilla.redhat.com/show_bug.cgi?id=486147

I have no way of dontauditing this if I allow the /root directory to
have flexible labeling.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmcPeAACgkQrlYvE4MpobOgkgCbBiOn25j+DTBf7COVswr/xJCU
QA8AoMrVox1fUyB728ARNhoCcUB2eyMA
=oZw7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
