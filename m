Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBG4djRb023711
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 23:39:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBG4ctk1027339
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 04:38:56 GMT
Date: Tue, 16 Dec 2003 13:39:40 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: ynakam@ori.hitachi-sk.co.jp, selinux@tycho.nsa.gov, russell@coker.com.au,
   hdholm@epoch.ncsc.mil
Subject: Re: log_domain macro
Message-Id: <20031216133940.568e9795.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <1071503117.28044.76.camel@moss-spartans.epoch.ncsc.mil>
References: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
	<1071503117.28044.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > define(`append_log_domain', `
> > type $1_log_t, file_type, sysadmfile, logfile;
> > allow $1_t var_log_t:dir rw_dir_perms;
> > allow $1_t $1_log_t:file  { create ra_file_perms };
> > type_transition $1_t var_log_t:file $1_log_t;
> BTW, you might want to reduce the directory permissions in the above
> macro to ra_dir_perms, since there is no reason to allow the domain to
> remove files from the directory in that case.

As you say, "remove_name" granted by rw_dir_perms is not necessary.
So the following is better.

define(`append_log_domain', `
type $1_log_t, file_type, sysadmfile, logfile;
allow $1_t var_log_t:dir ra_dir_perms;
allow $1_t $1_log_t:file  { create ra_file_perms };
type_transition $1_t var_log_t:file $1_log_t;
')

> Note that there is a create_append_log_file() macro in core_macros.te 
> that is used by syslogd_t and bootloader_t, 

In apache.te logdir_domain macro is used, 
but create_append_log_file will be prefered.
Because in FedoraCore1, apache create log files on its own directory(/var/log/httpd/).

append_log_domain macro will be useful when a daemon creates its own log file on  /var/log/.

----
Yuichi Nakamura


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
