Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BKGt7J006009
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 16:16:55 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BKDCi2007243
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 20:13:12 GMT
Message-ID: <49B81C35.7040804@redhat.com>
Date: Wed, 11 Mar 2009 16:16:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Help with python seobject.loginRecords
References: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com> <49B8126B.9060501@redhat.com> <F1007BB4-8898-4A05-B09A-4FB1EF8519A2@nall.com>
In-Reply-To: <F1007BB4-8898-4A05-B09A-4FB1EF8519A2@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joe Nall wrote:
> 
> On Mar 11, 2009, at 2:35 PM, Daniel J Walsh wrote:
> 
>> On 03/11/2009 12:15 PM, Joe Nall wrote:
>>> I need to add login mappings in python firstboot modules during system
>>> configuration. In my first module a simple:
>>>
>>> seobject.loginRecords().add(username, "siterep_u",
>>> "SystemLow-SystemHigh")
>>>
>>> works. In subsequent modules, I get an exception:
>>>
>>> libsemanage.enter_rw: this operation requires a transaction
>>> libsemanage.enter_rw: could not enter read-write section
>>> Traceback (most recent call last):
>>> File "./t", line 6, in <module>
>>> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow-SystemHigh")
>>> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in add
>>> raise error
>>> ValueError: Could not add login mapping for test3
>>>
>>> What is the right way to do this?
>>>
>>> joe
>>>
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>> Probably an MLS issue.  firtstboot is running in a context that is not
>> allowed to lock/manage selinux.
> 
> I'm installing in permissive and switching to enforcing after firstboot.
> You are correct that firstboot_t doesn't have the policy for all the
> stuff I'm trying to do yet.
> 
>> You probably should exec semanage rather then calling seobject so you
>> could do a transition and not have to give a huge app like first boot
>> the ability to manage security policy.
> 
> That is what is installing right now. I would still like an
> explanation/code snippet of correct usage for future use
> 
> joe
> 
> 
Looks at system-config-selinux,  does it all over the place.

commands.getstatusoutput("semanage ...")

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkm4HDUACgkQrlYvE4MpobM7UwCfa63yef/yTXkqJXw5QqaygCfm
qMsAnix/6yGKm33Wq7ulyga6S3oaUvZh
=LQDc
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
