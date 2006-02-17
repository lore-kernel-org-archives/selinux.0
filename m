Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HFSBor021751
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:28:11 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HFS8Pl005395
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 15:28:08 GMT
Message-ID: <43F5EB83.30402@gentoo.org>
Date: Fri, 17 Feb 2006 10:28:03 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org> <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org> <43F5E97B.8060102@cornell.edu>
In-Reply-To: <43F5E97B.8060102@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> what info? it isn't hard to reproduce.
> Contents of: users.local, seusers, and seusers.final
# cat /etc/selinux/test-nomcs/modules/active/seusers.final
root:root:
__default__:user_u:

no seusers file
no users.local

> I guess this function is exactly the place that should reject a seuser 
> with mls fields (or ignore them) based on whether mls is enabled in 
> the policy - I can export the mls flag from libsepol, and check that 
> (at this point we have a policydb, validation occurs after everything 
> is merged).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
