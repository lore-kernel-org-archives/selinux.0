Message-ID: <442FD7EA.7020003@kaigai.gr.jp>
Date: Sun, 02 Apr 2006 22:55:54 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: sds@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: MCS and unconfined_t
References: <442933AD.3040208@kaigai.gr.jp>	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>	 <1143649773.13732.30.camel@sgc.columbia.tresys.com>	 <1143650740.24555.5.camel@moss-spartans.epoch.ncsc.mil>	 <1143655164.13732.36.camel@sgc.columbia.tresys.com>	 <442B5714.9080100@kaigai.gr.jp> <1143721917.24555.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143721917.24555.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>It says an process can transit to more restricted categories only
>>by (h1 dom h2). I felt it's over restriction.
>>For example, a user login with 's0' cannot transit to any wider range
>>categories, even if he would be allowed to belong 's0-s0:c0.c2' at most.
>>
>>I modified my desktop environment (FC5). At a moment, the following
>>configuration seems to me working fine.
>>Do you think it's a reasonable solution ?
> 
> 
> The reason that we need the stronger restriction above is that there is
> not a one-to-one mapping from Linux users to SELinux users, and we are
> now relying on the seusers mapping and initial setup by login to bound
> what is reachable by a given Linux user.

Hmm... a one-to-one mapping between Linux users and SELinux users might
indeed cause managements nightmare.
Please forget my previous proposition.

Thanks Russell for providing modified RPM package. Now I'm using it with
a bit modification removing range_transition of su_exec_t.

By th way, do you think an additional mlsconstrain is necessary for
security : {load_policy setenforce setbool} ?
It also makes MCS invalid, I think.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
