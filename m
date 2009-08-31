Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VCKaD8029182
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 08:20:36 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7VCJwXG004776
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 12:19:58 GMT
Message-ID: <4A9BBFF4.8010906@redhat.com>
Date: Mon, 31 Aug 2009 08:20:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Fernando Magro <seramal@gmail.com>
CC: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: vsftpd not changing security context while dropping privileges
References: <d5657ee80908301258g3ea39f87qe5a6b02f81027fbc@mail.gmail.com>
In-Reply-To: <d5657ee80908301258g3ea39f87qe5a6b02f81027fbc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/30/2009 03:58 PM, Fernando Magro wrote:
> Hi,
> 
> I noticed vsftpd starts running with UID 0 and MLS s0. When a user
> logs in, a new process is spawn (forked) from vsftpd and UID is
> changed to match the user. The problem is that MLS stays in s0, so if
> the user has a different MLS it will make everything fail. Starting
> vsftpd with s0-s0:c0.c1023 would be an option, but will then bypass
> per-user MLS security. So IMHO vsftpd should be patched to change
> security context when forking a new process.
> 
> You can reproduce the problem by running:
> # semanage user -m -r s0-s0:c0.c1023 user_u
> # groupadd testing
> # useradd -m -g testing -Z user_u testing
> # semanage login -m -r s0:c3 testing
> # chcon -R -l s0:c3 /home/testing
> # /etc/init.d/vsftpd start
> # lftp
> open -u testing,password localhost
> ls
> 
> Daniel Walsh said at https://bugzilla.redhat.com/show_bug.cgi?id=518569 :
> Lets bring this up for discussion on the SELinux list.
> 
> There are two possibilities, here,  One is to just change the level on the
> vstfpd process to run at the appropriate level of the user.  The second would
> be to change the type, in order to run as a type appropriate for the user.  IE
> With different privs then the vsftpd server.
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> 
> 
Fernando, I meant the Developers SELinux list which is selinux@tycho.nsa.gov

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
