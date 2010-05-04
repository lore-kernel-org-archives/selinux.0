Message-ID: <4BE064F2.3060505@redhat.com>
Date: Tue, 04 May 2010 14:18:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@redhat.com>
Subject: Re: I am trying to build an MLS livecd.
References: <4BE04C8A.7070907@redhat.com> <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060802040505060704060905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060802040505060704060905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/04/2010 12:45 PM, Stephen Smalley wrote:
> On Tue, 2010-05-04 at 12:34 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> But for some reason.  Setfiles is not writing the correct labels to the
>> livecd, iff the label includes a range with a level not supported on the
>> host machine.
>>
>> grep s15 /tmp/mls.log
>> sbin/setfiles:  /home matched by
>> system_u:object_r:home_root_t:s0-s15:c0.c1023
>> /sbin/setfiles:  /home/liveadmin matched by
>> staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023
>> /sbin/setfiles:  /home/liveuser matched by
>> privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023
>>
>> When I boot the livecd these are all labeled as
>> unconfined_u:object_r:TYPE:s0.
>>
>> Any idea why this would happen?
>>
>> Of course these labels are invalid, so the MLS livecd is broken.
> 
> Does the same problem occur if the type is undefined in the host policy?
> IOW, is this a problem with undefined contexts in general or specific to
> the MLS field?
> 
> What output do you get if you run setfiles with -vv?
> 
> Could mcstransd be incorrectly mapping the range to s0?
> 


I attached the actuall output.  Problem is it takes 1/2 hour to get back
to this state.

mcstransd would not be running in the environment.  livecd has a hacked
out environment that thinks it is running SELinux in enforcing mode.

/selinux is a big hack and does nothing.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvgZPIACgkQrlYvE4MpobPlyACfc7WBoHliuHsT3TYU4rJ6Wetk
nigAoI7yzh37a0qEwr6+4PqbIeALO5Xw
=nYnC
-----END PGP SIGNATURE-----

--------------060802040505060704060905
Content-Type: text/plain;
 name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="out"

# file: home/
security.selinux="system_u:object_r:home_root_t:s0

# file: home/liveuser/
security.selinux="unconfined_u:object_r:user_home_dir_t:s0

# file: home/liveuser/
security.selinux="unconfined_u:object_r:user_home_dir_t:s0


--------------060802040505060704060905
Content-Type: application/pgp-signature;
 name="out.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="out.sig"

iEYEABECAAYFAkvgZPIACgkQrlYvE4MpobPraACfdI3OPzO1z75xMS0TYZ+AOvBjiTIAn2C9
IURBvq/yI8ZOFQbwjoFg7f2p
--------------060802040505060704060905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
