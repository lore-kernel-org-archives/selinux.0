From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov" <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: [PATCH] libselinux: clean up process file
Date: Fri, 2 Sep 2016 18:35:29 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560128E4DF@ORSMSX103.amr.corp.intel.com>
References: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
 <cb39b15c-71a2-82eb-e9cf-bf296d6ff554@tycho.nsa.gov>  
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Roberts, William C
> Sent: Friday, September 2, 2016 10:34 AM
> To: 'Stephen Smalley' <sds@tycho.nsa.gov>; 'selinux@tycho.nsa.gov'
> <selinux@tycho.nsa.gov>; 'jwcart2@tycho.nsa.gov' <jwcart2@tycho.nsa.gov>;
> 'seandroid-list@tycho.nsa.gov' <seandroid-list@tycho.nsa.gov>
> Subject: RE: [PATCH] libselinux: clean up process file
> 
> <snip>
> > since M, I think it makes sense to have this in the following order:
> > 1. patch to only open the file once
> > 2. patch to switch to stdio fmemopen
> 
> Actually looking at this, it would be write it once for item 1, then discard that as
> Most of it would change for item two. So I see no value in splitting this up.
> I think we just implement item 2 and as a sideffect it won't open the file up
> multiple times.

Looking at this in the context of fmemopen() or even some of the others like open_memstream()
They both seem to copy data into an internal buffer, so I did not see a way, for instance to just
set pointers into the mapping. The hand rolled getline like routine that worked on the area
struct should really not be allocating and using the pointers into the map, that was a poor
decision.

> 
> <snip>
