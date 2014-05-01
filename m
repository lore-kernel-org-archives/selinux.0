Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41GtjUt013484
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 12:55:45 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so3637714iec.24
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 09:55:45 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.217])
 by mx.google.com with ESMTPSA id z4sm10269466igl.13.2014.05.01.09.55.43
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 01 May 2014 09:55:44 -0700 (PDT)
Message-ID: <53627BF2.6010301@gmail.com>
Date: Thu, 01 May 2014 22:23:06 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: AVC cache size unit?
References: <53620487.4080307@gmail.com>
 <CAB9W1A23sknsKqYZvs1RCcA-2uMvYr_pgVRStYm7Jbba9RGfrQ@mail.gmail.com>
In-Reply-To: <CAB9W1A23sknsKqYZvs1RCcA-2uMvYr_pgVRStYm7Jbba9RGfrQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/01/14 19:58, Stephen Smalley wrote:
> Number of entries.
>
> On Thu, May 1, 2014 at 1:23 AM, dE <de.techno@gmail.com> wrote:
>> What's the unit of the user configurable cache_threshold? It it some memory
>> size, or no. of entries etc...
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.

The reason why I asked is cause if you look at the avc stats, it shows 
values of a different magnitude. The frees are '6192' -- is this the no. 
of entires which are free or no. of free operations since boot up?
