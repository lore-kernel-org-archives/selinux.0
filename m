Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <4263E641.9010100@kaigai.gr.jp>
References: <4260B74B.3000002@kaigai.gr.jp>
	 <1113666959.6081.25.camel@sgc.columbia.tresys.com>
	 <42613C72.5060408@kaigai.gr.jp>
	 <1113827271.28051.39.camel@moss-spartans.epoch.ncsc.mil>
	 <4263E641.9010100@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 13:14:06 -0400
Message-Id: <1113844446.28051.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-19 at 01:54 +0900, KaiGai Kohei wrote:
> In Japan, Secure-OS such as SELinux is hoped for embedded computing field,
> because applying the latest security patch for those application is not
> as easy as one for our desktop PC.
> So, I wonder who did evaluate the behavior on ARM/MIPS archtecture.

Earlier versions of SELinux were ported to ARM and successfully run on
the iPAQ by two independent efforts, but that was all prior to the 2.6
SELinux.  At this point, the largest challenge to SELinux there is
likely the fact that the 2.6 SELinux depends on extended attributes for
file security contexts, and jffs2 doesn't support them natively.  There
has been discussion of supporting extended attributes in jffs3, I
believe.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
