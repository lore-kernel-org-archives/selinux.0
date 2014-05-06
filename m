Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s46KgZHZ031919
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 16:42:35 -0400
Date: Tue, 6 May 2014 22:42:28 +0200
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: PAM modules ordering
Message-ID: <20140506224228.160c1dcb@fornost.bigon.be>
In-Reply-To: <536933E0.9070704@redhat.com>
References: <20140506194649.2f3aa358@soldur.bigon.be>
 <536933E0.9070704@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le Tue, 06 May 2014 15:11:28 -0400,
Daniel J Walsh <dwalsh@redhat.com> a écrit :


> No, only thing that should not be called after pam_selinux open is an
> app that wants to run a priv command.  pam_selinux open is setting the
> user context, so any apps that are executed after the open will be
> executed in the users context, Any app that is executed before the
> open will be executed as the context of the login program.
> 
> pam_selinux will also change the labels on ttys.

Thanks for your answer, I guess I'll have to change what's Debian is
currently doing, and change to Fedora's way (pam_loginuid before
pam_selinux open and the rest after)
