Date: Mon, 6 Nov 2006 23:23:38 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 4/8] make newrole suid (take 3)
Message-ID: <20061107052338.GB11273@sergelap.austin.ibm.com>
References: <454A8F35.2020006@us.ibm.com> <454A95BC.7000807@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <454A95BC.7000807@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Michael C Thompson (thompsmc@us.ibm.com):
> Michael C Thompson wrote:
> >The 8 patches are as follows:
> >1) Modifications to Makefile to support future patch needs
> >   Add newrole-lspp.pamd
> >2) New extract_pw_data function and use in main()
> >3) Add signal handler function
> >4) Update drop_capabilities() and use in main()
> 
> This is the 4th of 8 patches.
> This patch applies against policycoreutils-1.30.30-1.
> 
> This patch adds expands the drop_capabilities functionality
> to support various compile-time options (with audit, with
> namespace, or neither).
> 
> Changes:
>  * Splits drop_capabilities into three versions (compile time option):
>    - 'No-cap' version, returns true
>    - 'audit-only' version, retains only CAP_AUDIT_WRITE
>       Enable with AUDIT_LOG_PRIV=y
>    - 'namespace+' version, retains CAP_AUDIT_WRITE, CAP_SYS_ADMIN and
>       more to allow namespace actions
>       Enable with NAMESPACE_PRIV = y
>  * main() calls drop_capabilities unconditionally

It looks like your two later versions of drop_capabilities() don't call
setresuid?  Your comment doesn't explain why, and a very quick scan of
your later patches didn't show you adding them.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
