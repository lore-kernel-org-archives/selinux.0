Message-ID: <4808E4D6.4040907@redhat.com>
Date: Fri, 18 Apr 2008 14:13:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: semanage man page updated for booleans
References: <47FB7A26.6020604@redhat.com> <1208529338.18883.480.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1208529338.18883.480.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2008-04-08 at 09:59 -0400, Daniel J Walsh wrote:
>> plain text document attachment (diff.part003)
>> --- nsapolicycoreutils/semanage/semanage.8	2008-04-08 09:37:21.000000000 -0400
>> +++ policycoreutils-2.0.46/semanage/semanage.8	2008-04-08 09:35:46.000000000 -0400
>> @@ -3,7 +3,9 @@
>>  semanage \- SELinux Policy Management tool
>>  
>>  .SH "SYNOPSIS"
>> -.B semanage {login|user|port|interface|fcontext|translation} \-l [\-n]
>> +.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] 
>> +.br
>> +.B semanage boolean \-{d|m} [\-T] boolean
> 
> Merged with some fixes (no -T, added --on/--off/-1/-0).
> 
> Also added a mention of the -C/--locallist option for only listing local
> settings.  And added error checking on the set_active() call.
> 
>>  .br
>>  .B semanage login \-{a|d|m} [\-sr] login_name
>>  .br
>> @@ -43,6 +45,9 @@
>>  .I                \-d, \-\-delete     
>>  Delete a OBJECT record NAME
>>  .TP
>> +.I                \-D, \-\-deleteall
>> +Remove all OBJECTS local customizations
I have an open bugreport where this actually crashes libsemanage, so I
will check when I work on the bug.
> 
> Does this actually yield the expected result for booleans?  IOW, if I
> delete all local customizations, does it also change the active boolean
> settings to the base policy values?  If not, then the user won't see the
> real effect until they next reboot since the kernel will keep preserving
> the active boolean settings across reload.
>  
>> +.TP
>>  .I                \-f, \-\-ftype
>>  File Type.   This is used with fcontext.
>>  Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgI5NYACgkQrlYvE4MpobOaxQCgprN/ncwNL+BzPbPOcyAmbozq
S+8AnRJWyOKRwjj1WKXr2WJ//yScZffJ
=N0ur
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
