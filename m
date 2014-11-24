Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAODe9Xq025712
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 08:40:10 -0500
Message-ID: <54733519.40706@tresys.com>
Date: Mon, 24 Nov 2014 08:39:37 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Permission requirements for semodule?
References: <CAPzO=Nx9u_mwAuiPDfpfTOt01t0JLKdgbDQ6-foTr2SZmWPo3g@mail.gmail.com>
In-Reply-To: <CAPzO=Nx9u_mwAuiPDfpfTOt01t0JLKdgbDQ6-foTr2SZmWPo3g@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2014 11:46 AM, Sven Vermeulen wrote:
> Hi all
> 
> I'm working with 2.4_rc6 (with the additional patch that Steve sent to
> the list on November 19th) and noticed that some of the utilities are
> trying to access the HLL files. Currently, our policy disallows that,
> but other than that I see no issues.
> 
> For instance, when loading a policy module (pp) using "semodule -i
> /path/to/module.pp":
> 
> type=AVC msg=audit(1416673390.476:215): avc:  denied  { read } for
> pid=2729 comm="load_policy"
> path="/var/lib/selinux/mcs/active/modules/400/selocal/hll" dev=
> "sdb2" ino=6573925 scontext=staff_u:sysadm_r:load_policy_t:s0
> tcontext=staff_u:object_r:semanage_var_lib_t:s0 tclass=file
> 
> type=AVC msg=audit(1416673390.505:217): avc:  denied  { read } for
> pid=2730 comm="setfiles"
> path="/var/lib/selinux/mcs/active/modules/400/selocal/hll" dev="sdb2"
> ino=6573925 scontext=staff_u:sysadm_r:setfiles_t:s0
> tcontext=staff_u:object_r:semanage_var_lib_t:s0 tclass=file
> 
> The module is loaded and the changes are active, so I'm inclined to
> dontaudit it. But I'd rather ask up front. What are the tools trying
> to do? And, is semanage_var_lib_t the right type for the HLL files? I
> would expect it to need to be semanage_store_t?
> 

Looks like there might be a couple of problems here.

1) As you expected, files in /var/lib/selinux should be labeled
semanage_store_t. But we don't have any filecontexts/policy for those.
The semanage_migrate_store script uses setfscreatecon to set the labels
correctly, but if you run restorecon/setfiles they're going to reset to
semanage_var_lib_t. We'll work on a refpolicy patch for that today.

2) I'm not entirely sure why load_policy and setfiles want the file:read
permission on hll files. Those programs should never be reading those
files. Perhaps semodule is leaking file descriptors or something.
Looking into it.

Thanks,
- Steve
