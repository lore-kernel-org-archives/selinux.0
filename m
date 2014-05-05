Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s45BwYKM020555
 for <selinux@tycho.nsa.gov>; Mon, 5 May 2014 07:58:34 -0400
Message-ID: <53677D27.9040802@tresys.com>
Date: Mon, 5 May 2014 07:59:35 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: How does policy loading work at bootup?
References: <5365CECF.5010808@gmail.com>
In-Reply-To: <5365CECF.5010808@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2014 01:23 AM, dE wrote:
> Does the kernel automatically searches for and reads the policies in hard coded locations or does some userspace tool does that at startup via init/systemd scripts/units?

A long long time ago (before SELinux was accepted into Linus's tree), the kernel used to read the policy itself.  Now it is loaded by userspace, typically either by the init program, or by the initramfs.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
