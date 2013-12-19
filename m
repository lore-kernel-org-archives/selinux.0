MIME-Version: 1.0
In-Reply-To: <52B21B8A.2030108@tycho.nsa.gov>
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
 <52B07D69.70209@tycho.nsa.gov>
 <CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>
 <52B094C0.7080107@tycho.nsa.gov>
 <CACVacMu4EvcdZzLVbBRFUvgg_RA0Mc7awZ0x_mzoxadmO6TSkw@mail.gmail.com>
 <CACVacMtV2+QbQiGvQRoDu3HaVd7p45BJFU01E7jKMdbJH06K1g@mail.gmail.com>
 <52B1E1AA.8090509@tycho.nsa.gov>
 <CACVacMssmARBBZEp_2GEnnKORu2tfdJMzMC2LjMZ8CuEcpKZEw@mail.gmail.com>
 <52B21B8A.2030108@tycho.nsa.gov>
Date: Wed, 18 Dec 2013 20:39:23 -0800
Message-ID: <CACVacMs8M7S83mq62Z00aMQjWf7XnQg0Q+eq7tWH7c3tw=3+Fw@mail.gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ah OK, nosuid was the answer. I did read this somewhere, but fell out of mind.

Thank you

On 12/18/13, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/18/2013 04:53 PM, Jay Corrales wrote:
>> On 12/18/13, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 12/18/2013 10:32 AM, Jay Corrales wrote:
>>>> Folks,
>>>>
>>>> We think we've run into a bug with rhel5. Could be that the policy
>>>> database contains corruption, or contains some data structures that
>>>> lead
>>>> to buggy results (e.g. AVC execute_no_trans). Is there a way to see
>>>> additional debug info in the LSM during run time? I've tried adding
>>>> "debug" to the boot time kernel parameters, but does not add any new
>>>> logging or reporting info for selinux.
>>>
>>> More likely just a bug in your policy.  I can't really tell though as
>>> you haven't shown an AVC that corresponds to the policy that you listed.
>>
>> We restored an image of our previous build and ran the policy. There
>> was no perm denied error. It ran perfectly. The difference in builds
>> represents an installer media and updated policies. leading me to
>> believe there is something fundamentally wrong with the installer
>> media producing a corrupted policy database.
>>
>> Is there a way to know why it is reporting an AVC for
>> execute_no_trans? The audit.log does not show enough info for this. We
>> were hoping for some way to look at the LSM, other than running an
>> embedded kernel and attaching gdb.
>
> nosuid mount would suppress the transition.
>
> Or maybe you don't have the type_transition rule in your policy at all?
>
>
>
