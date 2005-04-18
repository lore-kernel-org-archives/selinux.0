Message-ID: <4263E641.9010100@kaigai.gr.jp>
Date: Tue, 19 Apr 2005 01:54:25 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
References: <4260B74B.3000002@kaigai.gr.jp>	 <1113666959.6081.25.camel@sgc.columbia.tresys.com>	 <42613C72.5060408@kaigai.gr.jp> <1113827271.28051.39.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1113827271.28051.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>>BTW, what archtectures are used and checked by SELinux's people ?
>>For example, kernel panic is occured on the 2.6.6 or former kernel for IA-64
>>when SELinux is enabled. This phenomenon have been overlooked.
>>
>>I can validate the evidence on IA64/i386 environment.
>>Is there a person who can try to run SELinux on infrequent(not i386) plathome?
>
>
> All of my machines are x86, so I'm afraid I can't be of much help there.

In Japan, Secure-OS such as SELinux is hoped for embedded computing field,
because applying the latest security patch for those application is not
as easy as one for our desktop PC.
So, I wonder who did evaluate the behavior on ARM/MIPS archtecture.

# This is NOT NEC's bussiness requirement, my personal interresting. :-)

Thanks,
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
