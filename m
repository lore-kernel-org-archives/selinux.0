Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3C9gtSp010692
 for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2014 05:42:55 -0400
References: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
 <534580B3.8040704@quarksecurity.com>
Message-ID: <1397295773.56559.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Date: Sat, 12 Apr 2014 10:42:53 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy
 features
To: Joshua Brindle <brindle@quarksecurity.com>
In-Reply-To: <534580B3.8040704@quarksecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "setools-bugs@tresys.com" <setools-bugs@tresys.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hope the patches are useful. I'm now attempting to produce a patch to support the
APOL source policy tab to version 29 - but I may be some time.




----- Original Message -----
From: Joshua Brindle <brindle@quarksecurity.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov; setools-bugs@tresys.com
Sent: Wednesday, 9 April 2014, 18:17
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy features

Richard Haines wrote:
> These four patches will update setools-3.3.8.tar.bz2 available from
> http://oss.tresys.com/projects/setools/wiki/download
> 
> I know this is not being fully supported but as I use APOL frequently
> I thought I would update it to support the latest policy version 29 (I
> could be the only user!!!). Tested on latest Fedora 20 x86_64
> 

We use it quite a bit too so thank you very much.

Since we wanted to try out the patches, and because of my disdain for subversion I put up an (unofficial) git mirror that includes your patches on github at:

https://github.com/QuarkSecurity/setools

And to make it easier for others to try them out we posted some rpms:

https://quarksecurity.com/files/RPMS/

Oh, your ChangeLog change had to be rebased, as SVN trunk had an additional comment. I also fixed it to be tabs since that is the standard for that file.

Thanks!
