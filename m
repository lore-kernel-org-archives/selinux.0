Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFFjiRb020437
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 10:45:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBFFitjx007988
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 15:44:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBFFirSR007982
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 15:44:54 GMT
Subject: Re: log_domain macro
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Howard Holm <hdholm@epoch.ncsc.mil>
In-Reply-To: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
References: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
Content-Type: text/plain
Message-Id: <1071503117.28044.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 10:45:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-15 at 05:02, Yuichi Nakamura wrote:
> In log_domain macro,
> file_type_auto_trans($1_t, var_log_t, $1_log_t, file)
> is described.
> 
> By file_type_auto_trans, $1_t can write(unlink) $1_log_t.
> 
> If attackers obtains the domain where log_domain macro is used, 
> attackers can erase log file.
> 
> Many daemons only need append permission to log files.
> I think macro such as following is necessary.
> 
> define(`append_log_domain', `
> type $1_log_t, file_type, sysadmfile, logfile;
> allow $1_t var_log_t:dir rw_dir_perms;
> allow $1_t $1_log_t:file  { create ra_file_perms };
> type_transition $1_t var_log_t:file $1_log_t;
> ')

This sounds reasonable.  Note that there is a create_append_log_file()
macro in core_macros.te that is used by syslogd_t and bootloader_t, but
it acts on an existing log type and does not include a type declaration
or type_transition rule.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
