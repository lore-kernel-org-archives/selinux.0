Subject: Re: [PATCH 2/3] Refactor expander
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Jeremy A. Mowery" <jmowery@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1154962301.12897.99.camel@Bishop.columbia.tresys.com>
References: <1154962301.12897.99.camel@Bishop.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 11:18:39 -0400
Message-Id: <1154963919.26697.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-07 at 10:51 -0400, Jeremy A. Mowery wrote:
> (As per Karl's request, this is a resend of this patch set.)
> 
> The patch adds a new function called expand_module_avrules that creates
> an expand_state object and expands the avrules (including the
> neverallows).  This function permits external users of libsepol to
> expand the avrules into the same policy.  We refactored and created a
> static function called copy_and_expand_avrule_block since its
> functionality is needed in the original expand_module and the new
> expand_module_avrules functions.

I could be wrong, but I think Karl meant to merge up the corrected
return codes into the first patch and then re-post the patch series,
since patch 3 was essentially fixing a defect in patch 1, rather than
just posting an incremental patch separately.

Another point is that your patch splitting still isn't right; the goal
is to provide a compilable and working tree after each patch, and while
you fixed the compilation error, the toolchain won't work properly after
just patch 1 since that didn't include the necessary changes to clear
the neverallow flag in the expand states.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
