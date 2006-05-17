Message-ID: <446B4D13.8080605@redhat.com>
Date: Wed, 17 May 2006 12:19:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Antill <james.antill@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <1147879972.3469.139.camel@code.and.org>
In-Reply-To: <1147879972.3469.139.camel@code.and.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
> On Wed, 2006-05-17 at 06:45 -0400, Daniel J Walsh wrote:
>   
>> Basically check if the previous lookup was the same context, if yes 
>> return the same translation.   Otherwise do the lookup.
>>     
>
>  Are we sure one is enough, lsof -Z does both s0 and s0-s0:c0.c255 and
> they are basically mixed (I appreciate it is much easier to code a cache
> of 1 than >1 though).
>
>  Also:
>
> +       } else {
> +               free(prev_t2r_trans);
> +               free(prev_t2r_raw);
> +               if (trans_to_raw_context(trans, rawp))
> +                       *rawp = strdup(trans);
> +               prev_t2r_trans=strdup(trans);
> +               prev_t2r_raw=strdup(*rawp);
>
> ...this is bad when trans_to_raw_context, the first strdup() fails or
> the last strdup() fails.
>
>   
Only reason strdup fails is ENOMEM.  With ENOMEM you are almost 
garanteed you are going to crash anyways.  gstrdup does a exit when it 
runs out of memory.
So we can messy up the code with a lot of checks that end up doing 
little.  Your choice.
>> Also included Russells patch for avcstat.
>>     
>
> -                       printf("%10u %10u %10u %10u %10u %10u\n",
> +                       printf("%10Lu %10Lu %10Lu %10Lu %10Lu %10Lu\n",
>
>  It's somewhat minor, but that should be %llu %Lu is a somewhat common
> extension. From man printf:
>
>        ll     (ell-ell).  A following integer conversion corresponds to a long
>               long int or unsigned long long int argument, or  a  following  n
>               conversion corresponds to a pointer to a long long int argument.
>
>        L      A following a, A, e, E, f, F, g, or G conversion corresponds  to
>               a long double argument.  (C99 allows %LF, but SUSv2 does not.)
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
