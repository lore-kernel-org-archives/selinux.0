Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <42613C72.5060408@kaigai.gr.jp>
References: <4260B74B.3000002@kaigai.gr.jp>
	 <1113666959.6081.25.camel@sgc.columbia.tresys.com>
	 <42613C72.5060408@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 08:27:51 -0400
Message-Id: <1113827271.28051.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-17 at 01:25 +0900, KaiGai Kohei wrote:
> Thanks for your solution.
> Indeed, we can solve this problem with appending a line into /etc/fstab
> or a command line option.
> 
> BTW, what archtectures are used and checked by SELinux's people ?
> For example, kernel panic is occured on the 2.6.6 or former kernel for IA-64
> when SELinux is enabled. This phenomenon have been overlooked.
> 
> I can validate the evidence on IA64/i386 environment.
> Is there a person who can try to run SELinux on infrequent(not i386) plathome?

All of my machines are x86, so I'm afraid I can't be of much help there.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
