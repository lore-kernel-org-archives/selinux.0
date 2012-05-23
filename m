Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4NIk7oo001091
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2012 14:46:11 -0400
Message-ID: <4FBD306C.2000600@redhat.com>
Date: Wed, 23 May 2012 14:46:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: sepolgen requires unofficial setools patch
References: <20120521205849.GA8511@siphos.be> <4FBD064B.5040707@redhat.com> <4FBD1F48.7030707@tresys.com> <4FBD225F.8080708@redhat.com> <4FBD2C74.3000701@tresys.com>
In-Reply-To: <4FBD2C74.3000701@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/23/2012 02:29 PM, Christopher J. PeBenito wrote:
> On 05/23/12 13:46, Daniel J Walsh wrote:
>> On 05/23/2012 01:32 PM, Christopher J. PeBenito wrote:
>>> On 05/23/12 11:46, Daniel J Walsh wrote:
>>>> On 05/21/2012 04:58 PM, Sven Vermeulen wrote:
>>>>> Hi guys,
>>>> 
>>>>> It looks like the current stable sepolgen release has requirements 
>>>>> towards an unofficial (well, fedora/rhel only) patch on setools.
>>>>> With the current stable setools, it gives the following error when
>>>>> trying to use audit2allow on a denial that contains write & open:
>>>> 
>>>>> Traceback (most recent call last): File
>>>>> "/usr/bin/audit2allow-2.7", line 354, in <module> app.main() File
>>>>> "/usr/bin/audit2allow-2.7", line 345, in main self.__output() File
>>>>> "/usr/bin/audit2allow-2.7", line 315, in __output
>>>>> g.add_access(self.__avs) File 
>>>>> "/usr/lib64/python2.7/site-packages/sepolgen/policygen.py", line
>>>>> 211, in add_access self.__add_allow_rules(raw_allow) File 
>>>>> "/usr/lib64/python2.7/site-packages/sepolgen/policygen.py", line
>>>>> 179, in __add_allow_rules self.domains = seinfo(ATTRIBUTE, 
>>>>> name="domain")[0]["types"] NameError: global name 'seinfo' is not 
>>>>> defined
>>>> 
>>>>> The patch that RedHat (and Fedora) provides fixes this in Python 2
>>>>>  systems, but doesn't work in Python 3 (because Python 3 has a 
>>>>> different setup for Extension-based modules). I have a
>>>>> locally-tested patch on that, but I'm not sure this is a good way
>>>>> to go forward.
>>>> 
>>>>> Perhaps it would be wise to remove the dependency towards the
>>>>> setools binding and instead include the necessary code in the
>>>>> userspace libraries themselves? policygen.py doesn't require the
>>>>> entire set of querying that seinfo provides...
>>>> 
>>>>> The patch that is suggested by RedHat/Fedora doesn't follow the
>>>>> same structure as the other bindings do (like libqpol/libapol) in
>>>>> setools too.
>>>> 
>>>>> Wkr, Sven Vermeulen
>>>> 
>>>> Well I am not sure if anyone has ever used the setools python
>>>> binaries other then the setools/sesearch and seinfo bindings.
>>>> 
>>>> I would suggest we drop the general python bindings or deemphasize
>>>> them and work on improving the seinfo/sesearch bindings.
>> 
>>> I don't have a problem with a simpler api, e.g. a single function for
>>> rule searching, rather than the multiple calls to set up a query, but
>>> the current implementation in Fedora isn't acceptable to upstream
>>> setools. Perhaps what should be done is to add a basic query api to the
>>> SELinux userspace upstream, so that you can create all of these tools.
>>> Libqpol in setools tries to do this, but its implementation wouldn't be
>>> acceptable upstream.  Then the extra dependency of sepolgen on setools
>>> could be broken.
>> 
>> 
>> What is not acceptable, the entire idea of setools.sesearch and
>> setools.seinfo or something specific about the design?  Or do you want
>> setools to just be low level calls and want us to build a new package
>> that actualy does something useful with python?
>> 
>> IE Do you want us to just create a new tool called seanalyze or something
>> that includes the python bindings that we find useful.
> 
> Well its up to SELinux upstream to say if they'd accept a libsequery or
> libseanalyze or augment libsepol.  In the absence of that, the issue with
> what you have is the implementation.  The preference would be to add the
> new single function query API to libapol either in the C library sources or
> in pure python using the existing swig wrappers.  It would also have to be
> a complete API (i.e. apol could be converted to use it), which is more than
> sesearch and seinfo support.
> 
Sure and if they don't do stuff that is useful, then people will ignore
upstream and do what they want.  Implementing the C Api in python is useless.

I am not interested in reinventing sesearch and seinfo from base level
constructs in python.  I would just rather get the data into a dictionary and
then do what I want with it.

But if upstream is not interested in these tools then other downstreams loose out.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+9MGsACgkQrlYvE4MpobOttgCglTf4GVP6lSj7NgSyV+IvjjGN
b/IAnRFlQl6nzCQfScJ/x5Eh8JDKOPo/
=Mdq7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
