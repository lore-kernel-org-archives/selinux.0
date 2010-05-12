Message-ID: <4BEABBC8.3000009@gmail.com>
Date: Wed, 12 May 2010 07:31:36 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, refpolicy@oss1.tresys.com,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Labeling home directories in refpolicy
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95F@EUSAACMS0703.eamcs.ericsson.se> <1273673475.3738.21.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1273673475.3738.21.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/12/2010 07:11 AM, Stephen Smalley wrote:
> On Wed, 2010-05-12 at 10:04 -0400, Alan Rouse wrote:
>    
>> I'm trying to adapt a recent refpolicy snapshot (May 4) to OpenSUSE.
>> (Previously I adapted the Fedora 12 policy, more as a learning
>> exercise.)  Now I'm finding that the refpolicy is not labeling home
>> directories properly (they all end up as default_t after "fixfiles -F
>> relabel").   I'm running unprivileged users as user_u and root as
>> sysadm_u, so I expect corresponding labels on files in the home
>> directory.  Is there a special mechanism for getting the home dirs
>> labeled consistent with the corresponding selinux user, or do I need
>> to define labeling for the files individually in a new module?   And
>> how do files in the home dir such as .ssh (which should have a type
>> other than user_t) get their types?
>>
>> Or perhaps something is broken in the distribution that is causing
>> labels from the refpolicy not to be applied in the home dir?
>>
>> Any insights would be appreciated!
>>      
> Did you build with MONOLITHIC=n?
>
>    
I've noticed some funkyness with the home dir
labels as well i.g.
id -Z
name:staff_r:staff_t:s0
but the labels go
name name user_r:object_r:user_home_t:s0
if I add a new file the labels get set right
name name name:object_r:user_home_t:s0

maybe something is astray in genhomedircon!
(genhomedircon line#13)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
