Date: Thu, 30 Nov 2017 11:31:21 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>
In-Reply-To: <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
Message-ID: <alpine.LFD.2.20.1711301130330.17322@localhost>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 29 Nov 2017, Casey Schaufler wrote:

> I see that there is a proposed fix later in the thread, but I don't see
> the patch. Could you send it to me, so I can try it on my problem?

Forwarded off-list.

Interestingly, I didn't see the KASAN output email from Stephen here.


-- 
James Morris
<james.l.morris@oracle.com>
