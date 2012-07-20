Message-ID: <1342815462.1721.16.camel@moss-lions.epoch.ncsc.mil>
Subject: RE: Is the CIL project still active
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 20 Jul 2012 16:17:42 -0400
In-Reply-To: <33006C99F5A5194A9B7A7715DFA3E38365081B38@ALA-MBB.corp.ad.wrs.com>
References: <1342809547.74674.YahooMailClassic@web87706.mail.ir2.yahoo.com>
	 ,<1342811585.1721.5.camel@moss-lions.epoch.ncsc.mil>
	 <33006C99F5A5194A9B7A7715DFA3E38365081B38@ALA-MBB.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-20 at 19:54 +0000, Radzykewycz, T (Radzy) wrote:
> Can someone provide a reference for those of us who don't already know and find the google search results unsatisfying?
> 
CIL (Common Intermediate Language) is an effort to recreate the policy
toolchain to provide better support for higher-level languages and
better support for policy customization.

Wiki:
http://userspace.selinuxproject.org/trac/wiki/CilDesign

Previous release:
http://marc.info/?l=selinux&m=132199954507072&w=2

After we made the previous release, a major bug was found in how CIL
handled macro definitions that contain multiple calls of a macro
containing a declaration. That bug has been fixed. But as I mentioned in
the previous email there are still a couple of issues that need to be
dealt with before another release is made.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
