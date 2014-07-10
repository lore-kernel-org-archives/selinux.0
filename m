Message-ID: <53BEA459.8060305@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 10:34:01 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com> <53BE9F2A.9050906@tycho.nsa.gov>
 <1405002183.661.17.camel@x220.localdomain> <53BEA25D.8090501@tycho.nsa.gov>
In-Reply-To: <53BEA25D.8090501@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 10:25 AM, Stephen Smalley wrote:
> On 07/10/2014 10:23 AM, Dominick Grift wrote:
>> On Thu, 2014-07-10 at 10:11 -0400, Stephen Smalley wrote:
>>
>>> Is the classorder bug?
>>> $ su <hangs forever>
>>> $ dmesg
>>>  systemd[1]: SELinux policy denies access.
>>>
>>
>> Is that with handle-unknown set to deny?
>>
>> if so then this is due to a missing av permission for the system class
>> in the fedora policy
>>
>> Else it may be indeed related to classorder but i think its the former
> 
> No, this is a stock system, so semanage.conf has the defaults, i.e. no
> expand-check and no handle-unknown.

Hmmm...but rebooting "cleared" it and now I can su without delay and no
systemd error message.

Merged #next to #integration locally to try to pick up the improved
error reporting on unknown class/perms but can't reproduce it now...
