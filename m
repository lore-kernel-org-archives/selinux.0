Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAIImXfe025945
 for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2014 13:48:37 -0500
Message-ID: <546B9470.3090104@tresys.com>
Date: Tue, 18 Nov 2014 13:48:16 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: <mgrepl@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC] systemd the userspace object manager
References: <546B760D.8070407@tresys.com>
In-Reply-To: <546B760D.8070407@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2014 11:38 AM, Christopher J. PeBenito wrote:
> Systemd currently mixes userspace permissions into a kernel class
> (system).  This came up on the refpolicy list a few months ago[1], but
> there has been no decision or progress[2][3] that I'm aware of, so I'd
> like to reach a decision on the direction here.
> 
> Based on what was proposed for upstreaming into refpolicy, it looks like
> all of the service class permissions were duplicated into system, in
> addition to "halt" and "reboot".  This conflates kernel functions with
> systemd functions.  With the current systemd implementation, I think a
> minimum change should be:
> 
> class init_system
> {
>     halt
>     reboot
> }
> 
> class init_service
> {
>     start
>     stop
>     status
>     reload
>     enable
>     disable
> }

With some sleuthing help from a few people in the IRC channel, we found
that reload permission is used in the system class to mediate at least
the "systemctl daemon-reload", which reloads all unit files.  I'll amend
my suggestions to add a more specific permission, "reload_all_units", to
the init_system class above and below for daemon-reload, under the
assumption that a change to check the reload permission on all units
would be rejected by systemd maintainers.



> (init_ prefix added for naming convention consistency with other
> userspace classes in refpolicy)
> 
> Since we are discussing the enforcement, I'd like to review all of
> systemd's enforcement.  Right now there are checks against unit files
> and processes, both for the service object class.  I think this has
> problems as it conflates units (as service configurations) with services
> (the daemon processes).  In an ideal world (I don't know if the systemd
> code could easily support this), I think the classes should be:
> 
> class init_system
> {
>     halt
>     reboot
> }
> 
> class init_unit
> {
>     enable
>     disable
>     reload
> }
> 
> class init_service
> {
>     start
>     stop
>     status
> }
> 
> Then init_system checks would always be against systemd's type (i.e.
> init_t), init_unit would always check against the unit file type, and
> init_service would always check against the daemon process type (which
> systemd should be able to calculate since it does that for socket
> activation).
> 
> 
> [1] http://oss.tresys.com/pipermail/refpolicy/2014-July/007229.html
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=81105
> [3] https://bugzilla.redhat.com/show_bug.cgi?id=1132933
> 


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
