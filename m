Subject: Re: [PATCH] ustr cleanups (policyrep branch)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1191221196.29631.44.camel@code.and.org>
References: <1191221196.29631.44.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:19:56 -0400
Message-Id: <1191593996.891.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-01 at 02:46 -0400, James Antill wrote:
> Here are two cleanups for ustr usage within libsemanage on the
> policyrep branch.
> 
>  The first is a corner case where you have two or more replacements in
> the "replace_all" function of genhomedircon, previously one of those
> multiple replacements (in theory) could fail due to malloc() returning
> NULL and that would be missed. The fix probably makes the free test more
> readable too.
> 
>  The second is that semanage_is_prefix() was previously defined by
> calling ustr functions (inefficiently, even), and so had to allocate a
> ustr to do it's work ... the fix just calls strncmp() directly.

Thanks, merged on trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
