From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "jdanis@google.com" <jdanis@google.com>
Subject: RE: [RFC] mmap file_contexts and property_contexts:
Date: Tue, 20 Sep 2016 20:36:40 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD0D79F@ORSMSX103.amr.corp.intel.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <4318ab67-9b45-e44f-c013-1882e5e6a984@tycho.nsa.gov>
In-Reply-To: <4318ab67-9b45-e44f-c013-1882e5e6a984@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Tuesday, September 20, 2016 5:56 AM
> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov;
> seandroid-list@tycho.nsa.gov; jdanis@google.com
> Subject: Re: [RFC] mmap file_contexts and property_contexts:
> 
> On 09/19/2016 05:45 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > THIS IS WIP...
> >
> > Rather than using stdio and making copies, just mmap the files and use
> > the pointers in place. The affect of this change, is that text file

s/affect/effect

> > load time is now faster than binary load time by 4.7% when testing
> > with a file_contexts file from the Android tree. Note that the Android
> > doesn't use monstrous regexs.
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
> >
> > THINGS TO DO:
> > 1. What's arm performance like?
> > 2. What interfaces to backends are busted by this (if any)?
> > 3. Test Android Properties
> > 4. Im pretty sure this breaks sefcontext_compile, fix.
> > 5. Test with PCRE2 enabled.
> > 6. Spell check this message!
> > 7. Run checkpatch
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/label.c                  |   2 -
> >  libselinux/src/label_android_property.c |  22 ++---
> >  libselinux/src/label_file.c             | 140 +++++++++++++++++++-------------
> >  libselinux/src/label_file.h             |  66 +++++++++------
> >  libselinux/src/label_internal.h         |   3 +-
> >  libselinux/src/label_support.c          |  79 ++++++++----------
> >  6 files changed, 172 insertions(+), 140 deletions(-)
> >
> 
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 7156825..4dc440e 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -96,43 +96,64 @@ static int nodups_specs(struct saved_data *data, const
> char *path)
> >  	return rc;
> >  }
> >
> > -static int process_text_file(FILE *fp, const char *prefix,
> > -			     struct selabel_handle *rec, const char *path)
> > +static inline struct saved_data *rec_to_data(struct selabel_handle
> > +*rec) {
> > +	return (struct saved_data *)rec->data; }
> > +
> > +static char *mmap_area_get_line(struct mmap_area *area) {
> > +	size_t len = area->next_len;
> > +	if (!len)
> > +		return NULL;
> > +
> > +	char *start = area->next_addr;
> > +	char *end = memchr(start, '\n', len);
> > +
> > +	/* the file may not end with a newline */
> > +	if (!end)
> > +		end = (char *)area->next_addr + len - 1;
> > +
> > +	*end = '\0';
> 
> Couldn't this clobber the last character in the file if the file does not end with a
> newline?

Yeah I guess I really can't handle this case without increasing the mapping size or allocating
A new buffer to copy into. Considering, that the only time a file not ending with a newline
was my own stupid mistake, I am not too worried about the not ending newline, especially
considering that the Android build process handles it if it's missing.

Perhaps I could always add a terminating \0 to the mapping by growing it by one during mmap
And explicitly setting the byte.

> 
> > +	/* len includes null byte */
> > +	len = end - start;
> > +
> > +	area->next_len -= len + 1;
> > +	area->next_addr = ++end;
> > +	return start;
> > +}
> > +
> > +static int process_text_file(const char *path, const char *prefix,
> > +		struct selabel_handle *rec)
> >  {
> >  	int rc;
> > -	size_t line_len;
> >  	unsigned int lineno = 0;
> > -	char *line_buf = NULL;
> > +	char *line_buf;
> > +	struct mmap_area *areas = rec_to_data(rec)->mmap_areas;
> > +
> > +	/* mmap_area_get_line() and process_line() require mutable string
> pointers */
> > +	rc = mprotect(areas->addr, areas->len, PROT_READ | PROT_WRITE);
> 
> Just map it with PROT_READ|PROT_WRITE in the beginning.

Yep.
