Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RIvhRb005680
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 13:57:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1RIvdQS017502
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 18:57:41 GMT
Subject: Re: SELinux and NFS --- a bit of a fight!
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1077904791.26543.77.camel@moss-spartans.epoch.ncsc.mil>
References: <1077903498.30334.12.camel@sisko.scot.redhat.com>
	 <1077904791.26543.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1077908253.30334.54.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 27 Feb 2004 18:57:33 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, 2004-02-27 at 17:59, Stephen Smalley wrote:
> On Fri, 2004-02-27 at 12:38, Stephen C. Tweedie wrote:
> > I'm not convinced that this is the absolute best solution, but I can't
> > see any cleaner methods off-hand.
> 
> The policy already has a rule in can_network() to allow domains to share
> a socket created by mount:
> allow $1 mount_t:udp_socket rw_socket_perms;
> 
> I'm not clear as to when the sockets you are referencing are being
> created; 

They appear with the label of the calling process, so it's not in mount
itself.  I'll be asking our resident NFS expert about the detailed
lifetime rules for these sockets next week once he's back from 
Connectathon.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
