Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8PFjwBS008839
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 11:45:58 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8PFjwPD028838
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 15:45:58 GMT
Received: by gxk5 with SMTP id 5so7344826gxk.18
        for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 08:45:58 -0700 (PDT)
Message-ID: <cadfc0e40809250845k367c99e3q3f11e50cef7a9c22@mail.gmail.com>
Date: Thu, 25 Sep 2008 10:45:57 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Fwd: checkmodule: duplicate declaration of type/attribute problem
In-Reply-To: <cadfc0e40809250845i61811d5cr889906c2bbec7186@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40809250808q1dcfcd94n2c2fa496a485b790@mail.gmail.com>
	 <48DBB1A2.7050908@manicmethod.com>
	 <cadfc0e40809250845i61811d5cr889906c2bbec7186@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---------- Forwarded message ----------
From: Xavier Toth <txtoth@gmail.com>
Date: Thu, Sep 25, 2008 at 10:45 AM
Subject: Re: checkmodule: duplicate declaration of type/attribute problem
To: Joshua Brindle <method@manicmethod.com>


On Thu, Sep 25, 2008 at 10:43 AM, Joshua Brindle <method@manicmethod.com> wrote:
> Xavier Toth wrote:
>> The attribute in question is inside a gen_require of a template and I
>> have looked at the tmp file to verify that there is only one
>> declaration. Is this a misleading error message or a compiler bug? Any
>> suggestions on how to deal with this problem?
>>
>> Ted
>
> What version of checkpolicy and libsepol?
>

[tedx@comms ConfigPolyDir]$ rpm -q checkpolicy
checkpolicy-2.0.16-3.fc10.i386
checkpolicy-2.0.16-3.fc9.x86_64
[tedx@comms ConfigPolyDir]$ rpm -q libsepol
libsepol-2.0.32-1.fc9.i386
libsepol-2.0.32-1.fc9.x86_64

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
