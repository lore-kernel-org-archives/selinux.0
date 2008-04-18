Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3IGWXD9019804
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 12:32:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m3IGWTSg029417
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 16:32:32 GMT
Subject: Re: [refpolicy] RFC: hal_read_log interface
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: rob myers <rob.myers@gtri.gatech.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1208213525.31069.77.camel@rxm-581b.stl.gtri.gatech.edu>
References: <1208213525.31069.77.camel@rxm-581b.stl.gtri.gatech.edu>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 11:55:00 -0400
Message-Id: <1208534100.7113.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-04-14 at 18:52 -0400, rob myers wrote:
> While trying to create a domain that could read all the files
> in /var/log, I noticed that hald_log_t files do not have the logfile
> attribute.  This appears to be intentional because the
> logging_log_filetrans interface was used instead of the logging_log_file
> interface.  Is this still the intention?
> 
> Attached is a patch to add an interface to allow domains to read
> hald_log_t in case hald_log_t needs to remain a private type.

The filetrans interface is needed so that when hal creates it's log
in /var/log, it gets the correct type.  It should also have the log_file
interface too, since its a log file.  I changed hald_log_t to be a log
file.

However that doesn't necessarily mean that your patch is undesirable,
but I do have a comment:

> +interface(`hal_read_log',`
> +       gen_require(`
> +               type hald_log_t;
> +       ')
> +
> +       logging_search_logs($1)

> +       allow $1 hald_log_t:dir search_dir_perms;
> +       allow $1 hald_log_t:dir r_dir_perms;
> +       allow $1 hald_log_t:file read_file_perms;

Likely that you want to use read_files_pattern() instead of these three
lines.  If not, the list_dir_perms permission set on the directory would
be sufficient for the first two lines.

> +')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
