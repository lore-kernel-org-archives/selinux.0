Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1K7V7jr008533
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 02:31:07 -0500
Received: from authusersmtp.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1K7V5Qp016912
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 07:31:05 GMT
Message-ID: <43F97034.7090707@cornell.edu>
Date: Mon, 20 Feb 2006 02:31:00 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: libselinux swig wrapper breakage
References: <1140408745.8756.31.camel@gorn.pebenito.net> <43F96E4E.6020704@cornell.edu>
In-Reply-To: <43F96E4E.6020704@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Traceback (most recent call last):
>>   File "<stdin>", line 1, in ?
>> TypeError: argument number 1: a 'security_context_t *' is expected, 
>> 'str(user_u:user_r:user_spamassassin_t)' is received
>>   
> You're passing a string into something that expects a security_context_t.
>
> That won't work - it fails, because security_context_t is an opaque 
> type, and swig has no idea that it represents a char*. It would know 
> that if selinux.h was included in the interface file. However, the 
> swig bindings for selinux take the approach of listing all the 
> functions manually (and omitting the public definition of 
> security_context_t as a char*).
Well, selinux.h is included in the bindings, but it isn't processed, 
which is what I meant...

%{ #include %} is an inline declaration at a particular section of the 
wrappers (I forget which one is default).
%include indicates the file should be processed by swig, and wrappers 
generated.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
