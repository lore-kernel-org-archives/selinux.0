Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s639imtH016578
 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2014 05:44:48 -0400
Message-ID: <53B52610.30401@redhat.com>
Date: Thu, 03 Jul 2014 05:44:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Enforcing default_user, default_role, default_type, default_range
References: <53B4E97D.20401@gmail.com>
In-Reply-To: <53B4E97D.20401@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 07/03/2014 01:26 AM, dE wrote:
> These rules are not enforced by the object manager, but does
> restorecon read these?
No.  restorecon and other labeling tools just read the fcontext files.
>
> Also what's the effect of these statements on SELinux aware applications?
>
Most likely nothing.
> Are there tools to list these statements? I didn't find anything in
> sesearch man page, and seinfo is silent on this.
> ________________
Probably not.  seinfo/sesearch have not been updated to handle them
> _______________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
