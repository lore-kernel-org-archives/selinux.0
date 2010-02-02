Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265120566.3003.5.camel@tesla.lan>
References: <1265120566.3003.5.camel@tesla.lan>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 11:44:34 -0500
Message-Id: <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 15:22 +0100, Guido Trentalancia wrote:
> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Mon Feb 02 14:23:05 2010 +0100
> 
>     Allow runtime switching between different policy types (e.g. from a MLS/MCS
>     policy to a non-MLS/non-MCS policy or viceversa).
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

Patch mangled by your mail client, probably because you signed it.
Read and follow the instructions in Documentation/email-clients.txt, or
switch to another client.  In the case of Evolution, for example, you
set the paragraph style to Preformat and then use Insert->Text File to
insert the patch into the message.  To test, email it to yourself, save
the email message and try applying it.

You want a "---" line before the diffstat output so that it doesn't get
included in the git log.

Did you give up on addressing the initial SID issue or are you saving
that for a later, separate patch?

Technically, security_mls_enabled() does not return True or False; it
returns 1 or 0.

Your if (args->oldp->mls_enabled...)else if...else block is hard to read
with the comment placement.  I'd move them within the conditional block
and use { } for all three clauses for ease of reading.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
