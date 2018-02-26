To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180222132933.5643-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <aaa79052-e646-716d-676f-d06554953b3f@tycho.nsa.gov>
Date: Mon, 26 Feb 2018 09:51:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180222132933.5643-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] gui/semanagePage: Close "edit" and "add" dialogues when
 successfull
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/22/2018 08:29 AM, Vit Mojzis wrote:
> "Edit" and "add" dialogues weren't closed after successful transaction
> ("add" and "edit" methods return "None" if successful).

I see the bug, but the behavior after applying the patch also seems to
be wrong:
Traceback (most recent call last):
  File "/usr/share/system-config-selinux/system-config-selinux.py", line
136, in add
    self.tabs[self.notebook.get_current_page()].addDialog()
  File "/usr/share/system-config-selinux/semanagePage.py", line 143, in
addDialog
    if self.add() is False:
  File "/usr/share/system-config-selinux/fcontextPage.py", line 192, in add
    ftype = list_model.get_value(it, 0)
TypeError: Argument 1 does not allow None as a value

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  gui/semanagePage.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gui/semanagePage.py b/gui/semanagePage.py
> index 560ec077..4127804f 100644
> --- a/gui/semanagePage.py
> +++ b/gui/semanagePage.py
> @@ -140,7 +140,7 @@ class semanagePage:
>  
>          while self.dialog.run() == Gtk.ResponseType.OK:
>              try:
> -                if not self.add():
> +                if self.add() is False:
>                      continue
>                  break
>              except ValueError as e:
> @@ -153,7 +153,7 @@ class semanagePage:
>          self.dialog.set_position(Gtk.WindowPosition.MOUSE)
>          while self.dialog.run() == Gtk.ResponseType.OK:
>              try:
> -                if not self.modify():
> +                if self.modify() is False:
>                      continue
>                  break
>              except ValueError as e:
> 
