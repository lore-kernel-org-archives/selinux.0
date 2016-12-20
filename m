Message-ID: <1482244841.2203.5.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Casey Schaufler <casey@schaufler-ca.com>, John Johansen
 <john.johansen@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org
Date: Tue, 20 Dec 2016 15:40:41 +0100
In-Reply-To: <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le lundi 19 décembre 2016 à 13:25 -0800, Casey Schaufler a écrit :

snip
> 
> A brief look at the existing modules leads me to believe that
> everyone ought to be happier if we moved the LSM task blob out
> of the cred structure. SELinux keeps a small (6xu32) task blob
> that has no reason to share and refcount. Smack has a couple of
> lists in the task blob that really shouldn't be in the cred.
> There would have to be some rework of the task_alloc and task_free
> hooks to get the life of the blobs correct, but I think on the
> whole it would be lots cleaner.
> 

Hi Casey,

Let suppose that creds is, in effect, the wrong place for implementing
PTAGS and let suppose that the correct way is to add a t_ptags element
in the task structure.

How to use task_alloc and task_free? There is nothing there. Is it just
possible to inherit or copy the parent attributes? no.

So there is a need to define a hook to copy or do something for the
child based on the parent. A new hook, a kind of 'task_child_init'
whose argument would be the task to init.

Is it it?

Best regards
José Bollo
