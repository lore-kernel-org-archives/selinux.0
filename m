Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t98GtBGb025125
 for <selinux@tycho.nsa.gov>; Thu, 8 Oct 2015 12:55:11 -0400
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov,
 Paul Osmialowski <p.osmialowsk@samsung.com>
Subject: Re: [RFC PATCH v3 5/5] selinux: introduce kdbus access controls
Date: Thu, 08 Oct 2015 12:55:06 -0400
Message-ID: <2114593.jpPVmy2IkX@sifl>
In-Reply-To: <20151007230848.7823.68726.stgit@localhost>
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230848.7823.68726.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, October 07, 2015 07:08:48 PM Paul Moore wrote:
> +static int selinux_kdbus_conn_see_notification(const struct cred *creds)
> +{
> +	        return avc_has_perm(SECINITSID_KERNEL, cred_sid(creds),
> +                         SECCLASS_KDBUS, KDBUS__SEE_NOTIFICATION, NULL);
> +}

I'm going to flip the subj/obj ordering here, the passed credentials should be 
the subject.

-- 
paul moore
security @ redhat
