Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9G2CsWt000091
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 22:12:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9G2Ck0p010511
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 02:12:46 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id h9G2Cjr7010508
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 02:12:45 GMT
Message-ID: <3F8DFEA3.5000701@diyab.net>
Date: Wed, 15 Oct 2003 22:12:51 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Michael Reilly <michaelr@cisco.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: setfiles and /home labeling
References: <20031015160109.7fbdbb12.michaelr@cisco.com>
In-Reply-To: <20031015160109.7fbdbb12.michaelr@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael Reilly wrote:
> I know I am missing something.  These are all of the lines from
> file_contexts which reference the /home directories.  Notice the two lines
> which reference /home/michaelr.  After running make relabel /home/michaelr
> is labeled system_u:object_r:user_home_dir_t instead of
> system_u:object_r:staff_home_dir_t and all of the files in /home/michaelr
> and below (except the files special cased like .ssh, etc.) are labeled
> system_u:object_r:user_home_t.
> 
> Why are the two lines for /home/michaelr being ignored?  What am I doing
> wrong?
> 
> Thanks,
> 
> michael
> # Ordinary user home directories.
> /home				system_u:object_r:home_root_t
> /home/[^/]+	-d		system_u:object_r:user_home_dir_t
> /home/[^/]+/.+			system_u:object_r:user_home_t
> # Other staff home directories, replace "jadmin" with appropriate name
> /home/michaelr/(/.*)?		system_u:object_r:staff_home_t
> /home/michaelr			system_u:object_r:staff_home_dir_t

You have an extra / in the staff_home_t declaration.  Change it to read 
like this:

/home/michaelr(/.*)?		system_u:object_r:staff_home_t

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
