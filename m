Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24401
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 14:03:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA17713
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:02:30 GMT
Received: from orngca-mls01.socal.rr.com (orngca-mls01.socal.rr.com [66.75.160.16])
	by jazzband.ncsc.mil  with ESMTP id TAA17705
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:02:29 GMT
Message-ID: <000c01c19df7$c08d4050$5357a518@hproject>
From: "Donald Kasper" <kasper@1stconnect.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, <selinux@tycho.nsa.gov>
Cc: <sds@tislabs.com>
References: <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com>
Subject: Re: General Users
Date: Tue, 15 Jan 2002 11:06:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You need a profile manager that is network aware.  See the Common Operating
Environment (COE) DISA project, Account Profile Management (APM) utility to
see how they do it.  NSA uses the COE, so its not foreign to them either.
Donald Kasper

----- Original Message -----
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: <selinux@tycho.nsa.gov>
Cc: <sds@tislabs.com>
Sent: Tuesday, January 15, 2002 6:21 AM
Subject: General Users


> The current implementation of SELinux requires each user to be listed in
the
> user policy file
> and the default_context. This is great for single purpose server and
> workstation machines.
> I am currently look at a project that will require hundreds of machines
and
> thousands of users. The user name and password are propagated thru NIS.
With
>
> the current implement of SELinux this makes the management of the machines
> non-workable. Requires to much system administration. User are added and
> removed on a regular basis. We cannot rebuild a policy file for each
machine
> for the
> addition or removal of a user.
>
>
> What would be the best way to modify the current implement to create a
> standard
> user. I was thinking of setting up a standard user for the user policy
file
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
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
