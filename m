Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OEgSOb007120
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 10:42:28 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OEW5Dh021849
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 14:32:06 GMT
Message-ID: <430C8560.7090400@trustedcs.com>
Date: Wed, 24 Aug 2005 09:34:08 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com>	 <430B3049.5070402@redhat.com>	 <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil>	 <430B3C86.60802@redhat.com> <1124813721.7874.104.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124813721.7874.104.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>>I was thinking conflicting rpm packages.  So You can not install MCS and 
>>MLS translation libaries at the same time.
> 
> 
> Hmmm...I recall that you didn't want to take that approach for multiple
> policies, but in that case, you were providing multiple policies in the
> distribution itself.  As long as you don't think you will ever need to
> support multiple translation libraries in the base distribution, then
> conflicting packages may be ok.  Darrel, what do you think?

I personally like just managing the symlink /lib/libsetrans.so.0 to point
to whatever translation lib should be used.  This allows for multiple
variations to be installed.  As pointed out earlier, the alternatives
system could be used here.  There should be no need to have more than one
translation scheme installed on a running system, but it may prove easier
to allow for that case.  I think the question comes down to what is easier
for installing a system such as RHEL that may support multiple schemes 
such as MCS and MLS.  Installing multiple policy types and switching between
them is a nice feature.  If the policies would want differing translation
schemes, I think it should be just as easy to switch - no rpm removal and 
installation.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
