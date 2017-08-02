Message-ID: <1501692957.3000.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Carlos Rodrigues <cefrodrigues@gmail.com>, selinux@tycho.nsa.gov
Date: Wed, 02 Aug 2017 12:55:57 -0400
In-Reply-To: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
References: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: httpd_graceful_shutdown makes httpd_can_network_connect mostly
 mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-08-02 at 16:41 +0100, Carlos Rodrigues wrote:
> Hi,
> 
> I don't know if this a too basic question to ask here, or the proper
> place, but here it goes:
> 
> I've been chasing some weird (to me) behavior with the targeted
> policy
> on a VM running nginx as a reverse proxy. What happens is that the
> "httpd_can_network_connect" boolean needs to be enabled for nginx to
> be able to reach its upstream servers. So far, so good.
> 
> However, if the upsteam server happens to be listening in one of the
> "http_port_t" ports, "httpd_can_network_connect" isn't needed because
> the "httpd_graceful_shutdown" (default enabled) provides the required
> allow rule ("name_connect").
> 
> This seems strange to me. Is this supposed to be like this? I would
> expect nginx to be totally unable to establish outbound connections
> by
> default.

In part your question is more appropriate for the Fedora selinux
mailing list since it concerns the particular SELinux policy / boolean
defaults used by Fedora, or perhaps the refpolicy mailing list if the
same is true of upstream refpolicy (I don't know if it is or not). 
However, the underlying kernel issue has come up in the upstream
SELinux kernel issue tracker, see the below link for more context:
https://github.com/SELinuxProject/selinux-kernel/issues/21


> Best regards,
> 
> Carlos Rodrigues
> 
> PS: I just spent a few hours on this, wondering why one machine
> needed
> "httpd_can_network_connect" and another did not. I guess I've mostly
> been setting up reverse proxies for "http_port_t" upstreams on CentOS
> all this time...
