Subject: Re: Proposed change to install
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41D00FE7.2070203@redhat.com>
References: <41D00FE7.2070203@redhat.com>
Content-Type: text/plain
Message-Id: <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Dec 2004 09:33:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-27 at 08:36, Daniel J Walsh wrote:
> But with install, I believe 
> matchpathcon is required.  So I am have modified the patch in coreutils 
> to call matchpathcon and setfilecon.  This function currently will fail 
> silently, leaving the current behavior.  Do you think this should report 
> errors?

Likely not, if it is the default behavior, as the caller may not have
permission to relabel files at all or to the particular context. 
Definitely not for errno == EOPNOTSUPP, i.e. filesystems that do not
support the security xattr.

> I am not sure what we should do with the "preserve_context" field.  Also 
> it is questionable whether we should use setfscreatecon rather then 
> setfilecon.

You don't want to call your new function if the -P or -Z options were
specified, as your new function will clobber whatever context would have
been preserved by -P or set by -Z.  We definitely want to be able to
still use -P to explicitly request preservation of the original context
or -Z to explicitly request a particular context for the installed file.

Using setfscreatecon() prior to file creation would be preferable to
avoid any window where the file will be in wrong context, but may be
more difficult to integrate into install.

I believe that you don't need to check scontext for NULL if
matchpathcon() returns 0; matchpathcon() should never return 0 with a
NULL scontext unless I am missing something.

On a different note, should matchpathcon() be doing something different
in the <<none>> case rather than returning it to the caller, so that the
caller doesn't have to hardcode a check for it?  Possibly return -1 with
errno ENOENT as in the case where there is no matching entry in
file_contexts?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
