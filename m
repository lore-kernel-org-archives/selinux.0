Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4GBk1I4022831
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 07:46:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4GBjfl5028376
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 11:45:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4GBjfNc028373
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 11:45:41 GMT
Subject: Re: about type_change and type_transition
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Giorgio Zanin <selinux_list@yahoo.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3EC4BCAA.70509@yahoo.it>
References: <3EC4BCAA.70509@yahoo.it>
Content-Type: text/plain
Message-Id: <1053085559.4729.794.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 May 2003 07:45:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-05-16 at 06:25, Giorgio Zanin wrote:
> is it correct to argue that
> type_transition program the security server to provide a cetain SID (or 
> better, a labelling decision)  for labelling process and objects created 
> by legacy applications
> type_change does the same thing but for security aware applications

No.  You are correct that type_transition defines a default labeling
behavior for the case where an application uses the ordinary API call
(e.g. execve, open, mkdir, etc).  Note that type_transition does NOT
authorize anything; you need to authorize the transition via appropriate
allow rules, and you'll see macros in the example policy that provide
common combinations of type_transition and allow rules, e.g.
domain_auto_trans, file_type_auto_trans.  type_change has a different
purpose; it defines a relabeling behavior for situations where a
security-aware application needs to relabel an object based on the
security context of a user process and the existing context of the
object, e.g. when login, newrole, or sshd relabels the tty for the user
shell.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
