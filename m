Date: Tue, 6 Mar 2018 14:02:05 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: paul@paul-moore.com, selinux@tycho.nsa.gov, peter.enderborg@sony.com
In-Reply-To: <20180305164756.7878-1-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1803061401470.19736@namei.org>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH 1/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 5 Mar 2018, Stephen Smalley wrote:

> Move global selinuxfs state to a per-instance structure (selinux_fs_info),
> and include a pointer to the selinux_state in this structure.
> Pass this selinux_state to all security server operations, thereby
> ensuring that each selinuxfs instance presents a view of and acts
> as an interface to a particular selinux_state instance.
> 
> This change should have no effect on SELinux behavior or APIs
> (userspace or LSM).  It merely wraps the selinuxfs global state,
> links it to a particular selinux_state (currently always the single
> global selinux_state) and uses that state for all operations.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
