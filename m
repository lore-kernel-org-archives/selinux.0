Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, dhowells@redhat.com
In-Reply-To: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
References: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 May 2006 08:31:36 -0400
Message-Id: <1148646696.20976.191.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 12:50 -0400, Michael LeMay wrote:
> diff -uprN -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3.orig/security/selinux/include/avc.h linux-2.6.17-rc4-mm3/security/selinux/include/avc.h
> --- linux-2.6.17-rc4-mm3.orig/security/selinux/include/avc.h	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm3/security/selinux/include/avc.h	2006-05-24 11:13:15.000000000 -0400
> @@ -43,6 +43,7 @@ struct avc_audit_data {
>  #define AVC_AUDIT_DATA_NET  2
>  #define AVC_AUDIT_DATA_CAP  3
>  #define AVC_AUDIT_DATA_IPC  4
> +#define AVC_AUDIT_DATA_KEY  5
>  	struct task_struct *tsk;
>  	union 	{
>  		struct {

This looks like a leftover from the prior version of the patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
