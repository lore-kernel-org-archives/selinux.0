From: David Howells <dhowells@redhat.com>
In-Reply-To: <1199906358.9393.324.camel@moss-spartans.epoch.ncsc.mil>
References: <1199906358.9393.324.camel@moss-spartans.epoch.ncsc.mil> <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil> <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil> <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk> <25037.1197306473@redhat.com> <17868.1199897484@redhat.com> <1316.1199904980@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Thu, 10 Jan 2008 11:09:58 +0000
Message-ID: <4917.1199963398@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> If you have a "SELinux:  policy loaded with handle_unknown=allow"
> message in your /var/log/messages, then new classes/perms that are not
> yet known to the policy will be allowed by default, so the operation
> will be permitted by the kernel.

I don't.  How do I set it?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
