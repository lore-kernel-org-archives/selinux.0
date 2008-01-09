From: David Howells <dhowells@redhat.com>
In-Reply-To: <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil>
References: <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil> <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil> <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk> <25037.1197306473@redhat.com> <17868.1199897484@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 09 Jan 2008 18:56:20 +0000
Message-ID: <1316.1199904980@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Right, the latter is reasonable.
> Requires adding the class and permission definition to
> policy/flask/security_classes and policy/flask/access_vectors and then
> regenerating the kernel headers from those files, ala:
>   svn co http://oss.tresys.com/repos/refpolicy/trunk refpolicy
>   cd refpolicy/policy/flask
>   vi security_classes access_vectors
>   <add new class to end>
>   make
>   make LINUX_D=/path/to/linux-2.6 tokern

Does this require rebuilding and updating all the SELinux rpms to know about
the new class?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
