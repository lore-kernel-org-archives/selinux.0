Subject: Re: glibc check errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: "Kratzer, James R." <JamesK@xetron.com>,
   "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
In-Reply-To: <3F7A2810.1060907@diyab.net>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A41@s3cin>
	 <1064945244.6364.39.camel@moss-spartans.epoch.ncsc.mil>
	 <3F7A2810.1060907@diyab.net>
Content-Type: text/plain
Message-Id: <1065017784.350.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Oct 2003 10:16:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-30 at 21:04, Diyab wrote:
> So is this new glibc version available as the mainstream glibc package 
> or will non redhat users still have to apply the patch.  And if is or 
> will be soon available as mainstream glibc do you know what version?

The support for the AT_SECURE auxv entry was upstreamed into the
mainline glibc CVS tree back in June after the corresponding kernel
change was accepted by Linus into the mainline 2.5 (now 2.6) kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
