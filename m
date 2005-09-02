Subject: Re: [RFC][PATCH] killall context regex and userid matching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ltcgcw@us.ibm.com
Cc: SELinux <SELinux@tycho.nsa.gov>, redhat-lspp <redhat-lspp@redhat.com>
In-Reply-To: <20050901185631.GA22593@us.ibm.com>
References: <20050901185631.GA22593@us.ibm.com>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 11:03:58 -0400
Message-Id: <1125673438.21817.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-01 at 13:56 -0500, ltcgcw@us.ibm.com wrote:
> Please find a patch to psmisc attached.  It adds these features to killall:
>   - regular expression SELinux context matching
>   - userid matching
>   - process names now optional when matching by either context or userid
>   - most fprintf() strings now gettext-ized
>   - help text no longer split up by #ifdef; missing newline added
>   - manpage updates
> 
> The patch applies to the psmisc CVS tree, current as of today.  I will
> submit it to the psmisc maintainer once I incorporate comments received on
> this list.  It might be useful to add something similar to skill and snice.

With regard to regex matching, one thing to watch out for is whether any
of the characters in a security context might have special meaning in a
regex.  For example, the extended syntax for MLS levels introduced by
TCS uses a dot (.) notation as a shorthand way of expressing category
sets with contiguous sets of categories, e.g. c0.c127.  Hence, 
	killall -Z :s0:c0.c3,c7
will match both :s0:c0,c3,c7 and :s0:c0.c3,c7 (i.e. :s0:c0,c1,c2,c3,c7).

You'd have to do something like:
	killall -Z ':s0:c0\.c3,c7'
to protect the dot from regex interpretation.

You may want to note this in the documentation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
