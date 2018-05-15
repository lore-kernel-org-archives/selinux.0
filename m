Date: Wed, 16 May 2018 07:49:17 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
In-Reply-To: <ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1805160747300.8368@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
 <5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
 <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
 <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
 <ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 15 May 2018, Casey Schaufler wrote:

> Both SELinux and Smack use netlbl_sock_setattr() in their socket_post_create()
> hooks to establish the CIPSO to use if nothing else interferes. An unfortunate
> artifact of the Smack "ambient label" implementation is that the default
> configuration is going to delete the netlbl attribute for the floor ("_")
> label. This will conflict with any value that SELinux sets. :( Smack clearly
> needs to have it's use of netlabel revised, and that is work that's going on
> in parallel with stacking. That, however, is not an infrastructure issue, it's
> an issue with how the two modules use the facilities.

Can this kind of problem be prevented at the API level?  i.e. ensure you 
can't accidentally conflict with another LSM's use of the label here?


-- 
James Morris
<jmorris@namei.org>
