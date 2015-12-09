Sender: Joe Nall <joenall@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Performance issues - huge amount of AVC misses
From: Joe Nall <joe@nall.com>
In-Reply-To: <56684354.6000305@tycho.nsa.gov>
Date: Wed, 9 Dec 2015 10:07:14 -0600
Cc: Michal Marciniszyn <michal.marciniszyn@gooddata.com>,
 Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
Message-Id: <781F31F3-6348-48B0-861D-45CA6B4D4873@nall.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <671085597.26020826.1449655668740.JavaMail.zimbra@redhat.com>
 <CAL8PO=1vpZ0=CL4LjpR8V4R2kpSsQ80dSUvSF74L=ct21UsKCA@mail.gmail.com>
 <CAL8PO=0jLoHuqwsTuEC8GHK-V_s0OHx+dTOBFy3uHmOJRSuk7A@mail.gmail.com>
 <56684354.6000305@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This thread motivated me to look at some test boxes. One is seeing about 2k misses per second under high load. Raising the cache_threshold to 1024 lowered that to 600 misses per second and raising it to 2048 lowered it to 0 with occasional bounces to 20-50.

Are there any negatives to raising the cache_threshold?

What is the approximate cost of a miss?

Is there a persistent mechanism to set the cache_threshold? The system is RHEL 6.6 with custom MLS policy.

joe


> On Dec 9, 2015, at 9:05 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 12/09/2015 08:15 AM, Michal Marciniszyn wrote:
>> Hi,
>> 
>> after increasing the cache, I do not see many reclaims, like couple of
>> them here and there. The cache size had to be increased to 2048 to get
>> ti this state.
>> 
>> # avcstat 15
>> 
>>     537645     537623         22         22         32         32
>>     942916     942912          4          4          0          0
>>     604466     604457          9          9          0          0
>>     451737     451730          7          7         16         16
>>     457669     457669          0          0          0          0
>>     519135     519133          2          2          0          0
>>     517288     517288          0          0          0          0
>>     380376     380376          0          0          0          0
>>     464272     464269          3          3          0          0
>>     531484     531482          2          2          0          0
>>    1422422    1422421          1          1          0          0
>>    1380932    1380932          0          0          0          0
>>     512999     512999          0          0          0          0
>> 
>> 
>> Is it ok if I get longest chain length 13 in hash stats (It was higher
>> in the beginning - 19, but got to 13 after 2 hours)?
> 
> I wouldn't worry about that; it's insignificant compared to the cost of an AVC miss.
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
