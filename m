Subject: Re: patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <3FCAD897.9000104@diyab.net>
References: <3FCAD897.9000104@diyab.net>
Content-Type: text/plain
Message-Id: <1070289384.12270.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:36:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 00:58, Diyab wrote:
> Where can one locate the AT_SECURE patch for glibc?  AT_SECURE does not 
> exist in the current version of glibc, there is no patch in the  SE 
> Linux archives and the glibc source RPM from the fedora project contains 
> a patched glibc and not a seperate glibc and patch.

The change was upstreamed into the mainline glibc CVS tree in June.
http://sources.redhat.com/glibc/

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
