Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GIigXf023843
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 13:44:43 -0500 (EST)
Received: from e36.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GIhZlk017896
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 18:43:35 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0GIifdu004448
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 13:44:41 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0GIknwL173558
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 11:46:49 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0GIieFD023541
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 11:44:40 -0700
Date: Mon, 16 Jan 2006 12:44:39 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: sereference: screen policy
Message-ID: <20060116184439.GC15246@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com> <1137168771.29815.211.camel@sgc> <20060113222226.GD26911@sergelap.austin.ibm.com> <1137427147.29815.232.camel@sgc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137427147.29815.232.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> The rule for the user's own terminal should be in.  I don't know if we
> should trust screen to use all terminals.
> 
> > 	allow $1_screen_t tty_device_t:lnk_file read;
> 
> Looks like a mislabeled symlink.  Currently the symlinks in /dev are all
> device_t, as far as I know.  Looking at terminal.fc, everything is
> marked -c (with the exception of /dev/pts directory which is -d), so I'm
> not sure how this would happen.
> 
> > Note that I also still need my other patch for local logins from Jan 11.
> 
> Ok, I'll go back and look at it.  The response you made to your email
> made me think it wasn't actually needed.

Ah, ok, I added a line to terminal.fc in my login patch to label my
/dev/ttyS1 as tty_device_t:

+/dev/.*tty[^/]*                -l gen_context(system_u:object_r:tty_device _t,s0)

Let me see if removing that lets me still log in, and if so I guess I
may not need

> > 	allow $1_screen_t tty_device_t:lnk_file read;

in the screen template.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
