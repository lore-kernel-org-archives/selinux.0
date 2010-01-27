MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 06/15] [src-policy] libsemanage: compile hll module
Date: Wed, 27 Jan 2010 15:42:29 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0199EB0F@exchange2.columbia.tresys.com>
In-Reply-To: <1264623507.17372.85.camel@moss-pluto.epoch.ncsc.mil>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com> <1264543701-20638-2-git-send-email-ccase@tresys.com> <1264543701-20638-3-git-send-email-ccase@tresys.com> <1264543701-20638-4-git-send-email-ccase@tresys.com> <1264543701-20638-5-git-send-email-ccase@tresys.com> <1264543701-20638-6-git-send-email-ccase@tresys.com> <1264543701-20638-7-git-send-email-ccase@tresys.com> <1264623507.17372.85.camel@moss-pluto.epoch.ncsc.mil>
From: "Caleb Case" <ccase@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Sellers" <csellers@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>, <jwcart2@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, January 27, 2010 3:18 PM
> To: Caleb Case
> Cc: selinux@tycho.nsa.gov; Chad Sellers; Karl MacMillan;
> jwcart2@tycho.nsa.gov; Joshua Brindle
> Subject: Re: [PATCH 06/15] [src-policy] libsemanage: compile hll
module
> 
> On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> > This provides the basic compilation function semanage_compile_hll
that
> > is called during module installation. semanage_exec is a helper
function
> > which sets up the redirected io for the child process, executes it,
> > waits for the child to exit, and then propagates the child's exit
> > status. An additional helper function semanage_fd_to_data reads a
given
> > file descriptor into a buffer (unzipping it if necessary). The
> > compilation messages are stored in
> > /var/lib/selinux/.../modules/<priority>/<module>/log.
> 
> > diff --git a/libsemanage/src/semanage_store.c
> b/libsemanage/src/semanage_store.c
> > index 2bda1e2..dd96a75 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -3034,3 +3034,357 @@ int semanage_nc_sort(semanage_handle_t * sh,
> const char *buf, size_t buf_len,
> >
> >  	return 0;
> >  }
> > +
> > +/* Execute @cmd with @args and redirect the @io.
> > + *
> > + * @io is an array of fd's to redirect. Indices correspond to fds.
The
> fds
> > + * are not closed. Indices set to -1 are ignored, otherwise they
are
> > + * dup2'd.
> > + *
> > + * Returns:
> > + * 	 0	success
> > + * 	-1	failure, error outside HLL compiler
> > + * 	+N	failure, HLL compiler exit status N
> > + */
> > +static int semanage_exec(semanage_handle_t *sh,
> > +			 const char *cmd,
> > +			 char *argv[],
> > +			 int io[],
> > +			 int io_len)
> 
> Can this function be unified with the already existing
> semanage_exec_prog()?  Likely by making the latter call this one after
> splitting args?

Yes, I'll switch it around.

