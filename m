Message-ID: <4BE06DED.4070801@redhat.com>
Date: Tue, 04 May 2010 14:56:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@redhat.com>
Subject: Re: I am trying to build an MLS livecd.
References: <4BE04C8A.7070907@redhat.com>	 <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>	 <4BE064F2.3060505@redhat.com> <1272998789.30175.170.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1272998789.30175.170.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/04/2010 02:46 PM, Stephen Smalley wrote:
> On Tue, 2010-05-04 at 14:18 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 05/04/2010 12:45 PM, Stephen Smalley wrote:
>>> On Tue, 2010-05-04 at 12:34 -0400, Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> But for some reason.  Setfiles is not writing the correct labels to the
>>>> livecd, iff the label includes a range with a level not supported on the
>>>> host machine.
>>>>
>>>> grep s15 /tmp/mls.log
>>>> sbin/setfiles:  /home matched by
>>>> system_u:object_r:home_root_t:s0-s15:c0.c1023
>>>> /sbin/setfiles:  /home/liveadmin matched by
>>>> staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023
>>>> /sbin/setfiles:  /home/liveuser matched by
>>>> privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023
>>>>
>>>> When I boot the livecd these are all labeled as
>>>> unconfined_u:object_r:TYPE:s0.
>>>>
>>>> Any idea why this would happen?
>>>>
>>>> Of course these labels are invalid, so the MLS livecd is broken.
>>>
>>> Does the same problem occur if the type is undefined in the host policy?
>>> IOW, is this a problem with undefined contexts in general or specific to
>>> the MLS field?
>>>
>>> What output do you get if you run setfiles with -vv?
>>>
>>> Could mcstransd be incorrectly mapping the range to s0?
>>>
>>
>>
>> I attached the actuall output.  Problem is it takes 1/2 hour to get back
>> to this state.
>>
>> mcstransd would not be running in the environment.  livecd has a hacked
>> out environment that thinks it is running SELinux in enforcing mode.
>>
>> /selinux is a big hack and does nothing.
> 
> BTW, can you or Eric describe exactly what that "hacked out environment"
> looks like and how the fake /selinux is set up?
> 
> It seems like we could make setfiles more directly support this kind of
> thing (via a new option) so that we don't need that fake environment at
> all.  It already uses its own SELINUX_CB_VALIDATE callback function, so
> we can easily turn off the canonicalization of contexts when it is being
> used on a foreign policy.
> 

I think most of the hacking is to allow tools like selinux-policy to
work correctly, without screwing up the hosts environment.

I have patches coming to fix semanage which expects booleans to exist
even if you have a different store.

I think all the changes are in
/usr/lib/python2.6/site-packages/imgcreate/creator.py

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvgbe0ACgkQrlYvE4MpobOm7ACfdFaPHpAA2eY3Y0pDgYarouMr
iVIAoKIx/vacz2KcL0EDQ54DoFn5WwRp
=PmTs
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
