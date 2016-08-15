Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Miroslav Vadkerti <mvadkert@redhat.com>, selinux@tycho.nsa.gov
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <8be530be-2f00-7c6f-ce5d-7d7b4ac20dfb@tycho.nsa.gov>
Date: Mon, 15 Aug 2016 14:29:07 -0400
MIME-Version: 1.0
In-Reply-To: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2016 09:57 AM, Miroslav Vadkerti wrote:
> For modify action actually audit the selinux type, i.e. use setype
> variable.
>
> For deleting equal fcontext rules do not audit ftype, as the ftype value
> for equal rules makes little sense.
>
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>

Applied.

Thanks,
Jim

> ---
>  policycoreutils/semanage/seobject.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index 786ed0e..8d3088c 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1992,7 +1992,7 @@ class fcontextRecords(semanageRecords):
>          if not seuser:
>              seuser = "system_u"
>
> -        self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", type, serange))
> +        self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", setype, serange))
>
>      def modify(self, target, setype, ftype, serange, seuser):
>          self.begin()
> @@ -2030,7 +2030,7 @@ class fcontextRecords(semanageRecords):
>              self.equiv.pop(target)
>              self.equal_ind = True
>
> -            self.mylog.log_change("resrc=fcontext op=delete-equal %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype]))
> +            self.mylog.log_change("resrc=fcontext op=delete-equal %s" % (audit.audit_encode_nv_string("tglob", target, 0)))
>
>              return
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
