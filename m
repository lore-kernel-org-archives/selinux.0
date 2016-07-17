Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6HDKJfZ005071
 for <selinux@tycho.nsa.gov>; Sun, 17 Jul 2016 09:20:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id c199so13578137oig.1
 for <selinux@tycho.nsa.gov>; Sun, 17 Jul 2016 06:19:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468612513-28042-1-git-send-email-william.c.roberts@intel.com>
References: <1468612513-28042-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 17 Jul 2016 09:19:34 -0400
Message-ID: <CAHC9VhQK3d3_djXV1+20xLJo0crxAg=zDR46FgXUJv0QbfsO-w@mail.gmail.com>
Subject: Re: [PATCH] field-dictionary: add ioctlcmd
To: william.c.roberts@intel.com
Cc: sgrubb@redhat.com, linux-audit@redhat.com, seandroid-list@tycho.nsa.gov,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, Jul 15, 2016 at 3:55 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Per-request ioctlcmd controls were added to SE Linux, however
> the audit field dictionary was not updated.
>
> This patch updates that dictionary.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  specs/fields/field-dictionary.csv | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!

> diff --git a/specs/fields/field-dictionary.csv b/specs/fields/field-dictionary.csv
> index a645085..5a922e5 100644
> --- a/specs/fields/field-dictionary.csv
> +++ b/specs/fields/field-dictionary.csv
> @@ -82,6 +82,7 @@ inode,numeric,inode number,
>  inode_gid,numeric,group id of the inode's owner,
>  inode_uid,numeric,user id of the inode's owner,
>  invalid_context,encoded,SELinux context,
> +ioctlcmd,numeric,The request argument to the ioctl syscall,
>  ipx-net,numeric,IPX network number,
>  item,numeric,which item is being recorded,
>  items,numeric,the number of path records in the event,
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
