Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBJGwLYM010589
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2012 11:58:25 -0500
From: Paul Moore <pmoore@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v3 2/2] tun: fix LSM/SELinux labeling of tun/tap devices
Date: Wed, 19 Dec 2012 11:58:10 -0500
Message-ID: <2374585.ppB8RWyPuB@sifl>
In-Reply-To: <50D154B1.4010909@redhat.com>
References: <20121218225001.16104.34454.stgit@localhost> <20121218230808.GC1135@redhat.com> <50D154B1.4010909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, December 19, 2012 01:46:25 PM Jason Wang wrote:
> On 12/19/2012 07:08 AM, Michael S. Tsirkin wrote:
> > On Tue, Dec 18, 2012 at 05:53:52PM -0500, Paul Moore wrote:
> >> This patch corrects some problems with LSM/SELinux that were introduced
> >> with the multiqueue patchset.  The problem stems from the fact that the
> >> multiqueue work changed the relationship between the tun device and its
> >> associated socket; before the socket persisted for the life of the
> >> device, however after the multiqueue changes the socket only persisted
> >> for the life of the userspace connection (fd open).  For non-persistent
> >> devices this is not an issue, but for persistent devices this can cause
> >> the tun device to lose its SELinux label.
> >> 
> >> We correct this problem by adding an opaque LSM security blob to the
> >> tun device struct which allows us to have the LSM security state, e.g.
> >> SELinux labeling information, persist for the lifetime of the tun
> >> device.  In the process we tweak the LSM hooks to work with this new
> >> approach to TUN device/socket labeling and introduce a new LSM hook,
> >> security_tun_dev_attach_queue(), to approve requests to attach to a
> >> TUN queue via TUNSETQUEUE.
> >> 
> >> The SELinux code has been adjusted to match the new LSM hooks, the
> >> other LSMs do not make use of the LSM TUN controls.  This patch makes
> >> use of the recently added "tun_socket:attach_queue" permission to
> >> restrict access to the TUNSETQUEUE operation.  On older SELinux
> >> policies which do not define the "tun_socket:attach_queue" permission
> >> the access control decision for TUNSETQUEUE will be handled according
> >> to the SELinux policy's unknown permission setting.
> >> 
> >> Signed-off-by: Paul Moore <pmoore@redhat.com>
> > 
> > Looks good to me. A comment not directly related to this patch, below.
> 
> Good to me too, will do some test on this.

Great.  I'll do some more testing and make sure the LSM and SELinux crowd are 
okay with the changes.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
