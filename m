Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9D96dWt013196
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 05:06:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9D96X0p021736
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 09:06:33 GMT
Received: from johanna5.ux.his.no (johanna5.ux.his.no [152.94.1.25])
	by jazzswing.ncsc.mil  with ESMTP id h9D96Wr7021733
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 09:06:32 GMT
Received: from me (badne3.ux.his.no [152.94.1.63])
	by johanna5.ux.his.no (8.12.10/8.12.10) with SMTP id h9D96SQ7020311
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 11:06:29 +0200 (MET DST)
Date: Mon, 13 Oct 2003 13:06:26 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Users are not assigned correct security context on login
Message-ID: <20031013110626.GA10270@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've configured the users file like this:
user system_u roles system_r;
user user_u roles user_r;
user root roles { sysadm_r staff_r };
user test roles { sysadm_r staff_r };

(Doing a "make policy" shows "security: 4 users ...")

However, after doing a "make reload", rebooting and logging in as root,
"id" shows this:
uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:user_t

... "newrole -r sysadm_r" shows this:
Cannot find your entry in the passwd file.
... and "newrole -r sysadm_u" shows this:
Couldn't get default type.

I put some printf's into newrole.c, and the reason newrole didn't find
root in the passwd file, was because context_user_get() didn't return
"root" as username ("" was returned).

Am I doing an obvious mistake somewhere here? Or might it be that login
is buggy and cannot set the correct security context?
Is it a problem that id doesn't show any SID?

Regards,
	Erlend Aasland

P.S:
I'm able to correctly change the context of programs and files (I've
been able to configure the system such that no avc-warnings appear
during bootup).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
