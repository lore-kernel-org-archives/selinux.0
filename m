Subject: Re: [RFC]Tuning selinux_file_permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
In-Reply-To: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
References: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 09:41:00 -0400
Message-Id: <1188913260.5227.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-03 at 17:04 +0900, Yuichi Nakamura wrote:
> diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/hooks.c linux-2.6.22/security/selinux/hooks.c
> --- linux-2.6.22.orig/security/selinux/hooks.c	2007-07-09 08:32:17.000000000 +0900
> +++ linux-2.6.22/security/selinux/hooks.c	2007-09-03 14:31:54.000000000 +0900
> @@ -4642,6 +4699,7 @@ static int selinux_setprocattr(struct ta
>  	else
>  		return -EINVAL;
>  
> +	sid_serial_incr();
>  	return size;
>  }

Also, here you only want to increment if setting 'current', and only if
successful, so you want to move this up to where tsec->sid is updated
(two locations).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
