From: "Roberts, William C" <william.c.roberts@intel.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov"
 <jwcart2@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: RE: [PATCH] libselinux: clean up process file
Date: Fri, 26 Aug 2016 20:19:10 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560128B2D4@ORSMSX103.amr.corp.intel.com>
References: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> +	rc = 0;
> 
> +	out: free(stem_map);

Dang eclipse formatter, now I see why libsepol has the indents for the labels way out,
Ill aggregate feedback and possible send v2 next week.

>  	return rc;
>  }
<snip>
