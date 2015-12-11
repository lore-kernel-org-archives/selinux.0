Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBBKaMnT008317
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 15:36:27 -0500
Subject: Re: Exposing secid to secctx mapping to user-space
To: Daniel Cashman <dcashman@android.com>, paul@paul-moore.com
References: <566B17FB.6010405@android.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 nnk@google.com, arve@google.com, Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <566B33B3.3040901@schaufler-ca.com>
Date: Fri, 11 Dec 2015 12:36:03 -0800
MIME-Version: 1.0
In-Reply-To: <566B17FB.6010405@android.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/11/2015 10:37 AM, Daniel Cashman wrote:
> Hello,
>
> I would like to write a patch that would expose, via selinuxfs, the
> mapping between secids in the kernel and security contexts to
> user-space, but before doing so wanted to get some feedback as to
> whether or not such an endeavor could have any support upstream.

Please abandon this.

> The
> direct motivation for this is the desire to communicate calling security
> ids/contexts over binder IPC on android for use in a user-space object
> manager.  Passing the security ids themselves would be simpler and more
> efficient in the critical kernel path, but they currently have no
> user-space meaning.

The security module infrastructure makes no guarantees about
secids. A security module is not required to maintain a persistent
relationship between the secid and a particular secctx. SELinux
does maintain a persistent relationship, but I don't believe that
there is any desire to commit to everything associated with exposing
that.

Binder ought to have access to more than the secid of the processes
and objects involved. Look into the possibilities there before you
take this approach.

>
> Thank You,
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
