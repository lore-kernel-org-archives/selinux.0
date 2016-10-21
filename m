Subject: Re: [RFC] Split up policycoreutils
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <25eb370a-c909-8f86-3bc9-41f4672789f5@redhat.com>
Date: Fri, 21 Oct 2016 14:11:57 -0400
MIME-Version: 1.0
In-Reply-To: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 10/21/2016 01:47 PM, Stephen Smalley wrote:
> Hi,
>
> policycoreutils started life as a small set of utilities that were
> necessary or at least widely used in production on a SELinux system.
> Over time though it has grown to include many optional components, and
> even within a given subdirectory (e.g. sepolicy) there seem to be a
> number of components that should be optional (e.g. the dbus service).
> I'd like to propose that we move a number of components out of
> policycoreutils into their own top-level subdirectory (possibly grouping
> some of the related ones together).
>
> Some possible components to move and the rationale for doing so include:
>
> - gui: not required for operation.  Unsure if this is even used outside
> of Fedora, or how widely it is used within Fedora compared to the
> command line tools. Packaged separately by Fedora as part of
> policycoreutils-gui.
>
> - mcstrans: not required for operation outside of MLS environments (and
> even there, only if using that label encoding functionality), not built
> by default even upstream (omitted from policycoreutils/Makefile).
> Packaged separately in Fedora as mcstrans.
>
> - restorecond: not required for operation, adds dbus and glib
> dependencies, largely obsoleted by name-based type transition support in
> the kernel.  Packaged separately in Fedora as policycoreutils-restorecond.
>
> - sandbox: not required for basic operation of SELinux.  Packaged
> separately by Fedora as policycoreutils-sandbox.
>
> - semodule_deps/expand/link: developer tools only, not required for
> operation, unlike semodule.  Packaged separately by Fedora as part of
> policycoreutils-devel.
>
> - sepolicy/{org.selinux*,selinux_client.py,selinux_server.py}: D-BUS
> service for managing SELinux, not required for basic operation, not
> desirable in high security environments. Packaged separately by Fedora
> as part of policycoreutils-gui.  Could perhaps be combined with the gui
> above, although I think they are logically distinct.
>
> We could of course go further, but those seem to be the most obvious
> candidates.
>
> Thoughts?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
I am fine with this. For the most part we have separated them apart in
Red Hat based Distributions.
