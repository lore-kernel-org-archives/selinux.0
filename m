Subject: Re: Second patch on systemd.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4C49A225.3000406@redhat.com>
References: <4C49A225.3000406@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 16:19:12 -0400
Message-ID: <1279916352.32473.29.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-07-23 at 10:07 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This one is intended to handle labeling of directories if they do not
> exist. As well as add use_selinux() function to determine is selinux is
> enabled, and not do stuff if it is disabled.

selabel_open(), selabel_lookup(), and selabel_close() are preferred to
using matchpathcon* in new code.  We'd like to deprecate and remove
matchpathcon*.

I'm not sure that we truly need to wrap all error handling with a check
of security_getenforce(), as that is only for dealing with permission
denials, not arbitrary errors that might occur (e.g. out of memory).  Or
if it is necessary, then I'd tend to take those code fragments
(use_selinux() check, call to libselinux function, check error, check
security_getenforce()) into wrapper functions so that you don't have to
spread them all around the systemd code and your insertions into the
systemd code can always just be a simple function call.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
