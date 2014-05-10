Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sat, 10 May 2014 14:03:16 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ANN] SELinux userspace release
Message-ID: <20140510120315.GB6338@siphos.be>
References: <5369229C.3010707@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5369229C.3010707@tycho.nsa.gov>
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 06, 2014 at 01:57:48PM -0400, Stephen Smalley wrote:
> A new release of the SELinux userspace has been posted to:
> http://userspace.selinuxproject.org/trac/wiki/Releases
> 
> For git users, a new tag has been pushed for this release, 20140506

Thanks; I've provided it for Gentoo users already.

Yesterday I got notified about a vulnerability in libcap-ng & seunshare:
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-3215

I found quite a lot of chatter on RedHat's bugzilla and several potential
solutions; can we expect that the "proper" solution will be pushed to
policycoreutils soon as well?

The seunshare.c file hasn't been touched in a while so I assume it isn't in
yet.

Wkr,
	Sven Vermeulen
