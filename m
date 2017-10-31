Date: Tue, 31 Oct 2017 14:11:48 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <1509390973.10174.9.camel@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.20.1710311357320.22021@localhost>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
 <1509390973.10174.9.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC v0.1][PATCH] selinuxns: extend namespace support
 to security.selinux xattrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 30 Oct 2017, Stephen Smalley wrote:

> Thanks, interesting approach. One drawback is that it doesn't presently
> support any form of inheritance of labels from the parent namespace, so
> files that are shared read-only from the init namespace will show up as
> unlabeled in the child namespace until they are assigned the namespaced
> attributes.  This for example breaks running the selinux-testsuite with
> this patch applied (unless perhaps you run restorecon -R / after
> unsharing); otherwise just trying to invoke /usr/bin/runcon will fail
> since it is unlabeled in the child.  It seems like we should provide
> some form of inheritance from the parent when there is no xattr for the
> namespace itself.

I was assuming that practical use of this would involve doing a filesystem 
relabel under the newly loaded policy, on first instantiation at least.

We could try adding an selinuxfs node to specify default handling of 
unlabeled files in a child namespace, and write to that after mounting 
selinuxfs in that namespace.

e.g. echo inherit > /sys/fs/selinux/parent_ns_labels

or something.


> 
> Another potential concern is that files created in a non-init namespace
> are left completely unlabeled in the init namespace (or in any parent).
>     As long as access to unlabeled is tightly controlled, this might
> not be a problem, but I'm not sure that's guaranteed by the refpolicy
> or Fedora/RHEL policies.  We might want to initialize an xattr at every
> level of the namespace hierarchy when a new file is created based on
> the process and parent directory labels and policy at that level. 
> Otherwise, we lose all provenance information for the file outside of
> the namespace. 

Ok.


> For example, suppose I want to leak information out of
> my category set; I unshare and create files with the information, and
> they appear in the init namespace with no categories.

Nice :)

-- 
James Morris
<james.l.morris@oracle.com>
