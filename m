Subject: Re: Performance issues - huge amount of AVC misses
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>,
 Milos Malik <mmalik@redhat.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <671085597.26020826.1449655668740.JavaMail.zimbra@redhat.com>
 <CAL8PO=1vpZ0=CL4LjpR8V4R2kpSsQ80dSUvSF74L=ct21UsKCA@mail.gmail.com>
 <CAL8PO=0jLoHuqwsTuEC8GHK-V_s0OHx+dTOBFy3uHmOJRSuk7A@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56684354.6000305@tycho.nsa.gov>
Date: Wed, 9 Dec 2015 10:05:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAL8PO=0jLoHuqwsTuEC8GHK-V_s0OHx+dTOBFy3uHmOJRSuk7A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/09/2015 08:15 AM, Michal Marciniszyn wrote:
> Hi,
>
> after increasing the cache, I do not see many reclaims, like couple of
> them here and there. The cache size had to be increased to 2048 to get
> ti this state.
>
> # avcstat 15
>
>      537645     537623         22         22         32         32
>      942916     942912          4          4          0          0
>      604466     604457          9          9          0          0
>      451737     451730          7          7         16         16
>      457669     457669          0          0          0          0
>      519135     519133          2          2          0          0
>      517288     517288          0          0          0          0
>      380376     380376          0          0          0          0
>      464272     464269          3          3          0          0
>      531484     531482          2          2          0          0
>     1422422    1422421          1          1          0          0
>     1380932    1380932          0          0          0          0
>      512999     512999          0          0          0          0
>
>
> Is it ok if I get longest chain length 13 in hash stats (It was higher
> in the beginning - 19, but got to 13 after 2 hours)?

I wouldn't worry about that; it's insignificant compared to the cost of 
an AVC miss.
