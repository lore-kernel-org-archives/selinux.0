Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41H8vDn014762
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 13:08:57 -0400
Received: by mail-qc0-f176.google.com with SMTP id x13so3588139qcv.21
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 10:08:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53627BF2.6010301@gmail.com>
References: <53620487.4080307@gmail.com>
 <CAB9W1A23sknsKqYZvs1RCcA-2uMvYr_pgVRStYm7Jbba9RGfrQ@mail.gmail.com>
 <53627BF2.6010301@gmail.com>
Date: Thu, 1 May 2014 10:08:58 -0700
Message-ID: <CAB9W1A2SS8zkz3sYoGoOL8jQc56EyObi1sTVdsKWErQXqF7ovg@mail.gmail.com>
Subject: Re: AVC cache size unit?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: dE <de.techno@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Operations since boot up.  Look at hash_stats if you want entry information.

On Thu, May 1, 2014 at 9:53 AM, dE <de.techno@gmail.com> wrote:
> On 05/01/14 19:58, Stephen Smalley wrote:
>>
>> Number of entries.
>>
>> On Thu, May 1, 2014 at 1:23 AM, dE <de.techno@gmail.com> wrote:
>>>
>>> What's the unit of the user configurable cache_threshold? It it some
>>> memory
>>> size, or no. of entries etc...
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>
>
> The reason why I asked is cause if you look at the avc stats, it shows
> values of a different magnitude. The frees are '6192' -- is this the no. of
> entires which are free or no. of free operations since boot up?
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
