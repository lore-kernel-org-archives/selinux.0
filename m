From: "Stepan G. Fedorov" <stfedorov@gmail.com>
Message-ID: <53FB4EC9.4090605@gmail.com>
Date: Mon, 25 Aug 2014 18:57:13 +0400
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Subject: Re: semanage interface has no effect
References: <53FB19C7.1040500@gmail.com> <53FB35D2.3030307@tycho.nsa.gov>
 <53FB4192.8090203@gmail.com>
 <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
 <53FB49D4.8050802@tycho.nsa.gov>
In-Reply-To: <53FB49D4.8050802@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> ...but the new network permission checks will not be applied
> until/unless you configure secmark or labeled networking.  Or set the
> always_check_network policy capability to 1 for secmark, if your kernel
> supports that.

Seems I have no such capability. My /sys/fs/selinux/policy_capabilities/ 
contains only two files:
network_peer_controls
open_perms


-- 
Stepan G. Fedorov <StFedorov@gmail.com>
Tel: +7-965-750-91-91
