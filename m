Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1KHQYUs017807
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 12:26:34 -0500
Received: from authusersmtp.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1KHQVQp020555
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 17:26:31 GMT
Message-ID: <43F9FBC4.5040505@cornell.edu>
Date: Mon, 20 Feb 2006 12:26:28 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latesr diffs
References: <43F86FA2.8010505@redhat.com> <1140452650.30819.6.camel@sgc>
In-Reply-To: <1140452650.30819.6.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I put the implementation of the interface in a ifdef(`targeted_policy'
> since its not valid for strict.
>
> Dropped the semodule policy, see the semodule policy thread.
>
> The remainder should be merged.
>   
I wanted to comment on ... the nvidia drivers.

As a person that uses Nvidia drivers, I'd still argue that 
nvidia-related execstack things should have their own boolean that's 
disabled by default. Not everyone uses accelerated nvidia drivers, so 
not everyone would need this.

That said, I am not convinced that at the moment the Mesa drivers don't 
suffer from the same problem - I see the library is marked GNU_STACK 
RWE. I guess more testing is necessary with Mesa. All I can say at the 
moment is that I get { execstack execmem } and execute /dev/zero denials 
with the nvidia libGL.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
