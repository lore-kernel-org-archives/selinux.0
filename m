Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFFsaRb020545
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 10:54:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBFFsZpn026910
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 15:54:35 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBFFsZab026904 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 15:54:35 GMT
Subject: Re: log_domain macro
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Howard Holm <hdholm@epoch.ncsc.mil>
In-Reply-To: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
References: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
Content-Type: text/plain
Message-Id: <1071503660.28044.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 10:54:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-15 at 05:02, Yuichi Nakamura wrote:
> Many daemons only need append permission to log files.
> I think macro such as following is necessary.
> 
> define(`append_log_domain', `
> type $1_log_t, file_type, sysadmfile, logfile;
> allow $1_t var_log_t:dir rw_dir_perms;
> allow $1_t $1_log_t:file  { create ra_file_perms };
> type_transition $1_t var_log_t:file $1_log_t;

BTW, you might want to reduce the directory permissions in the above
macro to ra_dir_perms, since there is no reason to allow the domain to
remove files from the directory in that case.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
