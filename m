Subject: Re: libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200601040559.04895.russell@coker.com.au>
References: <200601040559.04895.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 12:10:21 -0500
Message-Id: <1136481021.27632.444.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-04 at 05:58 +1100, Russell Coker wrote:
> policydb.c:2280: warning: 'last_block' may be used uninitialized in this
> function
> policydb.c:2289: warning: 'last_decl' may be used uninitialized in this
> function
> 
> It wasn't immediately clear to me what the correct solution to the above
> warnings is.

Per Joshua, we can just initialize these to NULL to silence the warnings
as they won't be used until after the first pass through has set them.

> In av_to_string() in assertion.c I added some code to handle the case of
> an error >1024 characters.  I don't think it's possible to have such a
> long error or likely to be possible in the future.  But I think it's
> best to have the code not crash on such a condition anyway.  I've made
> it just return nothing in the case of such an overflow, would truncation
> be better?

You weren't updating avlen; I fixed it.  I chose to have it return NULL
rather than an empty string; the error message will then be generated
with a "null" string in it, indicating that we ran out of space.

> In sepol_context_to_string() I fixed the error handling for the case
> where the overflow occurs by more than one byte.

Applied.

> In sepol_set_delusers() I initialised oldc to 0 to avoid a GCC warning.
> I checked the code and it seems that it performs correctly.

Doesn't seem necessary AFAICS, and this code is deprecated.  I've put in
comments into genusers.c and genbools.c bracketing the deprecated code
(all of genusers, and all of genbools except genbools_array used for
preservebools=1 upon policy reload).

> In hierarchy.c I fixed a couple of memory leaks and changed a comment to
> hopefully make it easier for others who work on this to avoid such
> leaks.  Also I changed the code in find_parent() to be a little more
> efficient.

Applied, with a bug fix to your patch.  *parent[len] doesn't do what you
think it does ;)

> In sepol_iface_modify() I renamed the variable "c" to "con".  I hate
> one-letter variable names because I can't easily search for them in my
> editor.  It turned out that a GCC warning was correct about that
> variable being possibly used without being initialised, so I initialise
> it to NULL and check it's value before freeing it's members.

Dropped, as I applied a fix for the real bug there based on Ivan's
observation, and don't care about short names.

> Also added some __fsetlocking() stuff.

Dropped, as the affected code is deprecated or test utility.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
