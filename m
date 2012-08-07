Message-ID: <1344351171.31665.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seinfo tag label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Leonard Miyata <l.miyata@sta.samsung.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Craig, Robert P."
	 <rpcraig@tycho.ncsc.mil>
Date: Tue, 07 Aug 2012 10:52:51 -0400
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D061854A865@StaEx7mb3.telecom.sna.samsung.com>
References: 
	<C1432A7484D61749AF22A060C2B03C5D061854A865@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-03 at 18:36 -0500, Leonard Miyata wrote:
> I’ve been tasked with working on the Middleware Flask implementation
> for the SE Android Project. After spending some time trying to figure
> out the existing Android Permission enforcement, as well as the
> current state of the SE Linux/Android implementation, I am starting to
> develop some concerns on the usefulness of the Middleware
> implementation of the seinfo tag information.
> 
>  
> 
> The seinfo tag is defined in ‘class ApplicationInfo’. The ‘class
> ActivityManagerService’ maintains multiple Hash Sets of the current
> running applications (one indexed by packagename/uid, another indexed
> by pid) of ‘class ProcessRecord’, which contains a ‘ApplicationInfo
> info’ field that would contain the seinfo Tag information…
> 
>  
> 
> However, the comment in ‘class ProcessRecord’ for the ‘ApplicationInfo
> info’ field is “all about the first app in the process” which would
> seem to imply that you can have other apps, (possibly installed with
> different Security Properties) associated with the Process, and could
> be a potential loophole for Middleware Flask enforcement.

A given process will only run app components of a given UID (naturally,
as the process can only have one UID), and thus sharing within a process
can only occur within a UID.  As a UID can only be shared by apps signed
with the same certificate, you should never have a situation where a
different seinfo value (and thus a different SELinux security context)
would be assigned to an app running in the same process.

> It could very well be that calling down to the SE Linux Kernel and
> extracting the Security Context associated with the pid may provide
> better ‘trust’ for a security ‘tag’, but I have yet to figure out the
> relationship between the ‘Flask’ labels returned by the SE Linux
> Security Context, and the X.509 Certs, (and associated digital
> signatures) used to verify the ‘trust’ levels of installed packages.

The seinfo tag for the package is used to select the security context
for the process based on seapp_contexts.

The middleware Flask implementation would maintain its own notion of
security context for each app UID, which will not be the same as the
SELinux security context at the kernel layer.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
