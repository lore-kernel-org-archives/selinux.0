From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
 "'seandroid-list@tycho.nsa.gov'" <seandroid-list@tycho.nsa.gov>,
 "'sds@tycho.nsa.gov'" <sds@tycho.nsa.gov>
Subject: RE: [PATCH] libsepol: fix memory leak in expand.c
Date: Tue, 9 Aug 2016 16:12:56 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56012812D9@ORSMSX103.amr.corp.intel.com>
References: <1470677301-20065-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC56012805C4@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012805C4@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> >
> > -      out:
> > +	  out:
> > +	rc = 0;
> >
> > -	ebitmap_destroy(&types);
> > +	  err_neg:
> >  	ebitmap_destroy(&neg_types);
> > +	  err_types:
> > +	ebitmap_destroy(&types);
> >
> > -	return 0;
> > +	return rc;
> >  }

I just noticed the indenting on the label changed, I went through the
File and it has:
1. labels with 7 leading spaces
2. labels left justified

Which one is the way you want them, left justified?

Bill
