From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov" <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: [PATCH] libselinux: clean up process file
Date: Fri, 2 Sep 2016 17:34:18 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560128E4B2@ORSMSX103.amr.corp.intel.com>
References: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
 <cb39b15c-71a2-82eb-e9cf-bf296d6ff554@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> since M, I think it makes sense to have this in the following order:
> 1. patch to only open the file once
> 2. patch to switch to stdio fmemopen

Actually looking at this, it would be write it once for item 1, then discard that as
Most of it would change for item two. So I see no value in splitting this up.
I think we just implement item 2 and as a sideffect it won't open the file up
multiple times.

<snip>
