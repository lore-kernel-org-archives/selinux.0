Message-ID: <4315C560.6070100@trustedcs.com>
Date: Wed, 31 Aug 2005 09:57:36 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Another place where policy blows up because of translations in
 MCS.
References: <43148322.5030201@redhat.com>	 <1125418171.18888.138.camel@moss-spartans.epoch.ncsc.mil>	 <4314958B.5000602@redhat.com>	 <1125493031.18888.238.camel@moss-spartans.epoch.ncsc.mil>	 <1125497296.18888.287.camel@moss-spartans.epoch.ncsc.mil> <1125498135.18888.291.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1125498135.18888.291.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-08-31 at 10:08 -0400, Stephen Smalley wrote:
> 
>>Note that we wouldn't want to require setfiles to link against
>>libsetrans, as there is no upstream libsetrans and it is optional.
>>Hence, either setfiles would need to dlopen libsetrans in the same
>>manner as libselinux to access the translation functions or libselinux
>>needs to export wrapper functions for the translation functions it has
>>already looked up from libsetrans.  The latter seems simpler, but
>>requires that we add such functions to libselinux that are exported and
>>have proper namespace prefixes, unlike the hidden
>>trans_to_raw_context/raw_to_trans_context functions.  The exported
>>functions would also need to internally check the context_translations
>>flag unlike the current trans_to_raw_context/raw_to_trans_context
>>functions.
> 
> 
> See the attached patches for libselinux and setfiles.  Does this address
> the issue?  Is it the right approach (i.e. keeping libsepol
> translation-unaware and handling this in setfiles)?

This seems to be the proper approach.  We should keep the concept of
translated contexts at the higher levels (libselinux and applications) to
keep things as simple as possible.  The patches look good from here.  I
just wonder how I've never seen the problem.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
