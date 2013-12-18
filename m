Message-ID: <52B201BA.9070505@tycho.nsa.gov>
Date: Wed, 18 Dec 2013 15:12:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, SELinux-NSA <SELinux@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: sepolicy-ifgen: Syntax error on line 179876 gen_context
 [type=GEN_CONTEXT]"
References: <20131217224418.04849ca7@fornost.bigon.be>
In-Reply-To: <20131217224418.04849ca7@fornost.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/17/2013 04:44 PM, Laurent Bigonville wrote:
> Hi,
> 
> With the current refpolicy, sepolicy-ifgen is complaining with the
> following error:
> 
> error parsing
> file /usr/share/selinux/default/include/kernel/selinux.if: could not
> parse text: "/usr/share/selinux/default/include/kernel/selinux.if:
> Syntax error on line 179876 gen_context [type=GEN_CONTEXT]"
> 
> 
> The line that seems to cause this issue is:
> genfscon selinuxfs /booleans/$2 gen_context(system_u:object_r:$1,s0) in
> selinux.if.
> 
> The full debug output of sepolicy-ifgen -vd is attached in this mail.

Looks like that line is commented-out in Fedora's selinux.if, and it is
preceded by a comment that notes it can only be used in the base module.

Is this a regression in sepolgen-ifgen or just never supported by it?
