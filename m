To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180301105945.15587-1-vmojzis@redhat.com>
 <20180301110306.16715-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2006497e-9be2-2722-d902-2cf8b6b5c7da@tycho.nsa.gov>
Date: Thu, 1 Mar 2018 09:49:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180301110306.16715-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] gui/fcontextPage: Set default object class in addDialog
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/01/2018 06:03 AM, Vit Mojzis wrote:
> This ensures that user cannot leave the object class selection blank.

Thanks, applied both your previous gui/semanagePage patch and this one.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  gui/fcontextPage.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index a6577ef7..370bbee4 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -164,6 +164,7 @@ class fcontextPage(semanagePage):
>          self.fcontextEntry.set_text("")
>          self.fcontextEntry.set_sensitive(True)
>          self.fcontextFileTypeCombo.set_sensitive(True)
> +        self.fcontextFileTypeCombo.set_active(0)
>          self.fcontextTypeEntry.set_text("")
>          self.fcontextMLSEntry.set_text("s0")
>  
> 
