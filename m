Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1EOsRb006716
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:24:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1EO9p5003467
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:24:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hB1EO9t0003464
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:24:09 GMT
Subject: Re: policy problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031130183701.GA14242@wavehammer.waldi.eu.org>
References: <20031130183701.GA14242@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1070288686.12270.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:24:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-30 at 13:37, Bastian Blank wrote:
> - inetd don't get the correct domain. the correct policy, inetd.te is
>   included and the file is labeled correcly but the process remains in
>   initrc_t.
> | # ls -al --context /usr/sbin/inetd
> | -rwxr-xr-x  root     root     system_u:object_r:inetd_exec_t /usr/sbin/inetd
> | # ps aux | grep "[i]netd"
> | root       916  0.0  0.4  1624  540 ?        S    18:28   0:00 /usr/sbin/inetd
> | # cat /proc/916/attr/current;echo
> | system_u:system_r:initrc_t

Is there a 'type_transition initrc_t inetd_exec_t:process inetd_t;' rule
in your policy.conf file?  xinetd is running in inetd_t on my system.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
