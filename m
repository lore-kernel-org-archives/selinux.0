Subject: Re: matchpathcon regcomp return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Johan Fischer <jfischer@cmcrc.com>
Cc: SELinux-dev@tresys.com, "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux@tycho.nsa.gov
In-Reply-To: <43436F35.4040204@cmcrc.com>
References: <43436F35.4040204@cmcrc.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:19:39 -0400
Message-Id: <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 16:14 +1000, Johan Fischer wrote:
> Anyway, This configuration will not work as expected since the apache.fc
> file is concatened after the types.fc, the lost+found will get the
> httpd_sys_content_t type....

Yes, file contexts ordering/precedence is a known problem.  It is
exacerbated by the new policy module support, and Tresys has introduced
a sorting algorithm for their reference policy
(http://serefpolicy.sf.net) based on fixed string vs. regex (already
done by matchpathcon), stem length, string length, and presence of the
file type specifier.  Possibly we should incorporate that sort into
matchpathcon.  Chris, is there a reason you kept it as a separate helper
specific to reference policy versus submitting it as a patch to
matchpathcon itself?  I know that you mentioned that it does alter the
order in some cases from what we have now, but I think we agreed that we
can address those cases as needed.

> So I tried to use a bit of regex and set up a look ahead assertion to
> avoid the lost+found and use the following regex (tested with perl happily):
> 
> /var/lib/svn(?!(/.*)?/lost\\+found)(/.*)?
> 
> Now the problem is restorecon is crashing (segfault in matchpathcon)
> 
> About the crashing, it seems that the error code check of regcomp in
> matchpathcon.c is wrong (see attached patch from CVS HEAD).

Ah, thanks for the bug fix.  Should likely also call regerror there and
report that error string.

> The second question is actually, is lookaround supported at all in posix
> regex ?

I don't know offhand, but if regcomp rejects it, then I suspect not.
Possibly we could convert it over to using pcre.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
