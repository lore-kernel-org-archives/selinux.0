Subject: Re: Performance issues - huge amount of AVC misses
To: Joe Nall <joe@nall.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <671085597.26020826.1449655668740.JavaMail.zimbra@redhat.com>
 <CAL8PO=1vpZ0=CL4LjpR8V4R2kpSsQ80dSUvSF74L=ct21UsKCA@mail.gmail.com>
 <CAL8PO=0jLoHuqwsTuEC8GHK-V_s0OHx+dTOBFy3uHmOJRSuk7A@mail.gmail.com>
 <56684354.6000305@tycho.nsa.gov>
 <781F31F3-6348-48B0-861D-45CA6B4D4873@nall.com>
Cc: Michal Marciniszyn <michal.marciniszyn@gooddata.com>,
 Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56685FCA.3090107@tycho.nsa.gov>
Date: Wed, 9 Dec 2015 12:07:22 -0500
MIME-Version: 1.0
In-Reply-To: <781F31F3-6348-48B0-861D-45CA6B4D4873@nall.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/09/2015 11:07 AM, Joe Nall wrote:
> This thread motivated me to look at some test boxes. One is seeing about 2k misses per second under high load. Raising the cache_threshold to 1024 lowered that to 600 misses per second and raising it to 2048 lowered it to 0 with occasional bounces to 20-50.
>
> Are there any negatives to raising the cache_threshold?

Could waste memory and degrade the AVC hash chain lengths, but worth it 
if it makes AVC misses rare.

> What is the approximate cost of a miss?

On a miss, you're talking about a full security server access vector 
computation.  Cost will depend on your policy (number of rules, type 
attribute density, number and complexity of constraints) but with the 
SL6 policy stats he was showing I imagine it is quite high.

> Is there a persistent mechanism to set the cache_threshold? The system is RHEL 6.6 with custom MLS policy.

Not without patching your kernel.
Just write the value to selinuxfs from an init script or set it via 
tmpfiles.d if using systemd.
