Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ICfTRb000859
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 08:41:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ICfQAR016162
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:41:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4ICfQHn016159 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:41:26 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040518104026.GC24333@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
Content-Type: text/plain
Message-Id: <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 08:40:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 06:40, Luke Kenneth Casson Leighton wrote:
> from the list, below, i've removed me editing syslog as root without
> doing newrole -r system_r :)

sysadm_r, not system_r.

> 	allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
> 	allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };
> 
> i mean, i see in domains/programs/xdm.te that there _are_
> allow initrc_t xdm_rw_etc_t permissions for create (create_file_perms)
> and also a comment that init scripts want to check for update
> windowmanagerlist so they get getattr and read allowed.
> 
> ... so what's going on?? why am i getting these messages?

In the upstream policy, I see:
$ grep 'allow initrc_t xdm_rw_etc_t' policy.conf
allow initrc_t xdm_rw_etc_t:file { getattr read };

So initrc_t is presently only allowed to stat and read those files. 
Now, there are other rules for xdm_t:
$ grep 'allow xdm_t xdm_rw_etc_t' policy.conf
allow xdm_t xdm_rw_etc_t:dir { read getattr lock search ioctl add_name remove_name write };
allow xdm_t xdm_rw_etc_t:file { create ioctl read getattr lock write setattr append link unlink rename };

And the xdm.te source file does have a comment prior to the
corresponding source statements that says that this is for wdm.
But perhaps someone erred and submitted the wrong rules for wdm (we
don't use it ourselves).

> if i am using wdm (the patched version) is there anything i need to
> do to get it to work / be accepted?

Don't know, as I've never used it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
