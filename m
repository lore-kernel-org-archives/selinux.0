Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7RF6Qel022629
 for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2014 11:06:26 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so604615wiv.13
 for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2014 08:06:31 -0700 (PDT)
Received: from siphos.be (ip-83-134-237-141.dsl.scarlet.be. [83.134.237.141])
 by mx.google.com with ESMTPSA id
 k10sm1732401wjb.28.2014.08.27.08.06.28 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Aug 2014 08:06:29 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Wed, 27 Aug 2014 17:06:08 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc1
Message-ID: <20140827150608.GA6701@siphos.be>
References: <53FCA845.1030001@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53FCA845.1030001@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 26, 2014 at 11:31:17AM -0400, Steve Lawrence wrote:
> A release candidate for the next release of SELinux userspace is
> available on GitHub's releases page [1]. This release contains a handful
> of bug fixes and the new source policy/CIL work. Please let us know if
> you find any problems.
> 
> - Steve
> 
> [1] https://github.com/SELinuxProject/selinux/releases/tag/20140826-rc1

Hi Steve

Are you planning on creating tarballs for this release candidate?

Also, is this a release that requires any actions to be taken as part of an
upgrade (the move of /etc/selinux -> /var/lib/selinux)?

Wkr,
	Sven Vermeulen
