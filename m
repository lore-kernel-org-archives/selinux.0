Subject: Re: glibc check errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A40@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A40@s3cin>
Content-Type: text/plain
Message-Id: <1064939219.6364.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Sep 2003 12:26:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-30 at 11:34, Kratzer, James R. wrote:
> I have built the glibc library with the SELinux patches.  When running "make
> check", I get the following errors.  Any ideas what is going on here and how
> I can resolve it because I'm at a loss?  Thanks for any help.
> 
> /bin/sh -e tst-gettext.sh /usr/src/redhat/BUILD/glibc-2.3.2-build/
> /usr/src/redhat/BUILD/glibc-2.3.2-build/intl/ \
> 	/usr/src/redhat/BUILD/glibc-2.3.2-build/intl/tst-gettext.mtrace
> make[2]: *** [/usr/src/redhat/BUILD/glibc-2.3.2-build/intl/tst-gettext.out]
> Error 1
> make[2]: Leaving directory
> '/usr/src/redhat/BUILD/glibc-2.3.2-200304020432/intl'
> make[1]: *** [intl/tests] Error 2

We expect to make an updated release soon, so you may want to wait for
it.  We are no longer including a patched glibc, because the change
(which wasn't specific to SELinux) has been upstreamed and is available
in newer glibc packages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
