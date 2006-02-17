Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HFAE3V021038
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:10:16 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HFABPl001067
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 15:10:11 GMT
Message-ID: <43F5E74C.7050904@gentoo.org>
Date: Fri, 17 Feb 2006 10:10:04 -0500
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chris PeBenito <pebenito@gentoo.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org> <43F5E618.4010001@cornell.edu>
In-Reply-To: <43F5E618.4010001@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>>> # semanage login -l
>>>>
>>>> Login Name                SELinux User              MLS/MCS Range
>>>>
>>>> root                      root                      __default__:user_u
> That doesn't look like a valid MLS range.
> What exactly is in your seusers file?
>>
>> #2  0x00476143 in sepol_mls_contains (handle=0x8b06b70, 
>> policydb=0x8b30a78, mls1=0x0, mls2=0x8b2fd98 "s0", response=0xbfdc7068)
> This indicates the seuser has an mls range s0, but the user does not. 
> The mls check is conditional on the seuser's mls range, which is why 
> it proceeds.  I can add a check that makes sure neither exists, but it 
> shouldn't be necessary - on a non-MLS system the seuser should not 
> have an mls range.
>
if it has s0 then semanage is dreaming it up because the policy has no 
mls whatsoever and none was specified on the command line.
> I'm not sure how a situation would occur where the seuser has an mls 
> range on a non-mls system. I guess seuser_print will write out an mls 
> field if it finds one, so maybe that's how this happens...it gets an 
> mls field from the policy package, and fails to ignore it. Need more 
> info.

what info? it isn't hard to reproduce.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
