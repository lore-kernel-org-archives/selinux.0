Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27403
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 11:33:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0SGXJI22658
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 16:33:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0SGXJf22654 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 16:33:19 GMT
Message-Id: <200301281640.LAA01157@moss-shockers.ncsc.mil>
Date: Tue, 28 Jan 2003 11:40:37 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: run_init policy
To: selinux@tycho.nsa.gov, wsalamon@tislabs.com, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>   The question is this: Would it be better to change the above line to
> run_program(sysadm_t, sysadm_r, init, {initrc_exec_t etc_t}, initrc_t)
> 
>   or, change the types on the rc files in /etc/init.d, /etc/rc?.d?
> The initrc_t has execute permission on those types.  Is there a reason we
> keep the mass of rc files typed as etc_t?

The latter (assign initrc_exec_t to the other rc files).  This is reasonable
since any one of the files can be used as the entrypoint to the initrc_t
domain when run_init is used.  Originally, we only assigned initrc_exec_t
to the scripts directly executed by init, since only those scripts served
as entrypoints to the domain.  With run_init, any of the scripts may be
an entrypoint.
  
--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
