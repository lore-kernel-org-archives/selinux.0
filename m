Date: Fri, 6 Nov 2015 16:57:46 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Message-ID: <1243161466.4805052.1446847066714.JavaMail.zimbra@redhat.com>
In-Reply-To: <1457848.Jk6pGUaKPb@sifl>
References: <cover.1446805443.git.jstancek@redhat.com>
 <53398a996e0230fa07c82955624a474524bee50b.1446805443.git.jstancek@redhat.com>
 <1457848.Jk6pGUaKPb@sifl>
Subject: Re: [selinux-testsuite PATCH 3/4] mmap/mprotect_heap: make sure
 memory is allocated from heap
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>





----- Original Message -----
> From: "Paul Moore" <paul@paul-moore.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
> Sent: Friday, 6 November, 2015 7:14:54 PM
> Subject: Re: [selinux-testsuite PATCH 3/4] mmap/mprotect_heap: make sure memory is allocated from heap
> 
> On Friday, November 06, 2015 02:07:23 PM Jan Stancek wrote:
> > This test failed on ppc64 with 64k pagesize because memory
> > allocation used mmap() instead of advancing heap.
> > 
> > Use mallopt(M_MMAP_THRESHOLD,..) with large enough value
> > to discourage use of mmap().
> > 
> > Also set length in mprotect to pagesize, kernel silently aligns
> > it to pagesize anyway.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  tests/mmap/mprotect_heap.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/mmap/mprotect_heap.c b/tests/mmap/mprotect_heap.c
> > index 691299493c3f..8b4321d6fc0b 100644
> > --- a/tests/mmap/mprotect_heap.c
> > +++ b/tests/mmap/mprotect_heap.c
> > @@ -3,6 +3,7 @@
> >  #include <stdlib.h>
> >  #include <errno.h>
> >  #include <sys/mman.h>
> > +#include <malloc.h>
> > 
> >  int main(void)
> >  {
> > @@ -10,13 +11,19 @@ int main(void)
> >  	int rc;
> >  	int pagesize = getpagesize();
> > 
> > +	rc = mallopt(M_MMAP_THRESHOLD, pagesize * 16);
> > +	if (rc != 1) {
> > +		fprintf(stderr, "mallopt failed: %d\n", rc);
> > +		exit(1);
> > +	}
> 
> Can you explain how you arrived at 16?  It looks a bit like a magic number to
> me, which always gives me pause.  Based on a quick read of the man page, it
> would seem like any value greater than "pagesize" would work, yes?

I thought 2 would be enough - as you can find aligned page sized block within.
But when I tried it, it failed. It started working with 3 * pagesize.
I picked 16 as rule of thumb. Now, that I'm looking at man page I guess
we can as well use DEFAULT_MMAP_THRESHOLD_MAX.

Regards,
Jan

> 
> >  	rc = posix_memalign(&ptr, pagesize, pagesize);
> >  	if (rc) {
> >  		fprintf(stderr, "posix_memalign failed: %d\n", rc);
> >  		exit(1);
> >  	}
> > 
> > -	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
> > +	rc = mprotect(ptr, pagesize, PROT_READ | PROT_EXEC);
> >  	if (rc < 0) {
> >  		perror("mprotect");
> >  		exit(1);
> 
> --
> paul moore
> www.paul-moore.com
> 
> 
