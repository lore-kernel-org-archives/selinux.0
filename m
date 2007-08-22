Message-ID: <46CC68D4.3070001@redhat.com>
Date: Wed, 22 Aug 2007 12:48:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
Subject: Re: Question concerning building policy modules
References: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>	 <46CB51E8.5020603@redhat.com> <1187800281.20340.34.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1187800281.20340.34.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Carter wrote:
> On Tue, 2007-08-21 at 16:58 -0400, Daniel J Walsh wrote:
>> James Carter wrote:
>>> Why isn't the Makefile and other information needed to build a module
>>> separately in the appropriate /usr/share/selinux/<policy name>
>>> directory?  This seems like the logical place for that information.  The
>>> (not very well documented) "install-headers" make target in the
>>> refpolicy Makefile does this.
>>>
>>> Instead, the information to build a module for Fedora is in
>>> the /usr/share/selinux/devel directory.  This directory would seem to be
>>> independent of the policy type, even though it is only for building
>>> Fedora policies.  This seems confusing.  The devel directory should have
>>> stuff that all policies need or could use.
>>>
>>> Wouldn't it make sense that if I wanted to build a module for the
>>> current policy, I would use the Makefile in devel which would look
>>> at /etc/selinux/config and include the Makefile for the current policy,
>>> but if I wanted to compile for a particular policy, I would just use the
>>> Makefile in its /usr/share directory?
>>>
>>>   
>> This is an old argument, between strict and targeted policy.   I did not 
>> like the idea of building
>> policy modules different for each type of policy,  Since almost everyone 
>> is exactly the same or would not work on different policies.  This seems 
>> to be proven to be correct as we move to strict/targeted policy merge. 
>>
>> So you add a level of complexity with very little value.  Just imagine a 
>> third party shipping multiple policies for the
>> same package depending on an infinite number of policy packages.
>>
>> targeted, strict, mls, olpc, CDS-ABC.
>>
>> And almost guaranteed the same policy package would work for all or the 
>> package will only really work on one (MLS).  So I went with the least 
>> common denominator and only ship one devel package.  All interfaces for 
>> all packages ship. 
> 
> On a different note, what is the policy going to be called when the
> difference between strict and targeted is only whether a certain module
> is loaded or not?  Will there only be one policy package?  Or maybe
> there will be policy-mcs and policy-mls packages?
> 
> 
We will be shipping just targeted policy and allow you to define any
types of users you want.  Removing the unconfined.pp file will remove
all of the unconfined domains.  As an alternative, you can change the
__default__ to a confined user type and then not allow users to login as
unconfined users.  (I find this much more interesting.)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGzGjTrlYvE4MpobMRAkheAJ42YAU7SKF5ccxjdUhzabuVUMxLCQCghnTh
KvV/O9iy3+weMs9qKGQptqk=
=h0GG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
