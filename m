Subject: Re: [patch 1/1] removal of unused private.h from libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Caleb Case <ccase@tresys.com>, selinux-dev@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1160774164.22172.18.camel@twoface.columbia.tresys.com>
References: <200610051856.k95IuhVO028187@localhost.localdomain>
	 <1160774164.22172.18.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 17:25:46 -0400
Message-Id: <1160774746.14346.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-13 at 17:16 -0400, Joshua Brindle wrote:
> On Thu, 2006-10-05 at 14:56 -0400, Caleb Case wrote:
> > The header libsemanage/src/private.h is no longer used and should be removed.  It appears to be left over from the libsemod days.
> > 
> 
> Did this get lost in the labeled network oblivion?
> 
> > ---
> >  libsemanage/src/private.h |   72 ----------------------------------------------
> >  1 file changed, 72 deletions(-)
> > 
> > Index: selinux-pms-support/libsemanage/src/private.h
> > ===================================================================
> > --- selinux-pms-support.orig/libsemanage/src/private.h
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -/* Private definitions for libsemod. */
> > -
> > -/* Endian conversion for reading and writing binary policies */
> > -
> > -#include <byteswap.h>
> > -#include <endian.h>
> > -
> > -#if __BYTE_ORDER == __LITTLE_ENDIAN
> > -#define cpu_to_le32(x) (x)
> > -#define le32_to_cpu(x) (x)
> > -#define cpu_to_le64(x) (x)
> > -#define le64_to_cpu(x) (x)
> > -#else
> > -#define cpu_to_le32(x) bswap_32(x)
> > -#define le32_to_cpu(x) bswap_32(x)
> > -#define cpu_to_le64(x) bswap_64(x)
> > -#define le64_to_cpu(x) bswap_64(x)
> > -#endif
> > -
> > -/* Read from a policy "file" and return a pointer to the requested set
> > -   of bytes.  Do *NOT* free the returned pointer.  Returns NULL if the
> > -   requested number of bytes is larger than the read buffer or if an
> > -   I/O error occurred.  Note that this function is thread-safe. */
> > -static inline void *next_entry(struct policy_file *fp, size_t bytes)
> > -{
> > -	size_t nread;
> > -
> > -	if (bytes > sizeof(fp->buffer))
> > -		return NULL;
> > -
> > -	switch (fp->type) {
> > -	case PF_USE_STDIO:
> > -		nread = fread(fp->buffer, bytes, 1, fp->fp);
> > -		if (nread != 1)
> > -			return NULL;
> > -		break;
> > -	case PF_USE_MEMORY:
> > -		if (bytes > fp->len)
> > -			return NULL;
> > -		memcpy(fp->buffer, fp->data, bytes);
> > -		fp->data += bytes;
> > -		fp->len -= bytes;
> > -		break;
> > -	default:
> > -		return NULL;
> > -	}
> > -	return fp->buffer;
> > -}
> > -
> > -static inline size_t put_entry(const void *ptr, size_t size, size_t n,
> > -			       struct policy_file *fp)
> > -{
> > -	size_t bytes = size * n;
> > -
> > -	switch (fp->type) {
> > -	case PF_USE_STDIO:
> > -		return fwrite(ptr, size, n, fp->fp);
> > -	case PF_USE_MEMORY:
> > -		if (bytes > fp->len) {
> > -			errno = ENOSPC;
> > -			return 0;
> > -		}
> > -
> > -		memcpy(fp->data, ptr, bytes);
> > -		fp->data += bytes;
> > -		fp->len -= bytes;
> > -		return n;
> > -	default:
> > -		return 0;
> > -	}
> > -	return 0;
> > -}
> > 
> > --
> > 
> > 
> > The header libsemanage/src/private.h is no longer used and should be removed.  It appears to be left over from the libsemod days.
> > 
> > ---
> >  libsemanage/src/private.h |   72 ----------------------------------------------
> >  1 file changed, 72 deletions(-)
> > 
> > Index: selinux-pms-support/libsemanage/src/private.h
> > ===================================================================
> > --- selinux-pms-support.orig/libsemanage/src/private.h
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -/* Private definitions for libsemod. */
> > -
> > -/* Endian conversion for reading and writing binary policies */
> > -
> > -#include <byteswap.h>
> > -#include <endian.h>
> > -
> > -#if __BYTE_ORDER == __LITTLE_ENDIAN
> > -#define cpu_to_le32(x) (x)
> > -#define le32_to_cpu(x) (x)
> > -#define cpu_to_le64(x) (x)
> > -#define le64_to_cpu(x) (x)
> > -#else
> > -#define cpu_to_le32(x) bswap_32(x)
> > -#define le32_to_cpu(x) bswap_32(x)
> > -#define cpu_to_le64(x) bswap_64(x)
> > -#define le64_to_cpu(x) bswap_64(x)
> > -#endif
> > -
> > -/* Read from a policy "file" and return a pointer to the requested set
> > -   of bytes.  Do *NOT* free the returned pointer.  Returns NULL if the
> > -   requested number of bytes is larger than the read buffer or if an
> > -   I/O error occurred.  Note that this function is thread-safe. */
> > -static inline void *next_entry(struct policy_file *fp, size_t bytes)
> > -{
> > -	size_t nread;
> > -
> > -	if (bytes > sizeof(fp->buffer))
> > -		return NULL;
> > -
> > -	switch (fp->type) {
> > -	case PF_USE_STDIO:
> > -		nread = fread(fp->buffer, bytes, 1, fp->fp);
> > -		if (nread != 1)
> > -			return NULL;
> > -		break;
> > -	case PF_USE_MEMORY:
> > -		if (bytes > fp->len)
> > -			return NULL;
> > -		memcpy(fp->buffer, fp->data, bytes);
> > -		fp->data += bytes;
> > -		fp->len -= bytes;
> > -		break;
> > -	default:
> > -		return NULL;
> > -	}
> > -	return fp->buffer;
> > -}
> > -
> > -static inline size_t put_entry(const void *ptr, size_t size, size_t n,
> > -			       struct policy_file *fp)
> > -{
> > -	size_t bytes = size * n;
> > -
> > -	switch (fp->type) {
> > -	case PF_USE_STDIO:
> > -		return fwrite(ptr, size, n, fp->fp);
> > -	case PF_USE_MEMORY:
> > -		if (bytes > fp->len) {
> > -			errno = ENOSPC;
> > -			return 0;
> > -		}
> > -
> > -		memcpy(fp->data, ptr, bytes);
> > -		fp->data += bytes;
> > -		fp->len -= bytes;
> > -		return n;
> > -	default:
> > -		return 0;
> > -	}
> > -	return 0;
> > -}
> > 
> > --
> > 
> > Signed-Off-By: Joshua Brindle <jbrindle@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

(feel free to merge; trivial fix)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
