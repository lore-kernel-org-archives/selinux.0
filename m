Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAI04Suo011583
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 19:04:28 -0500
Date: Wed, 18 Nov 2015 11:03:58 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Seth Forshee <seth.forshee@canonical.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH v3 6/7] userns: Replace in_userns with
 current_in_userns
In-Reply-To: <1447778351-118699-7-git-send-email-seth.forshee@canonical.com>
Message-ID: <alpine.LRH.2.20.1511181103400.1460@namei.org>
References: <1447778351-118699-1-git-send-email-seth.forshee@canonical.com>
 <1447778351-118699-7-git-send-email-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 17 Nov 2015, Seth Forshee wrote:

> All current callers of in_userns pass current_user_ns as the
> first argument. Simplify by replacing in_userns with
> current_in_userns which checks whether current_user_ns is in the
> namespace supplied as an argument.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Nice cleanup.


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>
