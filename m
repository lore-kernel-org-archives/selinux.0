Message-ID: <1516113910.10453.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 16 Jan 2018 09:45:10 -0500
In-Reply-To: <20180111162210.21281-1-plautrba@redhat.com>
References: <20180111162210.21281-1-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] python/semanage: bring semanageRecords.set_reload back
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-01-11 at 17:22 +0100, Petr Lautrbach wrote:
> It's used by third parties, e.g. Ansible modules
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1527745

Thanks, applied.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  python/semanage/seobject.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/python/semanage/seobject.py
> b/python/semanage/seobject.py
> index b927b184..c2966251 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -260,6 +260,9 @@ class semanageRecords:
>          else:
>              self.mylog = nulllogger()
>  
> +    def set_reload(self, load):
> +        self.noreload = not load
> +
>      def get_handle(self, store):
>          global is_mls_enabled
>  
