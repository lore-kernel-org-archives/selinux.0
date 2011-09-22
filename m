Message-ID: <4E7B9B43.9000400@redhat.com>
Date: Thu, 22 Sep 2011 16:32:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
References: <4E7B9233.6080609@redhat.com> <1316723465.2354.6.camel@moss-pluto>
In-Reply-To: <1316723465.2354.6.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/22/2011 04:31 PM, Stephen Smalley wrote:
> On Thu, 2011-09-22 at 15:53 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Currently if I create a directory labeled
>> 
>> etc_t:s0:c1
>> 
>> And with a process running as unconfined_t:s0-s0:c0.c1023 create
>> a file within the directory, the file gets created with the
>> label etc_t:s0.   I would like to change the behavior to creating
>> the file as etc_t:s0:c1.
>> 
>> That way an administrator could modify files within a sandbox and
>> have the files be labeled correctly.
>> 
>> I believe this behavior differs from MLS but believe this would
>> be what the admin expects.
>> 
>> Is changing this a kernel or policy issue?
> 
> That would be a kernel change, and it would have to be configurable
> so that it can differ for MLS vs MCS.
> 
It would seem that we should be able to state the behaviour in policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk57m0MACgkQrlYvE4MpobNoxgCg5xkSZKYxe6hvi8FPv+b3Qbck
IF0AnjkjLW5A/Y7wcTEYaxTJQEcc8im7
=WxYt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
