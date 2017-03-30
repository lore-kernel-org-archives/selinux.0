Message-ID: <1490881474.18002.3.camel@tycho.nsa.gov>
Subject: Re: label for /proc directory (before mounting)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Date: Thu, 30 Mar 2017 09:44:34 -0400
In-Reply-To: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
References: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-03-29 at 17:00 -0400, Colin Walters wrote:
> Hi, see: https://github.com/ostreedev/ostree/pull/768
> 
> TL;DR: Policy (at least Fedora's version) does not specify
> a label for /proc on disk (as distinct from the `proc_t` from
> the genfscon).
> 
> This causes some breakage in rpm-ostree (which I can work
> around), but I'd like a better fix than what I did above.
> Any suggestions?  It probably doesn't
> matter too much what the actual type is since systemd will
> overmount it - should I make it the same type as e.g. `/mnt`?

You shouldn't hardcode security contexts, ever.  Why can't one just fix
the Fedora policy?  Do we still even need the <<none>> entries for
/proc in file_contexts in Fedora policy, given that restorecon is now
smart enough to skip any filesystem that lacks seclabel in
/proc/mounts? Android doesn't use <<none>> in its file_contexts at all.

As to what type it should have, I would try to keep it in whatever type
it is presently being assigned in Fedora during an install to avoid
breakage.  Not sure offhand what that is.

There is a more general problem here though, in that we don't presently
have an unambiguous way to specify a different security context for a
mountpoint directory vs a mounted directory in file_contexts.  That's
been previously noted as an issue in Android.  Probably requires some
new syntax in file_contexts to distinguish.
