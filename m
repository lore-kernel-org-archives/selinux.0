Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KDNUWt019681
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:23:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KDNJ0p025997
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:23:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KDNIr7025993
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:23:18 GMT
Subject: Re: Number of roles reported by checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Faye Coker <faye@lurking-grue.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200310201900.27621.faye@lurking-grue.org>
References: <200310201900.27621.faye@lurking-grue.org>
Content-Type: text/plain
Message-Id: <1066656205.22196.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 09:23:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 05:00, Faye Coker wrote:
> Running checkpolicy shows I have 4 users and 5 roles:
> 
> faye@kaos:/etc/selinux$ checkpolicy
> checkpolicy:  loading policy configuration from policy.conf
> security:  4 users, 5 roles, 683 types
> security:  29 classes, 71806 rules
> 
> however, I can only see four roles:
> 
> faye@kaos:/etc/selinux$ grep ^role policy.conf|cut -f2 "-d "|sort -u
> staff_r
> sysadm_r
> system_r
> user_r
> 
> Any ideas as to why checkpolicy is reporting five roles, when I can only see 
> four?

You are forgetting the secret nsa_has_all_power role.  Oops, nevermind.
Actually, that would be the implicitly defined object_r role for objects
that is being counted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
