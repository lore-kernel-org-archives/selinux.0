Subject: Re: [PATCH] file context sort in libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Ashworth <cashworth@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1144685935.32555.32.camel@popeye.columbia.tresys.com>
References: <1144685935.32555.32.camel@popeye.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 10:28:08 -0400
Message-Id: <1144765688.20422.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-04-10 at 12:18 -0400, Christopher Ashworth wrote:
> All,
> 
> Attached please find a patch to three files in libsemanage:
> direct_api.c, semanage_store.c, and semanage_store.h.  
> 
> This patch adds the ability to sort file contexts based on the same
> heuristics found in refpolicy/support/fc_sort.c   When linking multiple
> policy modules each module provides its own file contexts.  It is
> necessary to sort these contexts as a whole so that they can be applied
> correctly.
> 
> The sort is implemented as a stable merge sort (although it suffers from
> the limitations of our heuristics described recently on list).

- Do we truly want multiple structures and parsers for file contexts in
libsemanage (already have in src/fcontexts_record.c and
fcontexts_file.c)? 
- If this uses the same algorithm as fc_sort in refpolicy build, then
why does it yield a differently ordered file_contexts when running
semodule -b base.pp on the same base.pp file before and after applying
the patch to libsemanage?  Not clear as to whether it actually affects
the resulting labeling applied, but it does change the ordering of 236
entries.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
