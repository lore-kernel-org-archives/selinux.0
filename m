Message-ID: <1482251949.25787.1.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Date: Tue, 20 Dec 2016 17:39:09 +0100
In-Reply-To: <1482250452.28169.28.camel@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482250452.28169.28.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le mardi 20 décembre 2016 à 11:14 -0500, Stephen Smalley a écrit :
> 
> Looking at your PTAGS implementation, I feel it is only fair to warn
> you that your usage of /proc/pid/attr is insecure, regardless of
> whether you use task security blobs or cred security blobs.

Fair?!

> Getting the attributes of another process via /proc/pid files is
> inherently racy, as the process may exit and another process with
> different attributes may be created with the same pid (and no, this
> is not theoretical; it has been demonstrated).

I know. And I'm surprized that you dont do anything to change that.

> Similarly, setting the
> attributes of another process via /proc/pid files is likewise
> inherently racy; you may end up setting the attributes on the wrong
> process entirely.

I also know that.

> Setting another process' attributes in this manner
> is also prone to other kinds of races, since there is no coordination
> between the process execution state and when the new tag is applied.

Yes it is expected.

> Again, I encourage you to reconsider your approach if you want to
> have a secure solution.

Well I know that managing processes is not secure because there is no
kind of unique id. But please instead of thinking that it is to risky,
please hear that some risks are manageable or acceptable.

Best regards
José
