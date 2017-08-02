Message-ID: <1501700374.3000.15.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Wed, 02 Aug 2017 14:59:34 -0400
In-Reply-To: <20170802163500.GA16782@julius.enp8s0.d30>
References: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
 <20170802163500.GA16782@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: httpd_graceful_shutdown makes httpd_can_network_connect mostly
 mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-08-02 at 18:35 +0200, Dominick Grift wrote:
> On Wed, Aug 02, 2017 at 04:41:00PM +0100, Carlos Rodrigues wrote:
> > Hi,
> > 
> > I don't know if this a too basic question to ask here, or the
> > proper
> > place, but here it goes:
> > 
> > I've been chasing some weird (to me) behavior with the targeted
> > policy
> > on a VM running nginx as a reverse proxy. What happens is that the
> > "httpd_can_network_connect" boolean needs to be enabled for nginx
> > to
> > be able to reach its upstream servers. So far, so good.
> > 
> > However, if the upsteam server happens to be listening in one of
> > the
> > "http_port_t" ports, "httpd_can_network_connect" isn't needed
> > because
> > the "httpd_graceful_shutdown" (default enabled) provides the
> > required
> > allow rule ("name_connect").
> > 
> > This seems strange to me. Is this supposed to be like this? I would
> > expect nginx to be totally unable to establish outbound connections
> > by
> > default.
> > 
> > Best regards,
> > 
> > Carlos Rodrigues
> > 
> > PS: I just spent a few hours on this, wondering why one machine
> > needed
> > "httpd_can_network_connect" and another did not. I guess I've
> > mostly
> > been setting up reverse proxies for "http_port_t" upstreams on
> > CentOS
> > all this time...
> 
> I think the "httpd_graceful_shutdown" is an apache thing (probably
> for "apachectl graceful-stop"). However I cannot reproduce this
> behavior with httpd-2.4.27-4.fc27.

Hmm...neither can I; seemingly apachectl graceful-stop works without
requiring this boolean anymore.  So maybe it can be disabled by default
and removed at some point in Fedora policy?
