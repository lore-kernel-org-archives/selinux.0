Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1GGr8Rb010822
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 11:53:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1GGpclK004451
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 16:51:38 GMT
Received: from serve.wwwroot16.net (serve.wwwrot16.net [63.247.90.186] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id i1GGpNOX004436
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 16:51:38 GMT
Received: from pool-141-156-142-130.res.east.verizon.net ([141.156.142.130] helo=[10.0.1.2])
	by serve.wwwroot16.net with asmtp (Exim 4.24)
	id 1Aslyw-0007CX-C9
	for selinux@tycho.nsa.gov; Mon, 16 Feb 2004 11:52:30 -0500
Mime-Version: 1.0 (Apple Message framework v612)
To: selinux@tycho.nsa.gov
Message-Id: <815F59D7-60A0-11D8-97B0-00306555A856@cryptonomicon.net>
Content-Type: multipart/alternative; boundary=Apple-Mail-1--141098864
From: Matthew Hamrick <mhamrick@cryptonomicon.net>
Subject: SE/Linux Article on Cryptonomicon.Net
Date: Mon, 16 Feb 2004 11:52:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-1--141098864
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Thought the readers of this list might appreciate seeing this article 
that just appeared on our sister site, Cryptonomicon.Net. For the 
purposes of full-disclosure, we should mention we're SE/Linux fans here 
at Security Technique. One of our internal servers is a Debian box with 
SE/Linux patches applied.

http://www.cryptonomicon.net/modules.php?name=News&file=article&sid=673

-Matt Hamrick
-Editor, Security Technique

SE/Linux Goes Mainstream with Red Hat!

Security Enhanced Linux (SE/Linux), a series of kernel and user mode 
additions to the popular Linux operating system is finally getting it's 
day in the sun. The SE/Linux project's goal is to add "enhanced" 
security features including support for Multi-Level Security (MLS), 
Mandatory Access Control (MAC), and compartmentalized access to data. 
Not surprising considering the sponsor of the project is the secretive 
US National Security Agency.

SE/Linux has been available for download for several years, but until 
now there has been no "officially supported" Linux distribution that 
included SE/Linux enhancements. Lack of major distro support required 
individual users to download patches and integrate them into their own 
systems.

But now SE/Linux is getting it's day in the sun. Linux powerhouse Red 
Hat has announced that SE/Linux enhancements will be integrated into 
Red Hat Enterprise Linux 4.0, due to ship in 2005. Official support for 
the new security features will expand the user base beyond the research 
and hard-core security user community that currently use the system.

Users who can't wait that long may be able to get a peek in an upcoming 
Fedora release. Fedora is the project name for the "free" version of 
Red Hat's operating system, which is not officially supported by Red 
Hat.

SE/Linux is one of several enhanced security experiments, though it is 
becoming less accurate these days to term SE/Linux as an "experiment." 
Many of the ideas for SE/Linux originated in the Flask project from the 
early 90's. Flask was an attempt to create a secure kernel first for 
the Mach microkernel, and later for the Fluke microkernel. Commercial 
interest in Mach appeared to wane during the mid-90's as NeXT, a major 
commercial vendor of Mach-based systems, appeared to be concentrating 
on the web applications industry with the development of Web Objects. 
In the late 90's Apple Computer acquired NeXT and announced that future 
versions of MacOS would be based on Mach.

MacOS X is that system. Apple also chose to open the source to their 
base OS, thus creating Darwin. Shortly after the OpenDarwin project was 
announced, the Secure Trusted Operating System (Darwin) or STOSDarwin 
project went public with the stated goal of providing SE/Linux-like 
features for users of the Darwin operating system.

Any discussion of trusted open source operating systems would be 
incomplete without mention of Trusted BSD. This project is an outgrowth 
of the FreeBSD project, and offers many enhanced security features, 
including the ability to use SE/Linux security policy description 
files.

But not to be outdone by their open source counterparts, commercial OS 
vendors are staking their claim to customer "mind-share." Microsoft has 
been touting NGSCB (Next Generation Secure Computing Base), formerly 
known as Palladium, as a panacea for all information security woes. 
Preliminary information about the technology looks promising, but 
critical features such as key management have yet to be publicly 
disclosed. Critics of Microsoft's new system also mention it lacks the 
fine-grained control available to users of SE/Linux, STOSDarwin, or 
TrustedBSD. There is also some concern that Microsoft's focus on ease 
of use will trump certain security considerations. One security 
researcher interviewed for this article asked, "What good is all NGSCB 
if Outlook ships with defaults that make it a trusted application, and 
it trusts every virus-laden email that comes around?" Users will have 
to wait until Microsoft ships Longhorn to evaluate it's security 
features, but can download and install SE/Linux or TrustedBSD now.
--Apple-Mail-1--141098864
Content-Transfer-Encoding: 7bit
Content-Type: text/enriched;
	charset=US-ASCII

Thought the readers of this list might appreciate seeing this article
that just appeared on our sister site, Cryptonomicon.Net. For the
purposes of full-disclosure, we should mention we're SE/Linux fans
here at Security Technique. One of our internal servers is a Debian
box with SE/Linux patches applied.


http://www.cryptonomicon.net/modules.php?name=News&file=article&sid=673


-Matt Hamrick

-Editor, Security Technique


<bold><fontfamily><param>Tahoma</param><x-tad-smaller>SE/Linux Goes
Mainstream with Red Hat!


</x-tad-smaller></fontfamily></bold><x-tad-smaller>Security Enhanced
Linux (SE/Linux)</x-tad-smaller><x-tad-smaller>, a series of kernel
and user mode additions to the popular Linux operating system is
finally getting it's day in the sun. The SE/Linux project's goal is to
add "enhanced" security features including support for Multi-Level
Security (MLS), Mandatory Access Control (MAC), and compartmentalized
access to data. Not surprising considering the sponsor of the project
is the secretive US </x-tad-smaller><x-tad-smaller>National Security
Agency</x-tad-smaller><x-tad-smaller>.


SE/Linux has been available for download for several years, but until
now there has been no "officially supported" Linux distribution that
included SE/Linux enhancements. Lack of major distro support required
individual users to download patches and integrate them into their own
systems.


But now SE/Linux is getting it's day in the sun. Linux powerhouse
</x-tad-smaller><x-tad-smaller>Red Hat</x-tad-smaller><x-tad-smaller>
has announced that SE/Linux enhancements will be integrated into Red
Hat Enterprise Linux 4.0, due to ship in 2005. Official support for
the new security features will expand the user base beyond the
research and hard-core security user community that currently use the
system.


Users who can't wait that long may be able to get a peek in an
upcoming Fedora release. Fedora is the project name for the "free"
version of Red Hat's operating system, which is not officially
supported by Red Hat.


SE/Linux is one of several enhanced security experiments, though it is
becoming less accurate these days to term SE/Linux as an "experiment."
Many of the ideas for SE/Linux originated in the
</x-tad-smaller><x-tad-smaller>Flask</x-tad-smaller><x-tad-smaller>
project from the early 90's. Flask was an attempt to create a secure
kernel first for the Mach microkernel, and later for the Fluke
microkernel. Commercial interest in Mach appeared to wane during the
mid-90's as NeXT, a major commercial vendor of Mach-based systems,
appeared to be concentrating on the web applications industry with the
development of Web Objects. In the late 90's Apple Computer acquired
NeXT and announced that future versions of MacOS would be based on
Mach.


MacOS X is that system. Apple also chose to open the source to their
base OS, thus creating Darwin. Shortly after the
</x-tad-smaller><x-tad-smaller>OpenDarwin</x-tad-smaller><x-tad-smaller>
project was announced, the </x-tad-smaller><x-tad-smaller>Secure
Trusted Operating System (Darwin)</x-tad-smaller><x-tad-smaller> or
STOSDarwin project went public with the stated goal of providing
SE/Linux-like features for users of the Darwin operating system.


Any discussion of trusted open source operating systems would be
incomplete without mention of </x-tad-smaller><x-tad-smaller>Trusted
BSD</x-tad-smaller><x-tad-smaller>. This project is an outgrowth of
the FreeBSD project, and offers many enhanced security features,
including the ability to use SE/Linux security policy description
files.


But not to be outdone by their open source counterparts, commercial OS
vendors are staking their claim to customer "mind-share." Microsoft
has been touting </x-tad-smaller><x-tad-smaller>NGSCB (Next Generation
Secure Computing Base)</x-tad-smaller><x-tad-smaller>, formerly known
as Palladium, as a panacea for all information security woes.
Preliminary information about the technology looks promising, but
critical features such as key management have yet to be publicly
disclosed. Critics of Microsoft's new system also mention it lacks the
fine-grained control available to users of SE/Linux, STOSDarwin, or
TrustedBSD. There is also some concern that Microsoft's focus on ease
of use will trump certain security considerations. One security
researcher interviewed for this article asked, "What good is all NGSCB
if Outlook ships with defaults that make it a trusted application, and
it trusts every virus-laden email that comes around?" Users will have
to wait until Microsoft ships Longhorn to evaluate it's security
features, but can download and install SE/Linux or TrustedBSD now.</x-tad-smaller>
--Apple-Mail-1--141098864--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
