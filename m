Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8BGsspj025806
 for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2018 12:54:54 -0400
Received: by mail-oi0-f45.google.com with SMTP id t68-v6so48458476oie.12
 for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2018 09:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
From: Joshua Brindle <joshua.brindle@crunchydata.com>
Date: Tue, 11 Sep 2018 12:53:02 -0400
Message-ID: <CAGB+Vh5H1bu5vuPgfrj+YgbGGWegjnc4iskpuuHW6xgdWP5c5Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 10:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>
>> mcstrans mcscolor.c also uses the same logic I'd been using to check
>> dominance so this too will no longer function as expected on el7. Do you any
>> suggestions for doing a 'generic' (one not tied to a specific resource
>> class) dominance check in lieu of context contains?
>
>
> You should probably define your own permission with its own constraint to
> avoid depending on the base policy's particular constraint definitions.
> Certainly for your own code.  For mcstrans, mcscolor probably ought to be
> switched to using at least a separate permission in the context class if not
> its own class to avoid overloading the meaning with pam_selinux's usage (or
> vice versa, but likely harder to change pam_selinux at this point).
>

Isn't the actual question what the GLB of the 2 contexts is, rather
than what permissions one has on the other? It seems like a hack to
use permissions to figure out dominance.

Would a libselinux interface to determine glb and lub of 2 contexts
make sense? Or maybe add a default_range glb and lub option and then
calculate it using relabel?
