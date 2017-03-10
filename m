Message-ID: <1489178869.6824.58.camel@tycho.nsa.gov>
Subject: Re: [PATCH] python/sepolicy: fix obtaining domain name in HTMLManPages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 10 Mar 2017 15:47:49 -0500
In-Reply-To: <20170303095256.11584-1-vmojzis@redhat.com>
References: <20170303095256.11584-1-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-03-03 at 10:52 +0100, Vit Mojzis wrote:
> HTMLManPages got domain name by splitting name of selinux manpage
> on "_selinux" which doesn't work properly when domain name contains
> "_selinux".

Thanks, applied.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolicy/sepolicy/manpage.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/manpage.py
> b/python/sepolicy/sepolicy/manpage.py
> index 773a9ab..1af4295 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -205,12 +205,12 @@ class HTMLManPages:
>          for domain in self.manpage_domains.values():
>              if len(domain):
>                  for d in domain:
> -                    convert_manpage_to_html((self.new_path +
> d.split("_selinux")[0] + ".html"), self.old_path + d)
> +                    convert_manpage_to_html((self.new_path +
> d.rsplit("_selinux", 1)[0] + ".html"), self.old_path + d)
>  
>          for role in self.manpage_roles.values():
>              if len(role):
>                  for r in role:
> -                    convert_manpage_to_html((self.new_path +
> r.split("_selinux")[0] + ".html"), self.old_path + r)
> +                    convert_manpage_to_html((self.new_path +
> r.rsplit("_selinux", 1)[0] + ".html"), self.old_path + r)
>  
>      def _gen_index(self):
>          index = self.old_path + "index.html"
> @@ -290,7 +290,7 @@ Fedora or Red Hat Enterprise Linux Man
> Pages.</h2>
>              if len(self.manpage_roles[letter]):
>                  rolename_body += "<p>"
>                  for r in self.manpage_roles[letter]:
> -                    rolename = r.split("_selinux")[0]
> +                    rolename = r.rsplit("_selinux", 1)[0]
>                      rolename_body += "<a name=%s_role></a><a
> href=%s.html>%s_selinux(8)</a> - Security Enhanced Linux Policy for
> the %s SELinux user\n" % (letter, rolename, rolename, rolename)
>  
>          fd.write("""%s
> @@ -317,7 +317,7 @@ Fedora or Red Hat Enterprise Linux Man
> Pages.</h2>
>              if len(self.manpage_domains[letter]):
>                  domainname_body += "<p>"
>                  for r in self.manpage_domains[letter]:
> -                    domainname = r.split("_selinux")[0]
> +                    domainname = r.rsplit("_selinux", 1)[0]
>                      domainname_body += "<a name=%s_domain></a><a
> href=%s.html>%s_selinux(8)</a> - Security Enhanced Linux Policy for
> the %s SELinux processes\n" % (letter, domainname, domainname,
> domainname)
>  
>          fd.write("""%s
