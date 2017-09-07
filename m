Message-ID: <1504788923.22845.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 07 Sep 2017 08:55:23 -0400
In-Reply-To: <20170907090534.GA1813@julius.enp8s0.d30>
References: <20170907090534.GA1813@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-09-07 at 11:05 +0200, Dominick Grift wrote:
> pam_selinux requirements are generally pretty simple: its used to
> associate a context with a login shell.
> 
> With systemd things have becomes a bit more complicated.
> 
> systemd uses pam_selinux to associate a context with both a login
> shell (via container-shell@.service) as well as with a systemd --user 
> instance.
> 
> Ideally one would not associate a login shell context with a systemd
> --user instance because a systemd --user instance needs permissions
> that do not make sense for a login shell to have.
> 
> I am not aware of any way to make pam_selinux associate a context
> based on variable like for example: if its a login shell then
> associate this context , and if its a systemd --user instance then
> associate that context
> 
> This is an issue for me currently because if users are allowed to
> "host-shell" (machinectl shell .host) then they are able to open a
> shell with the context of the systemd --user instance and escape
> their shell restrictions
> 
> For now I can just block host-shell access with polkit but I am
> trying to figure out what it would take to address this challenge
> with pam_selinux

The logic for determining a security context from pam_selinux (using
libselinux get_ordered_context_with_level) can take the source/from
context (i.e. the context in which the caller of pam_selinux is running
) into account as a factor in selecting which context to use, since it
checks reachability (transition permission) as part of
security_compute_user().  So that's a possible approach if you can
distinguish what contexts are reachable for systemd --user vs login
daemons.

What SELinux permissions are required to host-shell?  Can you block
that via SELinux policy rather than just polkit?

Running machinectl shell .host locally doesn't seem to work:
$ machinectl shell .host
Failed to get shell PTY: Access denied

Ideally, I'd like to get rid of security_compute_user() entirely, take
the logic for determining user context entirely to userspace, and
simplify it significantly, both in libselinux and in pam_selinux. 
That's been discussed previously on the list.
