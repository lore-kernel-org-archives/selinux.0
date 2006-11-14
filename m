Subject: Re: [PATCH] MLS context contains policy/libselinux changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Antill <james.antill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1162936296.26574.10.camel@code.and.org>
References: <1162936296.26574.10.camel@code.and.org>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 08:38:03 -0500
Message-Id: <1163511483.18181.125.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-07 at 16:51 -0500, James Antill wrote:
>  Here is the policy changes needed for the context contains security
> checking in PAM and cron.

Merged.  Added require block to userdomain change since context is a
userland object class and thus not automatically required by the
gen_require() macro.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
