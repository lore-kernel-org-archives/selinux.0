Date: Thu, 24 Mar 2005 11:06:34 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050324110634.GD13372@lkcl.net>
References: <4236CC03.5010104@kaigai.gr.jp> <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil> <4237B950.2090604@ak.jp.nec.com> <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil> <42394ECA.7010204@ak.jp.nec.com> <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil> <42399AE4.5040508@kaigai.gr.jp> <423E9CFF.3080808@kaigai.gr.jp> <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil> <42412635.4030108@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42412635.4030108@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 23, 2005 at 05:17:57PM +0900, Kaigai Kohei wrote:

 kaigai,

 i love it.  i see where it's going.

 i just don't get it yet.

 :)

> Hi,
> 
> The attached (3rd) patch implements TYPEEXTENDS statement in addition
> to the latest patch. Because TYPE ... EXTENDS statements can not handle
> forwarding loopup, TYPEEXTENDS statement is necessary to represent
> inheritance-relationship not to depend on the definition placement.
> 
> TYPEEXTENDS <type-name> EXTENDS <type/attr>, <type/attr>, ... ;
> 
> (*) <type-name> and <type/attr> must have been defined.
> This is almost the same as TYPEATTRIBUTE.

>  # Access Samba shares.
> -allow smbd_t samba_share_t:dir create_dir_perms;
> -allow smbd_t samba_share_t:file create_file_perms;
> +attribute samba_share_path;
> +allow smbd_t samba_share_path:dir {getattr search};
> +allow smbd_t @samba_share_t:dir create_dir_perms;
> +allow smbd_t @samba_share_t:file create_file_perms;
> 

> o And, private additional configuration is as follows:
> --- /dev/null   2005-03-22 18:46:01.562514976 -0500
> +++ policy.kaigai/inaddition.te 2005-03-23 04:06:49.576548144 -0500
> @@ -0,0 +1,7 @@
> +# necessity for access path
> +typeattribute var_t ftp_content_path, samba_share_path;
> +typeattribute httpd_sys_content_t ftp_content_path, samba_share_path;
> +# definition of unified file type
> +type httpd_ftp_t extends httpd_sys_content_t, ftp_content_t;
> +type httpd_samba_t extends httpd_sys_content_t, samba_share_t;


 ... what's the difference between attribute and typeattribute?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
