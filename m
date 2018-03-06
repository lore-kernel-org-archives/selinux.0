Date: Tue, 6 Mar 2018 14:04:26 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: paul@paul-moore.com, selinux@tycho.nsa.gov, peter.enderborg@sony.com
In-Reply-To: <20180305164756.7878-2-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1803061404050.19736@namei.org>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
 <20180305164756.7878-2-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH 2/2] selinux: wrap AVC state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 5 Mar 2018, Stephen Smalley wrote:

> Wrap the AVC state within the selinux_state structure and
> pass it explicitly to all AVC functions.  The AVC private state
> is encapsulated in a selinux_avc structure that is referenced
> from the selinux_state.
> 
> This change should have no effect on SELinux behavior or
> APIs (userspace or LSM).
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>
