Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NHXvgl025776
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 13:33:58 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NHXuZn002465
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 17:33:56 GMT
Message-ID: <4E7CC2FE.5060905@redhat.com>
Date: Fri, 23 Sep 2011 13:33:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
References: <4E7B9233.6080609@redhat.com>  <1316723465.2354.6.camel@moss-pluto>  <4E7B9B43.9000400@redhat.com>  <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>  <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto> <1316793989.12007.98.camel@vortex>
In-Reply-To: <1316793989.12007.98.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/23/2011 12:06 PM, Guido Trentalancia wrote:
> On Fri, 2011-09-23 at 11:07 -0400, Stephen Smalley wrote:
>> On Fri, 2011-09-23 at 11:01 -0400, Daniel J Walsh wrote:
>>>>>>>> Currently if I create a directory labeled
>>>>>>>> 
>>>>>>>> etc_t:s0:c1
>>>>>>>> 
>>>>>>>> And with a process running as
>>>>>>>> unconfined_t:s0-s0:c0.c1023 create a file within the
>>>>>>>> directory, the file gets created with the label
>>>>>>>> etc_t:s0.   I would like to change the behavior to
>>>>>>>> creating the file as etc_t:s0:c1.
>>>>>>>> 
>>>>>>>> That way an administrator could modify files within
>>>>>>>> a sandbox and have the files be labeled correctly.
>>>>>>>> 
>>>>>>>> I believe this behavior differs from MLS but believe
>>>>>>>> this would be what the admin expects.
>>>>>>>> 
>>>>>>>> Is changing this a kernel or policy issue?
>>>>>>> 
>>>>>>> That would be a kernel change, and it would have to be 
>>>>>>> configurable so that it can differ for MLS vs MCS.
>>>>>>> 
>>>>>> It would seem that we should be able to state the
>>>>>> behaviour in policy.
> 
> [cut]
> 
>> Need to distinguish low vs high.  In MLS, you want to inherit the
>> low level of the source/subject/process.
>> 
>> Also, do you want the MCS behavior for all types or selectively?
>> For example, if a svirt_t:s0:c256,c387 process creates a file in
>> a :s0 directory (is that even possible?), do you really want that
>> file to be :s0?
> 
> My opinion is: yes/NO.
> 
> So in other words, my opinion is that a categorized process should 
> always been allowed to write to an uncategorized directory. And
> then that the default label for anything created by a categorized
> process, should definitely be categorized.
> 
> However, there is an issue. For example, a given SELinux user might
> have access to more than one category. What would be the default
> category for labeling files produced by that user ?
> 
> Regards,
> 
> Guido
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

For MCS I would say the default is the process creates the file at the
level of the directory if it can, otherwise it gets permission denied.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk58wv4ACgkQrlYvE4MpobPOTACgrIceJ4NJd1+TKO7bARzngyUm
xj4AnjdOM6Gcc0g7BhvmxF2cEMDCGWH5
=M09/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
