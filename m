Subject: Re: [PATCH] wrappers for writing users and seusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1132763281.3714.3.camel@twoface.columbia.tresys.com>
References: <1132763281.3714.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:30:05 -0500
Message-Id: <1133206205.348.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-23 at 11:28 -0500, Joshua Brindle wrote:
> This patch adds wrappers necessary to write users and seusers using
> libsemanage. It also includes the wrappers for ports, but they are
> commented out since the port functions are not exported via
> libsemanage.map. Examples of how to write users and seusers (and tests)
> are in pywrap-test.py as usual. Let me know if there are any problems
> with this patch.

Merged as of libsemanage 1.3.57.  May conflict with a patch that seems
to be in the Fedora CVS.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
