Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAOAFiVI013068
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 05:15:44 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so6340764oia.6
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 02:15:42 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5463658D.7050702@tresys.com>
References: <5463658D.7050702@tresys.com>
Date: Mon, 24 Nov 2014 11:15:42 +0100
Message-ID: <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc6
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 12, 2014 at 2:50 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The sixth release candidate for the next release of SELinux Userspace
> [1] is now available.
[...]
> Please give this a test and let us know if you find any problems.

Hi Steve & SELinux folks

With 2.4, I noticed that the user mapping now includes the "object_r" role:

# semanage user -l

                Labeling   MLS/       MLS/
SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles

root            user       s0         s0-s0:c0.c1023
object_r staff_r sysadm_r
staff_u         user       s0         s0
staff_r sysadm_r system_r
sysadm_u        user       s0         s0-s0:c0.c1023
object_r sysadm_r
system_u        user       s0         s0-s0:c0.c1023
object_r system_r
unconfined_u    user       s0         s0-s0:c0.c1023
object_r unconfined_r
user_u          user       s0         s0
object_r user_r

With 2.3, the "object_r" role was not in the list of allowed roles.

Now, I tried to remove the "object_r" role from one of my test VMs but
that totally screwed up the image (system froze, and reboot failed).
I'm not sure if I'm allowed to remove it or not now. If I should, I'll
investigate it further and see if I can get denials or other
information from it.

Wkr,
  Sven Vermeulen
