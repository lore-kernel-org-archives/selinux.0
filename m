Message-ID: <55A7DC12.3020002@tycho.nsa.gov>
Date: Thu, 16 Jul 2015 12:30:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Set self.sename to sename after calling
 semanage_seuser_set_sename()
References: <1436893676-21412-1-git-send-email-bigon@debian.org>
In-Reply-To: <1436893676-21412-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=windows-1252
Cc: 734806@bugs.debian.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/14/2015 01:07 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> This fixes audit information that are being logged and a crash when the
> python-audit binding is not installed.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=734806

Thanks, applied.

> ---
>  policycoreutils/semanage/seobject.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index 568ebfd..2edb050 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -575,6 +575,7 @@ class loginRecords(semanageRecords):
>  
>  		if sename != "":
>  			semanage_seuser_set_sename(self.sh, u, sename)
> +                        self.sename = sename
>  		else:
>  			self.sename = self.oldsename
>  			
> 
