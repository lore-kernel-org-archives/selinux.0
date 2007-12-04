Subject: Re: PATCH: audit format mismatch for inode number
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200712041901.lB4J1jhU019364@cadmus.columbia.tresys.com>
References: <200712041901.lB4J1jhU019364@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 15:09:42 -0500
Message-Id: <1196798982.7491.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-04 at 14:01 -0500, Todd C. Miller wrote:
> i_ino is unsigned.  We recently saw an audit message with a negative
> inode number in procfs due to this.

http://marc.info/?l=git-commits-head&m=118427505410046&w=2

>  - todd
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
> 
> ---
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index e4396a8..e233a3d 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -586,7 +586,7 @@ void avc_audit(u32 ssid, u32 tsid,
>  				}
>  			}
>  			if (inode)
> -				audit_log_format(ab, " dev=%s ino=%ld",
> +				audit_log_format(ab, " dev=%s ino=%lu",
>  						 inode->i_sb->s_id,
>  						 inode->i_ino);
>  			break;
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
