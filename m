Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4IIKJKP021341
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2012 14:20:21 -0400
Message-ID: <4FB692E3.9050704@tresys.com>
Date: Fri, 18 May 2012 14:20:19 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: <refpolicy@oss1.tresys.com>, SELinux-NSA <selinux@tycho.nsa.gov>
Subject: Re: [4/4] sepgsql -redefinition of use permission onto system objects
References: <CADyhKSXLR1rHgOd8Kfb3spNVWZ3Y5-mM9zYECWaC=ebmYvf-=w@mail.gmail.com> <CADyhKSUBg4nScZm+CDFX_hcRgbF-OG4y5NSbjk2NOsVK7LHneg@mail.gmail.com> <4FA3FAE4.8010803@tresys.com> <CADyhKSU41BXh9H7FA8WEbKBAX-j9iGpa80CwXWuWSf=ckaWhNg@mail.gmail.com> <4FABB8BF.2070201@tresys.com> <CADyhKSUNhZAbwKt+Qq7GJ2CxLs4dPqdDMEK666m4Gac_goejVw@mail.gmail.com>
In-Reply-To: <CADyhKSUNhZAbwKt+Qq7GJ2CxLs4dPqdDMEK666m4Gac_goejVw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/11/12 09:17, Kohei KaiGai wrote:
> 2012/5/10 Christopher J. PeBenito <cpebenito@tresys.com>:
>> On 05/04/12 13:24, Kohei KaiGai wrote:
>>> 2012/5/4 Christopher J. PeBenito <cpebenito@tresys.com>:
>>>> On 05/04/12 09:33, Kohei KaiGai wrote:
>>>>> The patch 3 of 4 also required the 4 of 4 being refreshed to apply correctly.
>>>>> In addition, I forgot to allow sepgsql_admin_type to allow to "use" system
>>>>> objects.
>>>>>
>>>>> Please check the newer version. Thanks,
>>>>
>>>> Looks like the revised patch is missing.
>>>>
>>> Sorry, it is the attached one.
>>>
>>> Thanks,
>>
>> This one doesn't apply, the last hunk fails.  I also had a problem with the 3rd patch, as the contrib hunk stopped it from applying too.
>>
> Sorry, I generated the series of patches based on the latest refpolicy and
> contrib tree.
> 
> And, I added "0of4" patch that fixes bugs in MLS/MCS that I noticed during
> regression test efforts. MCS rules are defined twice for db_language class
> in spite of db_schema being forgotten, and "entrypoint" permission was not
> restricted at both of MCS / MLS policy.
> 
> Here is no updates on part-1 ~ part-4 except for patch rebasing.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
