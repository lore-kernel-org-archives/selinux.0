Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46IiD5V006819
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 14:44:13 -0400
Received: by mail-we0-f174.google.com with SMTP id z2so3207608wey.5
        for <selinux@tycho.nsa.gov>; Mon, 06 May 2013 11:44:10 -0700 (PDT)
Date: Mon, 6 May 2013 20:43:18 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: redhat1 polcap (was Re: [PATCH 1/1] Add SELinux policy
 capability for always checking packet and peer classes.)
Message-ID: <20130506184317.GB26604@siphos.be>
References: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
 <20130503181140.GC22935@siphos.be>
 <5187B668.5010903@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5187B668.5010903@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 06, 2013 at 09:55:52AM -0400, Christopher J. PeBenito wrote:
> > Would it make sense to rename the "redhat1" capability as "ptrace_child" or
> > so? The name "redhat1" seems quite different from the other ones
> > (network_peer_controls, open_perms, always_check_network).
> 
> The name matches what is in libsepol.  So if we change libsepol we can also change this.
> 
> > Also, what is that about?
> 
> Not sure which item you're asking about.

The redhat1 capability; in libsepol it has a comment that sais "reserved for
RH testing of ptrace_child" but I don't seem to find any more references to
it.

What is the policy capability for (what does it do/enable)?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
