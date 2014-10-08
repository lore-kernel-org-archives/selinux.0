Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s98CPJ1X000937
 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2014 08:25:20 -0400
Message-ID: <54352D2A.1080300@tresys.com>
Date: Wed, 8 Oct 2014 08:25:14 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc4
References: <5433E840.8060605@tresys.com>
 <CAPzO=NyrMVFT8tR4t_Xt6rP_i0aw5za7havPUJzR7j1PPeGXSg@mail.gmail.com>
In-Reply-To: <CAPzO=NyrMVFT8tR4t_Xt6rP_i0aw5za7havPUJzR7j1PPeGXSg@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/07/2014 02:57 PM, Sven Vermeulen wrote:
> On Tue, Oct 7, 2014 at 3:18 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>> The fourth release candidate for the next release of SELinux Userspace
>> [1] is now available. The tarballs have been built and can be downloaded
>> from the Releases wiki page [2]. Changes since rc2 include:
> [...]
>> Please give this a test and let us know if you find any problems.
> 
> The migration now finished with returncode 0. I did have a warning
> during the migration but if I recall correctly it was already
> mentioned on the list:
> 
> Attempting to rebuild policy from /var/lib/selinux
> sysnetwork: Warning: 'else' blocks in optional statements are
> unsupported in CIL. Dropping from output.
> 
> Things seem to work well. I removed the /etc/selinux/mcs/modules
> location to be certain. I'll do some more intensified testing later
> and get back to you guys (just wanted to confirm that the previously
> reported error was fixed).
> 

Good to hear! And you are correct, the warning message is expected.

Thanks,
- Steve
