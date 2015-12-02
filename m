Subject: Re: continuation of systemd/SELinux discussion from Github
To: selinux@tycho.nsa.gov
References: <20151202101801.GA1028@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <565F366E.3030403@tycho.nsa.gov>
Date: Wed, 2 Dec 2015 13:20:30 -0500
MIME-Version: 1.0
In-Reply-To: <20151202101801.GA1028@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/02/2015 05:18 AM, Dominick Grift wrote:
> Let's continue the discussion here.
>
> The last answered questionnaire is below, any further questions or
> comments?:
>
> ----------------------------------------
>
>          "systemd --user" concept is broken as we can see/read from this
>          thread from SELinux point of view.
>
> It was working fine except that it was trying to log to the audit system
> which unprivileged processes arent allowed to do.

What's the dbus solution for this issue?

>
>          Are we able truly explain the enforcement here?
>
> I think i was able to at least identify some of it, but i probably have
> overlooked other compelling arguments:
>
> Any processes that needs to be able to "control" any system-wide systemd
> user unit, will be able to "control" all system-wide systemd user units.
>
> In practice that means that a process may be able to for example start a
> application even though it does not have access to execute that
> application by telling systemd --user do start that applications on its
> behalf

Can systemd-run --user be used to escape any of the following:
a) SELinux sandbox,
b) libvirt / svirt confinement,
c) newrole -r to a different, more restricted role or -l to a different 
level,
d) runcon to a more restricted domain.

If so, then there is a problem with systemd --user not applying its own 
access controls over its operations.

>
> A process may, for example, be able to use this to stop a sensitive
> process bypassing SELinux access control
>
>          And the point is if we have big benefits of this level of
>          isolation?
>
> With access control the benefits often depend on the requirements. but
> in general since selinux touts flexibility and one of the big benefits
> here is that we can contain access of processes to units actions.
>
> without this processes are potentially able to bypass selinux by telling
> systemd --user to do stuff on their behalf
>
>          Do we have real examples how it prevents possible security
>          flaws?
>
> No, and why should we? SELinux does not prevent possible security
> flaws. SELinux is Linux access control extension
> It enforces integrity and optional confidentiality or
> comparmentalization.
>
>          Do we talk about confined desktop here?
>
> No we are talking about a set of components that without SELinux access
> control extension potentionally allows processes
> to bypass SELinux access control restrictions in some cases
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
