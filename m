Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9G5agWt000858
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:36:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9G5aY0p019792
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 05:36:34 GMT
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by jazzswing.ncsc.mil  with ESMTP id h9G5aXr7019789
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 05:36:33 GMT
Date: Wed, 15 Oct 2003 22:35:31 -0700
From: Michael Reilly <michaelr@cisco.com>
To: Diyab <diyab@diyab.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: setfiles and /home labeling
Message-Id: <20031015223531.70abb76a.michaelr@cisco.com>
In-Reply-To: <3F8DFEA3.5000701@diyab.net>
References: <20031015160109.7fbdbb12.michaelr@cisco.com>
	<3F8DFEA3.5000701@diyab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you.  I do not have the original 1.2 policy file here so I do not know if I added the extra / or if it was already there when I changed the name from jadmin to michaelr.

michael
On Wed, 15 Oct 2003 22:12:51 -0400
Diyab <diyab@diyab.net> wrote:

> Michael Reilly wrote:
> > I know I am missing something.  These are all of the lines from
> > file_contexts which reference the /home directories.  Notice the two lines
> > which reference /home/michaelr.  After running make relabel /home/michaelr
> > is labeled system_u:object_r:user_home_dir_t instead of
> > system_u:object_r:staff_home_dir_t and all of the files in /home/michaelr
> > and below (except the files special cased like .ssh, etc.) are labeled
> > system_u:object_r:user_home_t.
> > 
> > Why are the two lines for /home/michaelr being ignored?  What am I doing
> > wrong?
> > 
> > Thanks,
> > 
> > michael
> > # Ordinary user home directories.
> > /home				system_u:object_r:home_root_t
> > /home/[^/]+	-d		system_u:object_r:user_home_dir_t
> > /home/[^/]+/.+			system_u:object_r:user_home_t
> > # Other staff home directories, replace "jadmin" with appropriate name
> > /home/michaelr/(/.*)?		system_u:object_r:staff_home_t
> > /home/michaelr			system_u:object_r:staff_home_dir_t
> 
> You have an extra / in the staff_home_t declaration.  Change it to read 
> like this:
> 
> /home/michaelr(/.*)?		system_u:object_r:staff_home_t
> 
> Timothy,
> 
> -- 
> I put instant coffee in a microwave and almost went back in time.
> 		-- Steven Wright


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
