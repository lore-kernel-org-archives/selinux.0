Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8PGwa9W026363
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 12:58:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8PGvclS001701
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 16:57:38 GMT
Message-ID: <48DBC333.6060607@manicmethod.com>
Date: Thu, 25 Sep 2008 12:58:27 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Fwd: checkmodule: duplicate declaration of type/attribute problem
References: <cadfc0e40809250808q1dcfcd94n2c2fa496a485b790@mail.gmail.com>	 <48DBB1A2.7050908@manicmethod.com>	 <cadfc0e40809250845i61811d5cr889906c2bbec7186@mail.gmail.com> <cadfc0e40809250845k367c99e3q3f11e50cef7a9c22@mail.gmail.com>
In-Reply-To: <cadfc0e40809250845k367c99e3q3f11e50cef7a9c22@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> ---------- Forwarded message ----------
> From: Xavier Toth <txtoth@gmail.com>
> Date: Thu, Sep 25, 2008 at 10:45 AM
> Subject: Re: checkmodule: duplicate declaration of type/attribute problem
> To: Joshua Brindle <method@manicmethod.com>
> 
> 
> On Thu, Sep 25, 2008 at 10:43 AM, Joshua Brindle <method@manicmethod.com> wrote:
>> Xavier Toth wrote:
>>> The attribute in question is inside a gen_require of a template and I
>>> have looked at the tmp file to verify that there is only one
>>> declaration. Is this a misleading error message or a compiler bug? Any
>>> suggestions on how to deal with this problem?
>>>
>>> Ted
>> What version of checkpolicy and libsepol?
>>
> 
> [tedx@comms ConfigPolyDir]$ rpm -q checkpolicy
> checkpolicy-2.0.16-3.fc10.i386
> checkpolicy-2.0.16-3.fc9.x86_64
> [tedx@comms ConfigPolyDir]$ rpm -q libsepol
> libsepol-2.0.32-1.fc9.i386
> libsepol-2.0.32-1.fc9.x86_64
> 

Those are the newest so I'm not aware of a bug that would cause this. Can you send me a policy to reproduce it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
