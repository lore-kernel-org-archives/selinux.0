Subject: Re: [PATCH] libselinux MLS range context contains for PAM/cron
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <jantill@redhat.com>, redhat-lspp <redhat-lspp@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163086651.12241.313.camel@moss-spartans.epoch.ncsc.mil>
References: <1162936676.26574.15.camel@code.and.org>
	 <1163086651.12241.313.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:49:29 -0500
Message-Id: <1163090969.18181.89.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-09 at 10:37 -0500, Stephen Smalley wrote:
> On Tue, 2006-11-07 at 16:57 -0500, James Antill wrote:
> >  Here is the libselinux changes needed to do the security context
> > contains checks for PAM and cron.
> 
> Index: libselinux/include/selinux/av_permissions.h
[cut]
> +#define CONTEXT__CONTAINS                         0x00000002UL
> Index: libselinux/src/av_perm_to_string.h
[cut]
> +    S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
> 
> This patch is obviously fine as long as the corresponding policy patch
> is accepted.

The policy patch is fine, I was just waiting for the code to be accepted
and committed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