> 
> > +int semanage_fd_to_data(semanage_handle_t *sh,
> > +			int fd,
> > +			char **data,
> > +			size_t *data_len)
> > +{
> > +	assert(sh);
> > +	assert(data);
> > +	assert(data_len);
> > +
> > +	int status = 0;
> > +	int ret = 0;
> > +
> > +	*data = NULL;
> > +	*data_len = 0;
> > +
> > +	FILE *fp = NULL;
> > +	struct stat sb;
> > +	sb.st_size = 0;
> > +	ssize_t nread = 0;
> > +	char *data_tmp = NULL;
> > +
> > +	/* Find out how big it is. */
> > +	ret = fstat(fd, &sb);
> > +	if (ret != 0) {
> > +		ERR(sh, "Failed to stat file");
> > +		status = -2;
> > +		goto cleanup;
> > +	}
> > +	*data_len = sb.st_size;
> > +
> > +	/* Allocate a buffer for the file. */
> > +	*data = malloc(*data_len + 1);
> > +	if (*data == NULL) {
> > +		ERR(sh, "Out of memory!");
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> > +	(*data)[*data_len] = '\0';
> 
> Aren't we going to clobber this shortly?
> 
> > +
> > +	/* Read into the buffer. */
> > +	while((size_t)nread != *data_len) {
> > +		nread = read(fd, *data + nread, *data_len - nread);
> > +		if (nread < 0) {
> 
> We should likely handle EINTR more cleanly throughout.
> 
> > +			ERR(sh, "Failed to read the file");
> > +			status = -1;
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> > +	/* Try to bunzip. */
> > +	fp = fmemopen(*data, *data_len, "r");
> > +	if (fp == NULL) {
> > +		ERR(sh, "Failed to open file for reading");
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> 
> I have a patch to eliminate use of fmemopen() in libsemanage as it
> doesn't handle binary files correctly for glibc < 2.9; see the other
> discussion.  Maybe this is ok due to only acting on text files?

Nope, this is the same problem all over again. I think that the best
option is to switch the interface around to taking a file stream instead
of a file pointer.

> 
> > +
> > +	nread = bunzip(sh, fp, &data_tmp);
> > +	if (nread > 0) {
> > +		free(*data);
> > +		*data = data_tmp;
> > +		*data_len = (size_t)nread;
> > +	}
> > +
> > +cleanup:
> > +	if (status != 0) {
> > +		free(*data);
> > +		*data = NULL;
> > +		*data_len = 0;
> > +	}
> > +
> > +	if (fp != NULL) fclose(fp);
> > +
> > +	return status;
> > +}
> > +
> > +int semanage_compile_hll(semanage_handle_t *sh,
> > +			 const semanage_module_info_t *modinfo)
> > +{
> > +	int status = 0;
> > +	int ret = 0;
> > +
> > +	char hll_path[PATH_MAX];
> > +	char cil_path[PATH_MAX];
> > +	char ver_path[PATH_MAX];
> > +	char log_path[PATH_MAX];
> > +
> > +	char tmp[] = "/tmp/libsemanage-XXXXXX";
> > +	int tmp_fd = -1;
> > +	ssize_t nwrite = 0;
> > +
> > +	int io[4];
> > +	int io_len = 4;
> > +
> > +	const semanage_lang_conf_t *conf = NULL;
> > +
> > +	int i;
> > +
> > +	char **argv = NULL;
> > +
> > +	char *data = NULL;
> > +	size_t data_len = 0;
> > +
> > +	/* determine paths and setup io:
> > +	 *
> > +	 * 0	hll
> > +	 * 1	cil
> > +	 * 2	log
> > +	 * 3	version
> > +	 */
> > +
> > +	/* 0	hll */
> > +	ret = semanage_module_get_path(sh,
> > +				       modinfo,
> > +				       SEMANAGE_MODULE_PATH_HLL,
> > +				       hll_path,
> > +				       sizeof(hll_path));
> > +	if (ret != 0) {
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> > +
> > +	/* open hll, read in (which will bunzip if necessary) */
> > +	tmp_fd = open(hll_path, O_RDONLY);
> > +	if (tmp_fd < 0) {
> > +		ERR(sh, "Failed to open %s", hll_path);
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> > +
> > +	ret = semanage_fd_to_data(sh, tmp_fd, &data, &data_len);
> > +	if (ret != 0) {
> > +		ERR(sh, "Failed to read %s", hll_path);
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> > +
> > +	close(tmp_fd);
> > +	tmp_fd = mkstemp(tmp);
> > +	if (tmp_fd < 0) {
> > +		ERR(sh,
> > +		    "Failed to create tmp file for module %s.",
> > +		    modinfo->name);
> > +		status = -1;
> > +		goto cleanup;
> > +	}
> > +
> > +	while((size_t)nwrite != data_len) {
> > +		nwrite = write(tmp_fd, data + nwrite, data_len -
nwrite);
> > +		if (nwrite < 0) {
> 
> EINTR handling.
> Need to check that the expected length was written, not just < 0.
> >From the man page:
>        If  a  write()  is interrupted by a signal handler before any
bytes
> are
>        written, then the call fails with the error EINTR; if it is
> interrupted
>        after  at  least  one  byte  has  been  written, the call
succeeds,
> and
>        returns the number of bytes written.

Oops, will fix.

> 
> > +			ERR(sh,
> > +			    "Failed to write data to tmp file for module
%s.",
> > +			    modinfo->name);
> > +			status = -1;
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> > +	ret = fsync(tmp_fd);
> 
> fdatasync(), maybe?
> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
