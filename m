Message-ID: <1501174101.8598.14.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 27 Jul 2017 12:48:21 -0400
In-Reply-To: <20170727131053.7962-4-plautrba@redhat.com>
References: <20170727131053.7962-1-plautrba@redhat.com>
 <20170727131053.7962-4-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 4/4] sepolicy: File labels used to be sorted in a man page
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-07-27 at 15:10 +0200, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied all 4 patches.

> ---
>  python/sepolicy/sepolicy/manpage.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/python/sepolicy/sepolicy/manpage.py
> b/python/sepolicy/sepolicy/manpage.py
> index 6df6f431..4d846364 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -807,6 +807,7 @@ Note: SELinux often uses regular expressions to
> specify labels that match multip
>          self.fd.write(r"""
>  .I The following file types are defined for %(domainname)s:
>  """ % {'domainname': self.domainname})
> +        flist.sort()
>          for f in flist:
>              self.fd.write("""
>  
