Subject: Re: patch: correct default policy type
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Timothy Wood <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <4152EA0A.9060606@diyab.net>
References: <4152EA0A.9060606@diyab.net>
Content-Type: text/plain
Message-Id: <1096904216.32008.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 11:36:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-23 at 11:21, Timothy Wood wrote:
> I've noticed that the release on the NSA site installs the policy into
> /etc/selinux/strict but libselinux looks for a targeted policy by
> default.  Attached patch changes the default in libselinux to be strict.
> ~ Please apply.

The original support for multiple policies came from the introduction of
the targeted policy in Fedora, and targeted policy is the default in
Fedora.  Changing the libselinux default to strict could have
implications for Fedora.  As long as /etc/selinux/config exists, is
readable and contains a SELINUXTYPE= entry, there would be no problem,
but I'm hesitant to make this change without further consideration. 
Note that the /etc/selinux/config file is created by the spec file.

I think I'd prefer to just make libselinux a bit smarter, e.g. if
/etc/selinux/config doesn't exist, we could probe for the existence of
strict or targeted subdirectories under /etc/selinux.  Of course, both
policies could be installed, in which case we would still need a default
choice.  And I think Russell's Debian setup just places the policy
directly under /etc/selinux without a separate subdirectory, so that
could be a problem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
