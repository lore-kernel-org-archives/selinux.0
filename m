Subject: Re: CIL: invalid protocol (dccp portcon)
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Eric Paris <eparis@parisplace.org>
References: <56F9293A.6090902@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F93129.6020408@tycho.nsa.gov>
Date: Mon, 28 Mar 2016 09:27:05 -0400
MIME-Version: 1.0
In-Reply-To: <56F9293A.6090902@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/28/2016 08:53 AM, Dominick Grift wrote:
> 
> I was adding support for syslog ports, and /etc/services indicated to
> me that syslog(_tls) has support for dccp protocol. So tried to add
> that support in.
> 
> However when trying to specify a portcon, secilc tells me dccp is an
> invalid protocol.
> 
> e.g.
> 
> (portcon "dccp" 6514 port_obj_context)

Doesn't appear to be supported by the selinux userspace presently (even
apart from CIL).  Not sure why.  Looking back, I see the original
"SELinux support for DCCP" RFC thread, which included a (now dead) link
to patches for userspace support, but I don't see any indication that
they were ever submitted.
