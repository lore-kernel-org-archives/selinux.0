Subject: Re: Still getting random execute permissions on shared libraries.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41A3EC21.1090200@comcast.net>
References: <41A3EC21.1090200@comcast.net>
Content-Type: text/plain
Message-Id: <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 08:30:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-23 at 21:04, Daniel J Walsh wrote:
> Trying to run java from within firefox is a disaster, Mozilla crashes.
> 
> allow user_mozilla_t ld_so_cache_t:file execute;
> allow user_mozilla_t lib_t:file execute; (Jar files)
> allow user_mozilla_t user_tmp_t:file execute;
> allow user_t ld_so_cache_t:file execute;
> allow user_t locale_t:file execute;

They aren't random.  As discussed previously here and on
fedora-selinux-list, execution of a legacy binary causes the
read_implies_exec behavior to be enabled for the process, so that
subsequent read requests are transparently mapped to read|execute.  This
was a change in the upstream kernel, not SELinux, and was to allow
introduction of NX support without breaking compatibility with legacy
binaries.  SELinux is merely checking permissions based on the
information supplied by the core kernel.

Your options are:
- get java rebuilt with a PT_GNU_STACK header so the kernel doesn't
treat it as a legacy binary (assuming that it doesn't assume that read
implies exec),
- change policy to allow execute permission in these cases (although it
would be preferable here to move java into its own domain in that case,
so that you only have to allow it these permissions and not the entire
user domain or mozilla domain).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
