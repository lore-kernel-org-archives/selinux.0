Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2NCQlOl013080
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 08:26:47 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2NCQg4x017149
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 12:26:47 GMT
Message-ID: <49C77FED.1000006@redhat.com>
Date: Mon, 23 Mar 2009 08:26:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: sixiaolin0 <sixiaolin067@126.com>
CC: Dominick Grift <domg472@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: installing setools errors
References: <22637000.476171237656620396.JavaMail.coremail@bj126app64.126.com> <1237659646.19699.57.camel@notebook1.grift.internal>
In-Reply-To: <1237659646.19699.57.camel@notebook1.grift.internal>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dominick Grift wrote:
> On Sun, 2009-03-22 at 01:30 +0800, sixiaolin0 wrote:
>>
>> I just insalled a FC10 in my Virtul Machine.
>> And when I try to install the setools,I encountered many problems
>> I try to solve them ,but this one is not do easy to solve.
>> Looking forward your help:
>> [hechao@localhost setools-3.3.5]$ ./configure
>> checking for a BSD-compatible install... /usr/bin/install -c
>>     .
>>     .
>>     .
>>     .
>> checking for Tcl configuration... configure: WARNING: Can't find Tcl
>> configuration definitions
>>  
>> I just didn't know how to solve the problem.
> 
> yum install setools
> 
> i do not see why you want to build your own setools. Fedora has it in
> its repositories. ready to use.
>  
>>
>>
>> ______________________________________________________________________
>> 网易邮箱，中国第一大电子邮件服务商
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
yum install tcl-devel will probably fix you ./configure problem, but I
agree with Dominick to just use the prebuilt package.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAknHf+0ACgkQrlYvE4MpobOF2ACgrQ7B6NYLto7nF+Ec1iBqlecG
3yAAniqyso/3ni+sLCM/NKZ+ckbXGlcq
=mUE9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
