Message-ID: <1482171496.2178.10.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, john.johansen@canonical.com
Date: Mon, 19 Dec 2016 19:18:16 +0100
In-Reply-To: <986562c7-08e2-3aa7-1a4c-4fa21d15f14a@schaufler-ca.com>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <1482167344.28570.38.camel@tycho.nsa.gov>
 <986562c7-08e2-3aa7-1a4c-4fa21d15f14a@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le lundi 19 décembre 2016 à 10:00 -0800, Casey Schaufler a écrit :

(snip)

> Not every approach to security relies on being unable to change
> another process' attributes. I know of people who believe that
> SELinux would be more secure if an application launcher could set
> the context on another process. While I do not agree with these
> people I understand the logic they use and why it does not apply
> to SELinux or Smack.
> 
> Consider a module that does statistical analysis on program behavior
> and tags (using PTAGS or something similar) processes that are
> behaving in suspect ways. You probably don't want the math running
> in the kernel. The kernel decides to start denying the suspect
> process access once some tagging threshold is exceeded. Sure, you
> might be able to come up with some mechanism to get the process to
> tag itself, but it's kind of silly to make it hard when it doesn't
> have to be.

That is a very example of what can be achieved using PTAGS. Thank you.

> If you can suggest a mechanism that achieves Jose's goals (which
> may not match your goals) that does not require allowing a process
> to change another's security attributes I'm sure we'd all be
> interested.

Yes. And what would imply the ability to write to /proc/pid/attr
