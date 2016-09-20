From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
 "'seandroid-list@tycho.nsa.gov'" <seandroid-list@tycho.nsa.gov>,
 "'sds@tycho.nsa.gov'" <sds@tycho.nsa.gov>, "'jdanis@google.com'"
 <jdanis@google.com>
Subject: RE: [RFC] mmap file_contexts and property_contexts:
Date: Tue, 20 Sep 2016 22:33:32 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD0DE2B@ORSMSX103.amr.corp.intel.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD0B1D9@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD0B1D9@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>

> > -----Original Message-----
> > From: Roberts, William C
> > Sent: Monday, September 19, 2016 2:45 PM
> > To: selinux@tycho.nsa.gov; seandroid-list@tycho.nsa.gov;
> > sds@tycho.nsa.gov; jdanis@google.com
> > Cc: Roberts, William C <william.c.roberts@intel.com>
> > Subject: [RFC] mmap file_contexts and property_contexts:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > THIS IS WIP...
> >
> > Rather than using stdio and making copies, just mmap the files and use
> > the pointers in place. The affect of this change, is that text file
> > load time is now faster than binary load time by 4.7% when testing
> > with a file_contexts file from the Android tree. Note that the Android doesn't
> use monstrous regexs.
> >
> > Times are the average of 3 runs.
> >
> > BEFORE:
> > Text file allocs: 114803
> > Text file load time: 0.266101
> > Bin file allocs: 93073
> > Bin file load time: 0.248757667
> >
> > AFTER:
> > Text file allocs: 103933
> > Text file load time: 0.236192667
> > Bin file allocs: 87645
> > Bin file load time: .247607333

Another potential issue, is that mmaping with textfiles also has the sideffect
of mapping in all the spaces or tabs, etc used, between fields, so on files with
heavy whitespace, it could be really memory intensive. 

I think Janis's patch that has -r option is a more useful way to go. Without precompiled
Regex's its essentially a textfile without the whitespace, and it automatically would
get pulled into the mmap interface.

I'm abandoning this, since we already get this functionality, without the negatives.
Janis, IIRC, you are re-configuring your patch so -r omits pre-compiled regex's (submitted
I believe on the list and awaiting other patches) and adding an arch string so we can
Detect when we need to recompile the regular expressions if they are supplied but
unusable.

I think we may want to investigate to have the "omit pre-compiled regex's" work on PCRE
library variants as well, but I doubt it would be used since Android is moving to PCRE2.

<snip>
