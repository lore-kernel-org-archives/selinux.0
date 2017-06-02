Message-ID: <1496435496.19674.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] sepolicy: Fix sorting of port_strings in python 3
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 02 Jun 2017 16:31:36 -0400
In-Reply-To: <20170602200131.16718-3-plautrba@redhat.com>
References: <20170602200131.16718-1-plautrba@redhat.com>
 <20170602200131.16718-3-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-02 at 22:01 +0200, Petr Lautrbach wrote:
> Fixes:
> $ sepolicy network -d httpd_t
> 
> httpd_t: tcp name_connect
> Traceback (most recent call last):
>   File /usr/bin/sepolicy, line 699, in <module>
>     args.func(args)
>   File /usr/bin/sepolicy, line 319, in network
>     _print_net(d, tcp, name_connect)
>   File /usr/bin/sepolicy, line 276, in _print_net
>     port_strings.sort(numcmp)
> TypeError: must use keyword argument for key function
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied both.

> ---
>  python/sepolicy/sepolicy.py | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy.py
> b/python/sepolicy/sepolicy.py
> index 5bf9b526..141f64ec 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -241,19 +241,13 @@ def generate_custom_usage(usage_text,
> usage_dict):
>  
>      return usage_text
>  
> -
> -def numcmp(val1, val2):
> +# expects formats:
> +# "22 (sshd_t)", "80, 8080 (httpd_t)", "all ports (port_type)"
> +def port_string_to_num(val):
>      try:
> -        v1 = int(val1.split(",")[0].split("-")[0])
> -        v2 = int(val2.split(",")[0].split("-")[0])
> -        if v1 > v2:
> -            return 1
> -        if v1 == v2:
> -            return 0
> -        if v1 < v2:
> -            return -1
> +        return int(val.split(" ")[0].split(",")[0].split("-")[0])
>      except:
> -        return cmp(val1, val2)
> +        return 99999999
>  
>  
>  def _print_net(src, protocol, perm):
> @@ -273,7 +267,7 @@ def _print_net(src, protocol, perm):
>                      port_strings.append("%s (%s) %s" % (",
> ".join(recs), t, boolean_text))
>                  else:
>                      port_strings.append("%s (%s)" % (",
> ".join(recs), t))
> -        port_strings.sort(numcmp)
> +        port_strings.sort(key=lambda param:
> port_string_to_num(param))
>          for p in port_strings:
>              print("\t" + p)
>  
