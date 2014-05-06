Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s46JBZ90025371
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 15:11:35 -0400
Message-ID: <536933E0.9070704@redhat.com>
Date: Tue, 06 May 2014 15:11:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Subject: Re: PAM modules ordering
References: <20140506194649.2f3aa358@soldur.bigon.be>
In-Reply-To: <20140506194649.2f3aa358@soldur.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 05/06/2014 01:46 PM, Laurent Bigonville wrote:
> Hello,
>
> I was wondering, is there a list of pam modules that need to be called
> between pam_selinux close/open?
>
> On Fedora I see pam_loginuid, but are there other modules that must be
> in between, or can all the other modules be after the "pam_selinux
> open" one?
>
> Cheers,
>
> Laurent Bigonville
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
No, only thing that should not be called after pam_selinux open is an
app that wants to run a priv command.  pam_selinux open is setting the
user context, so any apps that are executed after the open will be
executed in the users context, Any app that is executed before the open
will be executed as the context of the login program.

pam_selinux will also change the labels on ttys.
