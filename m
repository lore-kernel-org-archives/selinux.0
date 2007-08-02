Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JYOjk019487
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:34:24 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l72JYMev025156
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:34:22 GMT
Subject: Re: Pattern patch.  I believe this is a cut and paste error
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B22F59.7070502@redhat.com>
References: <46B22F59.7070502@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 19:33:59 +0000
Message-Id: <1186083239.4015.97.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:24 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/support/file_patterns.spt     2007-05-29 14:10:59.000000000 -0400
> +++ serefpolicy-3.0.5/policy/support/file_patterns.spt  2007-08-02 11:02:03.000000000 -0400
> @@ -310,47 +310,47 @@
>  #
>  define(`getattr_sock_files_pattern',`
>         allow $1 $2:dir search_dir_perms;
> -       allow $1 $3:sock_file getattr_fifo_file_perms;
> +       allow $1 $3:sock_file getattr_sock_file_perms;
>  ')

Just happened to fix this in trunk on Tuesday.

http://oss.tresys.com/projects/refpolicy/changeset/2383

>  define(`setattr_sock_files_pattern',`
>         allow $1 $2:dir search_dir_perms;
> -       allow $1 $3:sock_file setattr_fifo_file_perms;
> +       allow $1 $3:sock_file setattr_sock_file_perms;
>  ')
>  
>  define(`read_sock_files_pattern',`
>         allow $1 $2:dir search_dir_perms;
> -       allow $1 $3:sock_file read_fifo_file_perms;
> +       allow $1 $3:sock_file read_sock_file_perms;
>  ')
>  
>  define(`write_sock_files_pattern',`
>         allow $1 $2:dir search_dir_perms;
> -       allow $1 $3:sock_file write_fifo_file_perms;
> +       allow $1 $3:sock_file write_sock_file_perms;
>  ')
>  
>  define(`rw_sock_files_pattern',`
>         allow $1 $2:dir search_dir_perms;
> -       allow $1 $3:sock_file rw_fifo_file_perms;
> +       allow $1 $3:sock_file rw_sock_file_perms;
>  ')
>  
>  define(`create_sock_files_pattern',`
>         allow $1 $2:dir add_entry_dir_perms;
> -       allow $1 $3:sock_file create_fifo_file_perms;
> +       allow $1 $3:sock_file create_sock_file_perms;
>  ')
>  
>  define(`delete_sock_files_pattern',`
>         allow $1 $2:dir del_entry_dir_perms;
> -       allow $1 $3:sock_file delete_fifo_file_perms;
> +       allow $1 $3:sock_file delete_sock_file_perms;
>  ')
>  
>  define(`rename_sock_files_pattern',`
>         allow $1 $2:dir rw_dir_perms;
> -       allow $1 $3:sock_file rename_fifo_file_perms;
> +       allow $1 $3:sock_file rename_sock_file_perms;
>  ')
>  
>  define(`manage_sock_files_pattern',`
>         allow $1 $2:dir rw_dir_perms;
> -       allow $1 $3:sock_file manage_fifo_file_perms;
> +       allow $1 $3:sock_file manage_sock_file_perms;
>  ')
>  
>  define(`relabelfrom_sock_files_pattern',`
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
