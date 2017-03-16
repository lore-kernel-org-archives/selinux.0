Message-ID: <1489679415.30127.5.camel@tycho.nsa.gov>
Subject: Re: portcon in policy modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 16 Mar 2017 11:50:15 -0400
In-Reply-To: <20170315203053.GA18934@t450.enp8s0.d30>
References: <531c2329-9a0a-d6f6-5fe4-8b4614711552@gmail.com>
 <20170315203053.GA18934@t450.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-03-15 at 21:30 +0100, Dominick Grift wrote:
> On Wed, Mar 15, 2017 at 02:52:29PM -0500, Ian Pilcher wrote:
> > 10 years later, is this still accurate?
> 
> No:
> 
> echo "(portcon tcp 12345 (system_u object_r http_port_t ((s0)(s0))))"
> > myport.cil && semodule -i myport.cil

Note that this will only work on distro releases that include CIL
support (e.g. RHEL 7.3 or later, Fedora 23 or later).  Prior to that,
you would need to use semanage for port context assignments.semodu

> 
> 
> 
> > 
> >    http://danwalsh.livejournal.com/10607.html
> > 
