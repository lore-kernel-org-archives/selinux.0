Message-ID: <52728595.4050404@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 12:30:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 01/01] Make yum/extract_rpms optional so that apt based
 systems can use tool
References: <1383235736-9740-1-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383235736-9740-1-git-send-email-dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/31/2013 12:08 PM, Dan Walsh wrote:
> ---
>  policycoreutils/sepolicy/sepolicy/generate.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
> index 15366c3..6b53035 100644
> --- a/policycoreutils/sepolicy/sepolicy/generate.py
> +++ b/policycoreutils/sepolicy/sepolicy/generate.py
> @@ -26,7 +26,6 @@ import re
>  import sepolicy
>  from sepolicy import get_all_types, get_all_attributes, get_all_roles
>  import time
> -import yum
>  
>  from templates import executable
>  from templates import boolean
> @@ -1252,6 +1251,7 @@ allow %s_t %s_t:%s_socket name_%s;
>  		return fcfile
>  
>          def __extract_rpms(self):
> +            import yum
>              yb = yum.YumBase()
>              yb.setCacheDir()
>  
> @@ -1293,7 +1293,10 @@ allow %s_t %s_t:%s_socket name_%s;
>                                  self.add_dir(fname)
>  
>          def gen_writeable(self):
> -            self.__extract_rpms()
> +            try:
> +                self.__extract_rpms()
> +            except ImportError:
> +                pass
>  
>              if os.path.isfile("/var/run/%s.pid"  % self.name):
>                  self.add_file("/var/run/%s.pid"  % self.name)
> 

I pushed this as policycoreutils-2.2.1 since it fixes a bug in using
sepolicy generate on non-yum-based distros.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
