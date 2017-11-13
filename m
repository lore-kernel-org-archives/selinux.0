Date: Mon, 13 Nov 2017 17:45:24 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <1509458646.20694.10.camel@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.20.1711131734230.32474@localhost>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
 <1509390973.10174.9.camel@tycho.nsa.gov>
 <alpine.LFD.2.20.1710311357320.22021@localhost>
 <1509454842.20694.1.camel@tycho.nsa.gov>
 <1509458646.20694.10.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC v0.1][PATCH] selinuxns: extend namespace support
 to security.selinux xattrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 31 Oct 2017, Stephen Smalley wrote:

> This btw would be a bit cleaner if we dropped the .ns. portion of the
> name, such that we would have:
> security.selinux # xattr name in the init namespace
> security.selinux.vmN # xattr name in the vmN namespace
> security.selinux.vmN.vmM # xattr name in the vmN.vmM namespace

Ok, just to clarify, the namespace name in the last example is "vmN.vmM", 
not "vmM" ?

i.e. the namespaces are always hierarchical, and the security labels are 
identified by that hierarchy.  If you enter vmM from the init namespace, 
for example, the security labels for it are distinct from the labels under 
vmN.  On disk, you would have both:

security.selinux.vmM
security.selinux.vmN.vmM

which are independent.

Each of these instances would potentially inherit different labels, and 
have different provenance characteristics, so this seems necessary in any 
case.


-- 
James Morris
<james.l.morris@oracle.com>
