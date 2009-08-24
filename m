Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OIMQ63011077
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 14:22:26 -0400
Received: from QMTA07.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7OINa2P002197
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 18:23:36 GMT
Subject: Re: libsemanage issue with bzip-blocksize=0 and compressed modules
 in store
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1251136827.2428.90.camel@moss-pluto.epoch.ncsc.mil>
References: <1251122072.2916.16.camel@defiant.pebenito.net>
	 <1251122651.2428.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1251125875.2916.25.camel@defiant.pebenito.net>
	 <1251136827.2428.90.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 14:22:13 -0400
Message-Id: <1251138133.2916.26.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-24 at 14:00 -0400, Stephen Smalley wrote:
> On Mon, 2009-08-24 at 10:57 -0400, Chris PeBenito wrote:
> > On Mon, 2009-08-24 at 10:04 -0400, Stephen Smalley wrote:
> > > On Mon, 2009-08-24 at 09:54 -0400, Chris PeBenito wrote:
> > > > I took the current release of libsemanage and added the patch to add a
> > > > bzip blocksize option[1].  The modules in my store were already
> > > > compressed with the stock release.  I put bzip-blocksize=0 in my
> > > > semanage.conf and I do semodule -B and get:
> > > > 
> > > > libsepol.module_package_read_offsets: wrong magic number for module
> > > > package:  expected 0xf97cff8f, got 0x39685a42 (No such file or
> > > > directory).
> > > > libsemanage.semanage_load_module: Error while reading from module
> > > > file /etc/selinux/strict/modules/tmp/modules/apm.pp. (No such file or
> > > > directory).
> > > > semodule:  Failed!
> > > > 
> > > > If I do semodule -l, it will also get the magic number error.  If I
> > > > remove the blocksize option, it works again.  I was able to reinsert all
> > > > of the modules to get it working again with the blocksize 0 option.
> > > > 
> > > > [1] http://userspace.selinuxproject.org/trac/changeset/ee9827000137fed2d3300124115fc1572acafe2f
> > > 
> > > Yes, that's what I would expect.  The expectation is that either one
> > > would set that option before installing the policy for the first time,
> > > or that one completely re-installs the policy after setting that option.
> > 
> > Can we have a little better handling of this case?  I don't mind
> > reinstalling the policy, but the error messages aren't helpful.  In
> > addition, with semodule -l being broken, I have to look into the module
> > store to see what modules are installed or guess.
> 
> Seems like it is just as easy to just support pre-existing compressed
> modules, see below.

Works for me.

> Explicitly probe for the bzip2 magic string prefix and fall through to
> BZ2_bzReadOpen() if the module is bzipped even if bzip-blocksize=0.
> Thus bzip-blocksize=0 will prevent any further compression of
> subsequently installed/updated modules, but will continue to function
> with existing compressed modules.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> ---
> 
>  libsemanage/src/direct_api.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index d563841..068061f 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -452,6 +452,9 @@ static ssize_t bzip(semanage_handle_t *sh, const char *filename, char *data,
>  	return total;
>  }
>  
> +#define BZ2_MAGICSTR "BZh"
> +#define BZ2_MAGICLEN (sizeof(BZ2_MAGICSTR)-1)
> +
>  /* bunzip() a file to '*data', returning the total number of uncompressed bytes
>   * in the file.  Returns -1 if file could not be decompressed. */
>  ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
> @@ -463,8 +466,13 @@ ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
>  	int     bzerror;
>  	size_t  total=0;
>  
> -	if (!sh->conf->bzip_blocksize)
> -		return -1;
> +	if (!sh->conf->bzip_blocksize) {
> +		bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
> +		rewind(f);
> +		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN))
> +			return -1;
> +		/* fall through */
> +	}
>  	
>  	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
>  	if ( bzerror != BZ_OK ) {
> 

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
