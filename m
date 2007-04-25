Message-ID: <462FA117.3070203@manicmethod.com>
Date: Wed, 25 Apr 2007 14:42:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Man page fixes for semanage.  Add SELinux so whatis will pick
 it up
References: <462F6FCE.3010806@redhat.com>
In-Reply-To: <462F6FCE.3010806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> ------------------------------------------------------------------------
>
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_bool.3 libsemanage-2.0.0/man/man3/semanage_bool.3
> --- nsalibsemanage/man/man3/semanage_bool.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_bool.3	2007-03-17 09:09:50.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_bool 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Policy Booleans Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/boolean_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_bool_set_active.3 libsemanage-2.0.0/man/man3/semanage_bool_set_active.3
> --- nsalibsemanage/man/man3/semanage_bool_set_active.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_bool_set_active.3	2007-03-17 09:09:13.000000000 -0400
> @@ -1,7 +1,7 @@
>  .TH semanage_bool_set_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  .SH "NAME"
>  .B semanage_bool_set_active \- 
> -update an existing boolean in the currently active policy
> +update an existing SELinux boolean in the currently active policy
>  
>  .SH "SYNOPSIS"
>  .B #include <semanage/booleans_active.h>
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_count.3 libsemanage-2.0.0/man/man3/semanage_count.3
> --- nsalibsemanage/man/man3/semanage_count.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_count.3	2007-03-17 09:08:40.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_count 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following count function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_del.3 libsemanage-2.0.0/man/man3/semanage_del.3
> --- nsalibsemanage/man/man3/semanage_del.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_del.3	2007-03-17 09:08:29.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_del 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following delete function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_exists.3 libsemanage-2.0.0/man/man3/semanage_exists.3
> --- nsalibsemanage/man/man3/semanage_exists.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_exists.3	2007-03-17 09:08:21.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_exists 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following exists function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_fcontext.3 libsemanage-2.0.0/man/man3/semanage_fcontext.3
> --- nsalibsemanage/man/man3/semanage_fcontext.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_fcontext.3	2007-03-17 09:08:09.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_fcontext 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux File Context Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/fcontext_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_iface.3 libsemanage-2.0.0/man/man3/semanage_iface.3
> --- nsalibsemanage/man/man3/semanage_iface.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_iface.3	2007-03-17 09:07:46.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_iface 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Network Interfaces Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/iface_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_iterate.3 libsemanage-2.0.0/man/man3/semanage_iterate.3
> --- nsalibsemanage/man/man3/semanage_iterate.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_iterate.3	2007-03-17 09:07:10.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_iterate 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following iterate function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_list.3 libsemanage-2.0.0/man/man3/semanage_list.3
> --- nsalibsemanage/man/man3/semanage_list.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_list.3	2007-03-17 09:06:54.000000000 -0400
> @@ -1,7 +1,10 @@
> -.TH semanage_list 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
> +.TH semanage_list 3 "16 March 2006" "ivg2@cornell.edu" "SELinux managent API documentation"
> +
> +.SH "NAME" 
> +SELinux Lists Management API
>  
>  .SH "SYNOPSIS"
> -The following list function is supported for any semanage record.
> +The following list function is supported for any SELinux managent record.
>  .br
>  Replace the function and object name as necessary.
>  
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_modify.3 libsemanage-2.0.0/man/man3/semanage_modify.3
> --- nsalibsemanage/man/man3/semanage_modify.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_modify.3	2007-03-17 09:06:23.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_modify 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following modify function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_node.3 libsemanage-2.0.0/man/man3/semanage_node.3
> --- nsalibsemanage/man/man3/semanage_node.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_node.3	2007-03-17 09:06:05.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_node 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Network Nodes Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/node_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_port.3 libsemanage-2.0.0/man/man3/semanage_port.3
> --- nsalibsemanage/man/man3/semanage_port.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_port.3	2007-03-17 09:05:34.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_port 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Network Ports Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/port_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_query.3 libsemanage-2.0.0/man/man3/semanage_query.3
> --- nsalibsemanage/man/man3/semanage_query.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_query.3	2007-03-17 09:05:06.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_query 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux Management API
> +
>  .SH "SYNOPSIS"
>  The following query function is supported for any semanage record.
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_seuser.3 libsemanage-2.0.0/man/man3/semanage_seuser.3
> --- nsalibsemanage/man/man3/semanage_seuser.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_seuser.3	2007-03-17 09:04:38.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_seuser 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +Linux UID to SELinux User Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/seuser_record.h>
>  .br
> diff --exclude-from=exclude -N -u -r nsalibsemanage/man/man3/semanage_user.3 libsemanage-2.0.0/man/man3/semanage_user.3
> --- nsalibsemanage/man/man3/semanage_user.3	2006-11-16 17:14:05.000000000 -0500
> +++ libsemanage-2.0.0/man/man3/semanage_user.3	2007-03-17 09:03:36.000000000 -0400
> @@ -1,5 +1,8 @@
>  .TH semanage_user 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
>  
> +.SH "NAME" 
> +SELinux User Management API
> +
>  .SH "SYNOPSIS"
>  .B #include <semanage/user_record.h>
>  .br
>   
Acked-By: Joshua Brindle <method@manicmethod.com> for stable/1_0 and trunk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
