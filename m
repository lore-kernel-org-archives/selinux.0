From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov" <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: [PATCH] libselinux: clean up process file
Date: Fri, 2 Sep 2016 16:49:56 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560128E373@ORSMSX103.amr.corp.intel.com>
References: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
 <cb39b15c-71a2-82eb-e9cf-bf296d6ff554@tycho.nsa.gov>
In-Reply-To: <cb39b15c-71a2-82eb-e9cf-bf296d6ff554@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> 
> I'm not sure what the motivation is for this patch.

It simplifies and streamlines the code. The existing code will  cause ones
eyes to bleed and I was sick of the bleeding.

> In any event, I think it would be better to do it as a series of smaller changes,
> preferably starting with any actual fixes/improvements and only then moving
> into code rewriting.  Some specific comments below.

Sure I'll split this into two things.
After reading everything and now knowing that bionic supports fmemopen() since M,
I think it makes sense to have this in the following order:
1. patch to only open the file once
2. patch to switch to stdio fmemopen

The second thing takes care of a lot of stuff and kills of area struct which is nice.

> 
> >
> > Detailed statistics of before and after:
> >
> > Source lines of code reported by cloc on modified files:
> > before: 1090
> > after: 1119
> >
> > Object size difference:
> > before: 195530 bytes
> > after:  195569 bytes
> >
> > Performance:
> >
> > text fc files (avg of 3 runs with selabel_open()):
> > before: 248 ms
> > after: 243 ms
> >
> > bin fc files (avg of 3 runs with selabel_open()):
> > before: 236 ms
> > after:  236 ms
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/label_file.c | 606
> > ++++++++++++++++++++++++++------------------
> >  libselinux/src/label_file.h |  17 +-
> >  2 files changed, 359 insertions(+), 264 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index c89bb35..bd65ee7 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -97,92 +97,270 @@ static int nodups_specs(struct saved_data *data, const
> char *path)
> >  	return rc;
> >  }
> >
> > -static int load_mmap(struct selabel_handle *rec, const char *path,
> > -				    struct stat *sb, bool isbinary,
> > -				    struct selabel_digest *digest)
> > +static int load_mmap(FILE *fp, off_t size, struct selabel_handle
> > +*rec)
> >  {
> > -	struct saved_data *data = (struct saved_data *)rec->data;
> > -	char mmap_path[PATH_MAX + 1];
> > -	int mmapfd;
> > -	int rc;
> > -	struct stat mmap_stat;
> > -	char *addr, *str_buf;
> > -	size_t len;
> > -	int *stem_map;
> > +	char *addr;
> >  	struct mmap_area *mmap_area;
> > -	uint32_t i, magic, version;
> > -	uint32_t entry_len, stem_map_len, regex_array_len;
> >
> > -	if (isbinary) {
> > -		len = strlen(path);
> > -		if (len >= sizeof(mmap_path))
> > -			return -1;
> > -		strcpy(mmap_path, path);
> > -	} else {
> > -		rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
> > -		if (rc >= (int)sizeof(mmap_path))
> > -			return -1;
> > -	}
> > +	struct saved_data *data = (struct saved_data *) rec->data;
> >
> > -	mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
> > -	if (mmapfd < 0)
> > +	addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
> > +	if (addr == MAP_FAILED )
> >  		return -1;
> >
> > -	rc = fstat(mmapfd, &mmap_stat);
> > -	if (rc < 0) {
> > -		close(mmapfd);
> > +	mmap_area = malloc(sizeof(*mmap_area));
> > +	if (!mmap_area) {
> > +		munmap(addr, size);
> >  		return -1;
> >  	}
> >
> > -	/* if mmap is old, ignore it */
> > -	if (mmap_stat.st_mtime < sb->st_mtime) {
> > -		close(mmapfd);
> > -		return -1;
> > +	/* save where we mmap'd the file to cleanup on close() */
> > +	mmap_area->addr = mmap_area->next_addr = addr;
> > +	mmap_area->len = mmap_area->next_len = size;
> > +	mmap_area->next = data->mmap_areas;
> > +	data->mmap_areas = mmap_area;
> > +
> > +	return 0;
> > +}
> > +
> > +struct file_details {
> > +	const char *suffix;
> > +	struct stat sb;
> > +};
> > +
> > +static char *rolling_append(char *current, const char *suffix, size_t
> > +max) {
> > +	size_t size;
> > +
> > +	if (!suffix)
> > +		return current;
> > +
> > +	/*
> > +	 * Overflow check:
> > +	 * current contents of tmp (stack_path) + '.' + suffix  + '\0'
> 
> Comment refers to variables that don't exist in this scope.
> 
> > +	 * should never be too big.
> > +	 */
> > +	size = strlen(current) + 1 + strlen(suffix) + 1;
> 
> If we are worried about overflow, then are we worried about integer overflow
> above?

Initially I thought no, because we already checked that current is PATH_MAX, but we
Didn't check suffix, so it would be possible. So I think we should be worried here. I know
You said libsepol gets hit with old compilers, but what about libselinux? Can we use any
Intrinsics here?

> 
> > +	if (size > max)
> > +		return NULL ;
> 
> Here and elsewhere: extraneous whitespace before ;
Weird, done.
> 
> > +
> > +	/* Append any given suffix */
> > +	strcat(current, ".");
> > +	strcat(current, suffix);
> 
> This could be done more simply/efficiently, e.g. use stpcpy() or snprintf().
snprintf() is not very efficient in terms of performance, var-args is expensive
as well as needing to process the format specifies.
I do like strpcat() however.
> 
> > +
> > +	return current;
> > +}
> > +
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +
> > +static FILE *open_file(const char *path, const char *suffix, size_t *size,
> > +		char**save_path)
> > +{
> > +
> > +	unsigned i;
> > +	int rc;
> > +	char stack_path[PATH_MAX + 1];
> > +
> > +	struct file_details *found = NULL;
> > +	char found_path[sizeof(stack_path)];
> > +
> > +	/*
> > +	 *  Rolling append of suffix, iw we try with path.suffix then the
> 
> Is "iw" supposed to be "ie"?
Yes.
> 
> > +	 * next as path.suffix.suffix and so forth.
> > +	 */
> > +	struct file_details fdetails[2] = { { .suffix = suffix },
> > +			{ .suffix = "bin" }, };
> > +
> > +	rc = snprintf(stack_path, sizeof(stack_path), "%s", path);
> > +	if (rc >= (int) sizeof(stack_path)) {
> > +		errno = ENAMETOOLONG;
> > +		return NULL ;
> >  	}
> >
> > -	/* ok, read it in... */
> > -	len = mmap_stat.st_size;
> > -	len += (sysconf(_SC_PAGE_SIZE) - 1);
> > -	len &= ~(sysconf(_SC_PAGE_SIZE) - 1);
> > +	for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
> >
> > -	mmap_area = malloc(sizeof(*mmap_area));
> > -	if (!mmap_area) {
> > -		close(mmapfd);
> > -		return -1;
> > +		path = rolling_append(stack_path, fdetails[i].suffix,
> > +				sizeof(stack_path));
> > +		if (!path)
> > +			return NULL ;
> > +
> > +		rc = stat(path, &fdetails[i].sb);
> > +		if (rc)
> > +			continue;
> > +
> > +		/* first file thing found, just take it */
> 
> thing?
> 
> > +		if (!found) {
> > +			strcpy(found_path, path);
> > +			found = &fdetails[i];
> > +			continue;
> > +		}
> > +
> > +		/* next possible finds, keep picking the newest file */
> > +		if (fdetails[i].sb.st_mtime > found->sb.st_mtime) {
> > +			found = &fdetails[i];
> > +			strcpy(found_path, path);
> > +		}
> >  	}
> >
> <snip>
> > +
> > +/*
> > + * Similair to getline() but not quite the same.
> 
> Similar.
> 
> Do we truly need to roll our own getline()?  fmemopen() + getline() would
> probably work, but might be specific to glibc.

Bionic used to be devoid of this, but it looks like it was added in Api Level 23 or Marshmallow, so
We should be able to use it, then we can just use fread/fwrite where the memmap is, we should
At least have a consistent interface to our files. This also could kill of the area struct which was
Acting like the file stream pointer for mmap.

> 
> > + * It returns the length of the string in the size paramter,
> > + * not the buffer size.
> > + *
> > + * Returns:
> > + * 1 - EOF
> > + * 0 - Success
> > + * -1 - Error
> > + */
> > +static int get_next_newline(struct mmap_area *fp, char **line, size_t
> > +*size) {
> > +	size_t offset = 0;
> > +	char *p = fp->next_addr;
> > +
> > +	/* normal end of file condition */
> > +	if (!fp->next_len)
> > +		return 1;
> > +
> > +	while (*p != '\n') {
> > +
> 
> Extraneous empty line
> 
> > +		if (offset > fp->next_len)
> > +			return -1;
> 
> What if the file doesn't end with a newline?
I guess we should just return what we have,
> 
> > +
> > +		p++;
> > +		offset++;
> >  	}
> 
> p = memchr(fp->next_addr, '\n', fp->next_len); if (p)
> 	offset = p - fp->next_addr;
> 
> >
> > -	/* save where we mmap'd the file to cleanup on close() */
> > -	mmap_area->addr = mmap_area->next_addr = addr;
> > -	mmap_area->len = mmap_area->next_len = len;
> > -	mmap_area->next = data->mmap_areas;
> > -	data->mmap_areas = mmap_area;
> > +	/* capture the newline */
> > +	offset++;
> > +
> > +	/* ensure no overflows on below arithmatic */
> 
> arithmetic
> 
> > +	if (offset == (size_t) -1)
> > +		return -1;
> >
> > -	/* check if this looks like an fcontext file */
> > -	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
> > -	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
> > +	*line = malloc(offset + 1);
> > +	if (!*line)
> >  		return -1;
> >
> > +	strncpy(*line, fp->next_addr, offset);
> > +
> > +	(*line)[offset] = '\0';
> 
> *line = strndup(fp->next_addr, offset);
> 
> > +
> > +	fp->next_addr = (char *) fp->next_addr + offset;
> > +	fp->next_len -= offset;
> > +	*size = offset;
> > +	return 0;
> > +}
> > +
> > +static int read_text_file(struct selabel_handle *rec, const char
> > +*prefix) {
> > +	int rc;
> > +	char *line;
> > +	size_t size;
> > +	unsigned lineno = 0;
> > +
> > +	struct saved_data *saved_data = (struct saved_data *) rec->data;
> > +	struct mmap_area *area = saved_data->mmap_areas;
> > +
> > +	while (get_next_newline(area, &line, &size) == 0) {
> > +		rc = process_line(rec, saved_data->path, prefix, line, ++lineno);
> > +		free(line);
> 
> So we're malloc+free'ing on every line?
Yeah, that’s not nice huh, we should just realloc, but this goes away.
> 
> > +		if (rc)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int read_binary_file(struct selabel_handle *rec) {
> > +
> 
> Extraneous empty line
Actually, should be { on this line and likely everywhere else.
> 
> > +	int err;
> > +	size_t len;
> > +	int *stem_map;
> > +	char *str_buf;
> > +	uint32_t entry_len;
> > +
> > +	int rc = -1;
> 
> Do we really need separate err and rc variables, and if so, it is clear which one to
> use at all times?  Or why not switch the usage so you don't have to rewrite so
> many lines unnecessarily?
> 
> > +
> > +	struct saved_data *data = (struct saved_data *) rec->data;
> > +	struct mmap_area *map_area = data->mmap_areas;
> > +
> > +	/*
> > +	 * We assume entry from is_binary() puts us past the uint32_t
> > +	 * magic header
> > +	 */
> 
> Is it worth this inconsistency?  Might as well just rewind always and recheck here.
> 
> > @@ -205,9 +383,10 @@ static int load_mmap(struct selabel_handle *rec, const
> char *path,
> >  		free(str_buf);
> >  	}
> >
> > +	uint32_t stem_map_len;
> 
> Why move it?  Not really a fan of scattering local variables around unless there is
> truly a separate scope.
> 
> >  	/* allocate the stems_data array */
> > -	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
> > -	if (rc < 0 || !stem_map_len)
> > +	err = next_entry(&stem_map_len, map_area, sizeof(stem_map_len));
> > +	if (err < 0 || !stem_map_len)
> >  		return -1;
> >
> >  	/*
> > @@ -218,295 +397,223 @@ static int load_mmap(struct selabel_handle *rec,
> const char *path,
> >  	if (!stem_map)
> >  		return -1;
> >
> > +	uint32_t i;
> 
> Ditto
> 
> 
> > -err:
> > -	free(stem_map);
> > +	rc = 0;
> >
> > +	out: free(stem_map);
> 
> Labels should be left-aligned and on a separate line from any statements.
> 
> >  	return rc;
> >  }
> >
> >  static int process_file(const char *path, const char *suffix,
> > -			  struct selabel_handle *rec,
> > -			  const char *prefix, struct selabel_digest *digest)
> > +		struct selabel_handle *rec, const char *prefix,
> > +		struct selabel_digest *digest)
> >  {
> > +
> 
> Extraneous empty line.
> 
> >
> > -	/*
> > -	 * Then do detailed validation of the input and fill the spec array
> > -	 */
> > -	lineno = 0;
> > -	rc = 0;
> > -	while (getline(&line_buf, &line_len, fp) > 0) {
> > -		rc = process_line(rec, path, prefix, line_buf, ++lineno);
> > -		if (rc)
> > -			goto out;
> > -	}
> > +	is_binary = fcontext_is_binary(area);
> > +	if (is_binary)
> > +		rc = read_binary_file(rec);
> > +	else
> > +		rc = read_text_file(rec, prefix);
> >
> > -	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
> > +	if (rc < 0)
> > +		goto out;
> >
> > -out:
> > -	free(line_buf);
> > -	if (fp)
> > -		fclose(fp);
> > +	rc = digest_add_specfile(digest, fp, NULL, size, path);
> > +	out:
> 
> Left aligned labels.
Yeah this was the darn formatter.
> 
> > +	/* closef() deals with mmapings */
> > +	fclose(fp);
> >  	return rc;
> >  }
