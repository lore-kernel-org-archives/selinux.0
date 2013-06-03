Message-ID: <1370288034.19018.1.camel@localhost>
Subject: Re: [RFC PATCH 1/2] selinux: merge selinux_inode_permission and
 inode_has_perm
From: Eric Paris <eparis@redhat.com>
To: torvalds@linux-foundation.org
Cc: sds@tycho.nsa.gov, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Date: Mon, 03 Jun 2013 15:33:54 -0400
In-Reply-To: <1370285941-18367-1-git-send-email-eparis@redhat.com>
References: <1370285941-18367-1-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-06-03 at 14:59 -0400, Eric Paris wrote:
> selinux_inode_permission had some heavy lifting done to make it more
> performance polite.  But it still does largely the same thing as
> inode_has_perm.  So move that work into inode_has_perm and call
> inode_has_perm from selinux_inode_permission.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  security/selinux/hooks.c | 92 ++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 50 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5c6f2cd..cfecb52 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

> @@ -1514,6 +1538,14 @@ static int inode_has_perm(const struct cred *cred,
>  	sid = cred_sid(cred);
>  	isec = inode->i_security;
>  
> +	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
> +	audited = avc_audit_required(perms, &avd, rc, dontaudit, &denied);
> +	if (likely(!audited))
> +		return rc;
> +
> +	rc2 = audit_inode_permission(inode, adp, perms, audited, denied, flags);
> +	if (rc2)
> +		return rc2;
>  	return avc_has_perm_flags(sid, isec->sid, isec->sclass, perms, adp, flags);
>  }
>  

Should just return rc, not avc_has_perm_flags().  I fixed that in the
2/2 patch and this should work just fine.  Kills a little performance,
but still works.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
