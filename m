Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KKkVWt022868
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:46:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KKkUmR029795
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:46:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9KKkUjp029792 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:46:30 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F944118.80809@redhat.com>
References: <200310200148.15852.russell@coker.com.au>
	 <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
	 <3F944118.80809@redhat.com>
Content-Type: text/plain
Message-Id: <1066682781.22196.398.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 16:46:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 16:10, Daniel J Walsh wrote:
> I don-t believe that would not re-start the rc.sysinit process in the
> correct context.

What if we were to replace the sysinit entry in /etc/inittab with one
that ran a new script that mounts selinuxfs, loads the policy, and runs
'telinit u' to restart init in the correct domain, and add a bootwait
entry to /etc/inittab that runs the ordinary rc.sysinit script?  In that
case, init should run the new script that loads the policy, re-exec
itself into the right domain due to the telinit -u command, and then
proceed to run the rc.sysinit script.  Or this might even work with two
sysinit entries, as long as they are executed in the right order.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
