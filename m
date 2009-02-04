Message-ID: <4989C11E.8040109@redhat.com>
Date: Wed, 04 Feb 2009 11:23:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: odd policy behavior
References: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com>	 <1233679082.14235.21.camel@localhost.localdomain>	 <cadfc0e40902031159r55a12a02u46b0dde8f9356460@mail.gmail.com>	 <1233696489.14235.28.camel@localhost.localdomain>	 <cadfc0e40902031349w3c4d3abdgb5c7f5b5107a4001@mail.gmail.com>	 <cadfc0e40902031431w5532857fq2ecfd9485dfb26ee@mail.gmail.com> <1233755713.30244.7.camel@localhost.localdomain> <4989BE58.60408@redhat.com>
In-Reply-To: <4989BE58.60408@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> On Tue, 2009-02-03 at 16:31 -0600, Xavier Toth wrote:
>>> On Tue, Feb 3, 2009 at 3:49 PM, Xavier Toth <txtoth@gmail.com> wrote:
>>>> On Tue, Feb 3, 2009 at 3:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>> On Tue, 2009-02-03 at 13:59 -0600, Xavier Toth wrote:
>>>>>> On Tue, Feb 3, 2009 at 10:38 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>> On Tue, 2009-02-03 at 10:28 -0600, Xavier Toth wrote:
>>>>>>>> I have an app that wasn't working in enforcing but there are no AVCs.
>>>>>>>> So I did 'semodule -DB' to see if there were any dontaudit denials and
>>>>>>>> restarted the app. The problem is that the app then ran fine. So I
>>>>>>>> tried load_policy which had no affect and 'semodule -B' which makes it
>>>>>>>> work. Any ideas what could be happening? I've verified with 'semodule
>>>>>>>> --list' that the module is loaded prior to doing the 'semodule -B'.
>>>>>>> - How was the app failing?
>>>>>> This is our security banner app that draw a window across the top of
>>>>>> the screen with the users MLS range and with the appropriate
>>>>>> background color. When it fails there is just a window with a gray
>>>>>> background no text or color.
>>>>>>
>>>>>>> - Did you try running the app in permissive as well?
>>>>>>> - Is this reproducible at all or are you unable to reproduce the
>>>>>>> application failure now under any conditions?
>>>>>>> - Did the app create/use any transient resources (temporary files,
>>>>>>> system v ipc objects, etc) that could have prevented it from succeeding
>>>>>>> on subsequent execution if they weren't properly cleaned up on prior
>>>>>>> exit?
>>>>>> After further investigation I found that a call to getseuserbyname for
>>>>>> the login user is returning the user name passed in and nothing for
>>>>>> the range which would be used in the banner. During our installation
>>>>>> we don't explicitly map this user to a SELinux user but our experience
>>>>>> has been that the when there is no mapping the user and range of the
>>>>>> '__default__' login are returned. Indeed once I rebuild policy this
>>>>>> appears to be what is happening. How rebuilding and reloading policy
>>>>>> would affect this is unclear.
>>>>> If the installed seusers file (i.e. /etc/selinux/$SELINUXTYPE/seusers)
>>>>> did not exist originally or was unreadable (e.g. wrong context or mode),
>>>>> then getseuserbyname() would behave the way you described.  Rebuilding
>>>>> policy would have caused the regenerated seusers file to be installed,
>>>>> possibly with different context or mode than the original state.
>>>>>
>>>>> --
>>>>> Stephen Smalley
>>>>> National Security Agency
>>>>>
>>>>>
>>>> You nailed it for some reason seusers is SystemHigh. Still
>>>> investigating ... Thanks
>>>>
>>>> Ted
>>>>
>>> The plot thickens. semodule -B causes seusers to be relabeled
>>> SystemLow. restorecon /etc/selinux/mls/seusers causes the file to be
>>> relabeled SystemHigh. Which is right?
>> I don't think that semodule/libsemanage explicitly set the context of
>> files they create, so they would just follow the default policy behavior
>> (in this case, inheriting the level of the creating process and the type
>> of the parent directory).
> 
>> restorecon just applies whatever the file_contexts configuration
>> specifies, which appears to be SystemHigh in the mls policy.  I'm not
>> sure if that is truly justified.
> 
> Since all the login programs have to read this file it should be at the
> SystemLow, So that a login program running at a SystemLow can work.

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


If we conclude that this file(s) should be SystemHigh, then we need to
change semanage to use setfscreatecon, when creating these files.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmJwR0ACgkQrlYvE4MpobMKnQCeJbQO7RwtWlL6eFDByKnYWoh2
S0AAnA1cChgHe31C5j+9iD/2x9RQw2L+
=+pzu
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
