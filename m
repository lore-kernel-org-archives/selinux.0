Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OEoNOb007263
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 10:50:23 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OEcv88025676
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 14:38:57 GMT
Message-ID: <430C86AC.9000202@tresys.com>
Date: Wed, 24 Aug 2005 10:39:40 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com> <430B3049.5070402@redhat.com> <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil> <430B3C86.60802@redhat.com> <1124813721.7874.104.camel@moss-spartans.epoch.ncsc.mil> <430C8560.7090400@trustedcs.com>
In-Reply-To: <430C8560.7090400@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:

> Stephen Smalley wrote:
>
>>> I was thinking conflicting rpm packages.  So You can not install MCS 
>>> and MLS translation libaries at the same time.
>>
>>
>>
>> Hmmm...I recall that you didn't want to take that approach for multiple
>> policies, but in that case, you were providing multiple policies in the
>> distribution itself.  As long as you don't think you will ever need to
>> support multiple translation libraries in the base distribution, then
>> conflicting packages may be ok.  Darrel, what do you think?
>
>
> I personally like just managing the symlink /lib/libsetrans.so.0 to point
> to whatever translation lib should be used.  This allows for multiple
> variations to be installed.  As pointed out earlier, the alternatives
> system could be used here.  There should be no need to have more than one
> translation scheme installed on a running system, but it may prove easier
> to allow for that case.  I think the question comes down to what is 
> easier
> for installing a system such as RHEL that may support multiple schemes 
> such as MCS and MLS.  Installing multiple policy types and switching 
> between
> them is a nice feature.  If the policies would want differing translation
> schemes, I think it should be just as easy to switch - no rpm removal 
> and installation.
>
I don't know, it seems like you will potentially have a different 
translation lib for different policies. The policy knows which it wants 
(MCS knows it'll want libsetrans-mls.so or whatever). If you have an MCS 
and an MLS policy on the same system part of the conversion shouldn't be 
changing a symlink, that is fairly hacky. This sounds like a per policy 
configuration to me. That way custom translation libs can be installed 
with the policy and the policy will use it by default.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
