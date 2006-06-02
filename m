From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149256325.524.457.camel@moss-spartans.epoch.ncsc.mil> 
References: <1149256325.524.457.camel@moss-spartans.epoch.ncsc.mil>  <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil> <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil> <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> <12509.1149240105@warthog.cambridge.redhat.com> <12388.1149253325@warthog.cambridge.redhat.com> <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil> <12970.1149255051@warthog.cambridge.redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>,
        Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 14:53:26 +0100
Message-ID: <13521.1149256406@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Discretionary means "at the discretion of the user or program", i.e. the
> standard Linux permission checks are based on permission bits set by the
> user/program, and the user/program is free to give away access
> arbitrarily, making it vulnerable to flawed and malicious applications
> and to careless users.  Mandatory means administratively-defined policy
> along with control over all processes and objects and decisions based on
> all security-relevant information (more than just user identity).

Aha! Gotcha! Thanks.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
