Subject: Re: Proposed change to install
From: Karsten Wade <kwade@redhat.com>
Reply-To: kwade@redhat.com
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
References: <41D00FE7.2070203@redhat.com>
	 <1104158005.15615.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 07:13:47 -0800
Message-Id: <1104246827.4370.6.camel@erato.phig.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-27 at 09:33 -0500, Stephen Smalley wrote:
> On Mon, 2004-12-27 at 08:36, Daniel J Walsh wrote:
> > But with install, I believe 
> > matchpathcon is required.  So I am have modified the patch in coreutils 
> > to call matchpathcon and setfilecon.  This function currently will fail 
> > silently, leaving the current behavior.  Do you think this should report 
> > errors?
> 
> Likely not, if it is the default behavior, as the caller may not have
> permission to relabel files at all or to the particular context. 
> Definitely not for errno == EOPNOTSUPP, i.e. filesystems that do not
> support the security xattr.

OTOH, not having some error to work with makes it more difficult to
troubleshoot, in the case where labeling is desired but the user doesn't
have permission to label.  Something that conveys this:

"Error - labeling the file(s) foo, bar, baz failed.  Either SELinux is
not installed, is not an option, or you do not have permissions to
label.  If you think this is an error, contact your system
administrator."

- Karsten
-- 
Karsten Wade, RHCE, Sr. Tech Writer
a lemon is just a melon in disguise
http://people.redhat.com/kwade/
gpg fingerprint: 2680 DBFD D968 3141 0115  5F1B D992 0E06 AD0E 0C41


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
