Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03Lmt5N012929
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 16:48:55 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03LndV2000949
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 21:49:40 GMT
Date: Wed, 3 Jan 2007 15:48:37 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
Message-ID: <20070103214837.GB21450@w-m-p.com>
References: <459BDFD4.7080903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <459BDFD4.7080903@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 03, 2007 at 11:54:44AM -0500, Daniel J Walsh wrote:
> sudo reads netlink_route_socket,  wants to look at the kernel key ring, 
> stores a token in the pam_pid directory, and needs to getattr on all 
> "user" executables.
> 
> Some changes to su in order to handle key rings,  Needs 
> mls_file_write_down.  Need to be able to su from different domains, and 
> pam_rootok causes some selinux_compute_access checks.
[...]
> sshd wants to look at kernel key ring
[...]
> fixes for authlogin handling of keyrings and mls, as well as pcscd

I'm confused about what kernel keyring features are currently available
in the current policy, and who gets to use them.

For the Common Criteria configuration, we had been assuming that the
kernel keyring feature would be unavailable for unprivileged users, so
that we can avoid the need to do MLS testing on keyring objects. Is that
still the case?

If not, an alternative would be to provide a boolean to disable keyring
access for the evaluated configuration. I had originally proposed that
(subject "[PATCH] Add boolean controlling user access to kernel keyring"
on this list back in August) based on a misunderstanding, it wasn't
actually necessary back then. I just wanted to make sure that the feature
isn't sneaking in now...

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
