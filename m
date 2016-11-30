Subject: Re: [PATCH] seobject: Handle python error returns correctly
To: Kyle Walker <kwalker@redhat.com>, selinux@tycho.nsa.gov
References: <1480520874-22034-1-git-send-email-kwalker@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f1c73866-31dc-86ad-5650-9be050770b4e@tycho.nsa.gov>
Date: Wed, 30 Nov 2016 11:05:13 -0500
MIME-Version: 1.0
In-Reply-To: <1480520874-22034-1-git-send-email-kwalker@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/30/2016 10:47 AM, Kyle Walker wrote:
> After 9406ace8 ("libsemanage: throw exceptions in python rather than
> return NULL"), calls to libsemanage functions return Python exceptions
> instead of returning negative error return codes. For systems that did not
> have the applicable headers installed prior to build, the difference was
> not seen. Following commit 9792099f ("Properly build the swig exception
> file even if the headers are missing"), that issue has been resolved and
> the underlying semanage_fcontext_query_local and semanage_fcontext_query
> calls now result in an OSError return. This results in the following error
> when attempting to modify a fcontext defined in the systems base policy.
> 
>     libsemanage.dbase_llist_query: could not query record value (No such file or directory).
>     OSError: No such file or directory
> 
> To resolve the error, handle the OSError exception, but retain the
> previous query operation.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1398427

Hmm...even after this patch, we still get the error message from
dbase_llist_query.  Wondering if we should drop that or if that would
hide anything useful for other errors.  Doesn't seem overly useful at
present.

> 
> Signed-off-by: Kyle Walker <kwalker@redhat.com>
> ---
>  python/semanage/seobject.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index bb049c0..5f5fdec 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1953,10 +1953,12 @@ class fcontextRecords(semanageRecords):
>              if not exists:
>                  raise ValueError(_("File context for %s is not defined") % target)
>  
> -        (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
> -        if rc < 0:
> -            (rc, fcontext) = semanage_fcontext_query(self.sh, k)
> -            if rc < 0:
> +        try:
> +            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
> +        except OSError:
> +            try:
> +                (rc, fcontext) = semanage_fcontext_query(self.sh, k)
> +            except OSError:
>                  raise ValueError(_("Could not query file context for %s") % target)
>  
>          if setype != "<<none>>":
> 
