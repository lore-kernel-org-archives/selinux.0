MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Fedora policies on Gentoo?
Date: Fri, 25 Feb 2005 11:00:52 -0600
Message-ID: <07C997312C46834CBC7C3B04A6FFABA406A5684E@wgiptcemx01.wgint.net>
From: "Simpson, Richard" <Richard.Simpson@wgint.com>
To: <bjorn.padding@ifsav.nl>, <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Hi,
>
>I was wondering... I am currently running on Gentoo.
>I see that there are way less existing policies on Gentoo than
>there are on Fedora. Can I unpunished cp these policies to my
>/etc/security/selinux/src/policy dir? The only consequence
>That I can think of is that I might have to change some
>./file_contexts/program/*.fc according to my Gentoo sys.
>But other than that it wouldn't create any problem, right?
>Somebody with some advice?

I have done that, but there are some caveats. The Gentoo policy tends to lag behind the Fedora implementation, and there are distro customizations. Best bet is to download the FC3 policy source rpm (strict, not targeted) so that you have a complete policy source to use for troubleshooting. I actually use a working installation of FC3 to compare against.

Richard.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
