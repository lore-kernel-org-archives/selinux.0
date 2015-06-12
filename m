Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CFrMnn032641
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 11:53:22 -0400
Received: by wgme6 with SMTP id e6so27586553wgm.2
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 08:53:20 -0700 (PDT)
Received: from siphos.be (ip-81-11-253-41.dsl.scarlet.be. [81.11.253.41])
 by mx.google.com with ESMTPSA id h1sm3344825wiz.6.2015.06.12.08.53.18
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jun 2015 08:53:19 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Fri, 12 Jun 2015 17:53:15 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: New module store + /var being split off
Message-ID: <20150612155315.GA9089@siphos.be>
References: <557AF847.6090504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <557AF847.6090504@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 12, 2015 at 05:18:31PM +0200, Miroslav Grepl wrote:
> We are close to get the latest userspace (modules store + CIL) into
> Fedora. We just have a discussion about "/var" being split off and be
> mounted only very late at boot.
> 
> Can you think about an issue with that? I don't see any urgent blocker
> which blocks the boot process.

As far as I can see, there is no impact upon the boot process from anything
in /var/lib/selinux. This location only matters when you want to rebuild the
policy (or manipulate the policy, for instance when SELinux booleans are
being changed and persisted).

In Gentoo we have the 2.4 userspace in our "testing" branch for a while and
I did not receive any reports yet related to /var being a separate file
system. 

Wkr,
        Sven Vermeulen
