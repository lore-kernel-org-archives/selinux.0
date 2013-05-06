Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46DtxRw020151
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 09:55:59 -0400
Message-ID: <5187B668.5010903@tresys.com>
Date: Mon, 6 May 2013 09:55:52 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: <selinux@tycho.nsa.gov>
Subject: Re: redhat1 polcap (was Re: [PATCH 1/1] Add SELinux policy capability
 for always checking packet and peer classes.)
References: <1367586339-12509-1-git-send-email-cpebenito@tresys.com> <20130503181140.GC22935@siphos.be>
In-Reply-To: <20130503181140.GC22935@siphos.be>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/03/13 14:11, Sven Vermeulen wrote:
> On Fri, May 03, 2013 at 09:05:39AM -0400, Chris PeBenito wrote:
> [...]
>> Includes definition of "redhat1" SELinux policy capability, which
>> exists in the SELinux userpace library, to keep ordering correct.
>>
>> The SELinux userpace portion of this was merged last year, but this kernel
>> change fell on the floor.
> 
> Would it make sense to rename the "redhat1" capability as "ptrace_child" or
> so? The name "redhat1" seems quite different from the other ones
> (network_peer_controls, open_perms, always_check_network).

The name matches what is in libsepol.  So if we change libsepol we can also change this.

> Also, what is that about?

Not sure which item you're asking about.


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
