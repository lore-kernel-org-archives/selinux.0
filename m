Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24368
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 14:00:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA22939
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:00:23 GMT
Received: from pmesmtp02.wcom.com (pmesmtp02.wcom.com [199.249.20.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA22935
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:00:22 GMT
Received: from CONVERSION-DAEMON by firewall.wcom.com (PMDF V5.2-32 #42257)
 id <0GPZ00001U541C@firewall.wcom.com> for selinux@tycho.nsa.gov; Tue,
 15 Jan 2002 19:00:40 +0000 (GMT)
Date: Tue, 15 Jan 2002 12:59:45 -0600
From: "Christopher A. Martin" <christopher.a.martin@wcom.com>
Subject: RE: General Users
In-reply-to: 
 <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com>
To: "'Westerman, Mark'" <Mark.Westerman@csoconline.com>, selinux@tycho.nsa.gov
Cc: sds@tislabs.com
Reply-to: christopher.a.martin@wcom.com
Message-id: <002401c19df6$ccbf76a0$d2e123a6@rccc6131.mcit.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would LDAP be a candidate for this...pointing the policy lookup to
directories?

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov
> [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Westerman, Mark
> Sent: Tuesday, January 15, 2002 8:22 AM
> To: selinux@tycho.nsa.gov
> Cc: 'sds@tislabs.com'
> Subject: General Users
>
>
> The current implementation of SELinux requires each user to
> be listed in the
> user policy file
> and the default_context. This is great for single purpose server and
> workstation machines.
> I am currently look at a project that will require hundreds
> of machines and
> thousands of users. The user name and password are propagated
> thru NIS. With
>
> the current implement of SELinux this makes the management of
> the machines
> non-workable. Requires to much system administration. User
> are added and
> removed on a regular basis. We cannot rebuild a policy file
> for each machine
> for the
> addition or removal of a user.
>
>
> What would be the best way to modify the current implement to create a
> standard
> user. I was thinking of setting up a standard user for the
> user policy file
> and
> for the default context in the /etc/security (cron and default). I am
> looking at modifying
> the libsecure to look at the user, if the user is not found in the
> default_context file
> then assign him the standard user context.
>
>
> Any suggestions would be great.
>
>
> Mark Westerman
>
> --
> You have received this message because you are subscribed to
> the selinux list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
