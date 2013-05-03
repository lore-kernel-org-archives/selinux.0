Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43ICVJo022560
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 14:12:31 -0400
Received: by mail-wi0-f181.google.com with SMTP id ey16so886764wid.8
        for <selinux@tycho.nsa.gov>; Fri, 03 May 2013 11:12:28 -0700 (PDT)
Date: Fri, 3 May 2013 20:11:40 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Chris PeBenito <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: redhat1 polcap (was Re: [PATCH 1/1] Add SELinux policy capability
 for always checking packet and peer classes.)
Message-ID: <20130503181140.GC22935@siphos.be>
References: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 03, 2013 at 09:05:39AM -0400, Chris PeBenito wrote:
[...]
> Includes definition of "redhat1" SELinux policy capability, which
> exists in the SELinux userpace library, to keep ordering correct.
> 
> The SELinux userpace portion of this was merged last year, but this kernel
> change fell on the floor.

Would it make sense to rename the "redhat1" capability as "ptrace_child" or
so? The name "redhat1" seems quite different from the other ones
(network_peer_controls, open_perms, always_check_network).

Also, what is that about?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
