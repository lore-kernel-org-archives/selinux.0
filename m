Subject: RE: glibc check errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A41@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A41@s3cin>
Content-Type: text/plain
Message-Id: <1064945244.6364.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Sep 2003 14:07:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-30 at 13:30, Kratzer, James R. wrote:
> I am running the new 2.4 based SELinux kernel and userland archive on Red
> Hat 9.  If I understand you correctly, since the glibc changes have been
> upstreamed and were not SELinux specific, you will be releasing soon a new
> userland archive which will require an updated version of the glibc package.  
> If this is correct, how soon do you anticipate the release of the new
> userland archive and the release of the new glibc package ( glibc-2.3.3
> maybe? )?  Can I use the current userland archive utilities without the
> patched glibc?

You don't need the modified glibc to use the userland archive
utilities.  The glibc patch was to make glibc recognize security
transitions other than just setuid/setgid, so that it will enable its
secure mode for programs that cause a change in other security
attributes (e.g. role/domain) as well as for setuid/setgid programs. 
That is important for security, but not a functional requirement for
using the system.  The modification to glibc has made its way upstream
and I believe that it is available in the RedHat beta (severn / fedora
core).

We'll be making an updated release of the kernel and userland archives
soon, likely later this week.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
