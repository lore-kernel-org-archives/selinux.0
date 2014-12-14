Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBEG4bX9016104
 for <selinux@tycho.nsa.gov>; Sun, 14 Dec 2014 11:04:37 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so6766155wid.11
 for <selinux@tycho.nsa.gov>; Sun, 14 Dec 2014 08:04:34 -0800 (PST)
Date: Sun, 14 Dec 2014 20:04:31 +0400
From: Jason Zaman <jason@perfinion.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Subject: Re: ANN: SELinux Userspace Release: 20140826-rc7
Message-ID: <20141214160431.GA28896@meriadoc.Home>
References: <5480B2DB.6010408@tresys.com>
 <CAPzO=Ny_kUT2drj3KzW_uhLLpeOqxPJtOa5R46PGa5bhCT92Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPzO=Ny_kUT2drj3KzW_uhLLpeOqxPJtOa5R46PGa5bhCT92Eg@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Dec 14, 2014 at 04:46:40PM +0100, Sven Vermeulen wrote:
> On Thu, Dec 4, 2014 at 8:15 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> > The seventh release candidate for the next release of SELinux Userspace
> > [1] is now available. T
> [...]
> 
> Hi all
> 
> Is it possible to kepe the tmp/ directory when building/loading a policy fails?
> 
> # semodule -v -i foo.pp
> Attempting to install module 'foo.pp':
> Ok: return value of 0.
> Committing changes:
> Conflicting type rules
> Binary policy creation failed at line 177 of
> /var/lib/selinux/mcs/tmp/modules/400/java/cil

Alternatively, would it be possible to just print out line 177 to the
terminal? Diving into files is less ideal than just seeing both
conflicting lines directly in the output.

eg when there are errors during building:
/usr/bin/checkmodule:  loading policy configuration from tmp/mycustom.tmp
mycustom.te:55:ERROR 'unknown type stttttaff_t' at token ';' on line 2790:
allow stttttaff_t syslogd_t:unix_dgram_socket sendto;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration


> Failed to generate binary
> semodule:  Failed!
> 
> The tmp/ directory is cleared so it is not possible to use that
> location for troubleshooting.
> 
> In this particular case, I could find the java/cil in the
> /var/lib/selinux/mcs/active/modules/400 location, but if the error
> would be within the foo.pp-generated CIL file, then the CIL file
> cannot be found anymore.
> 
> Wkr,
>   Sven Vermeulen
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
