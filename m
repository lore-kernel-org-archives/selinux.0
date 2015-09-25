From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 1/3] lsm: introduce hooks for kdbus
Date: Fri, 25 Sep 2015 18:17:02 -0400
Message-ID: <1839859.ilucrGlmni@sifl>
In-Reply-To: <56043A7D.7030205@tycho.nsa.gov>
References: <20150923213043.25616.43422.stgit@localhost>
 <20150923214413.25616.29131.stgit@localhost> <56043A7D.7030205@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, September 24, 2015 02:01:33 PM Stephen Smalley wrote:
> If we want the same for MAC, I guess we either need kdbus_node to hold a
> ref to a cred (and then we can pass ep->node->cred to the hooks), or
> just add our own security field to kdbus_node.  The former seems cleaner
> to me; we can then just take an additional reference to the bus or
> endpoint creator's cred at creation time.

Agreed.

> And then we need kdbusfs to call a new hook on the inode and the cred in
> order to set the inode->i_security to something appropriate for the bus or
> endpoint creator.  Otherwise, we don't get any control over the ability to
> open any given endpoint or bus in kdbusfs, as that is only subject to the
> inode permission checks.

I'll work on something and send out an updated patchset.

-- 
paul moore
security @ redhat
