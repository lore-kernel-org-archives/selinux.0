Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAI0DQSM012171
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 19:13:26 -0500
Date: Wed, 18 Nov 2015 11:12:51 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Seth Forshee <seth.forshee@canonical.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 7/7] Smack: Handle labels consistently in untrusted
 mounts
In-Reply-To: <1447778351-118699-8-git-send-email-seth.forshee@canonical.com>
Message-ID: <alpine.LRH.2.20.1511181112090.1460@namei.org>
References: <1447778351-118699-1-git-send-email-seth.forshee@canonical.com>
 <1447778351-118699-8-git-send-email-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 17 Nov 2015, Seth Forshee wrote:

> +	sbsp = inode->i_sb->s_security;
> +	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&

Where is SMK_SB_UNTRUSTED defined?

I can't see it in this patch series, mainline or security next.


-- 
James Morris
<jmorris@namei.org>
