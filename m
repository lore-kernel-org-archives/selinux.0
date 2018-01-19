Message-ID: <1516368559.2560.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 19 Jan 2018 08:29:19 -0500
In-Reply-To: <20180119101951.GA4126@julius.enp8s0.d30>
References: <20180119101951.GA4126@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: default_type limitations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-01-19 at 11:19 +0100, Dominick Grift wrote:
> The default_type functionality is too limited because it assumes that
> all login programs associate the same type with a given role
> 
> This is not the case
> 
> For example:
> 
> default_type for local_login: joe.role:joe.type
> default_type for sshd: joe.role:joe_ssh_server.type
> default_type for cockpit joe.role:joe_cockpit_bridge.type
> 
> etc
> 
> So pam_selinux "select_context" can only support a single login
> program due to this
> 
> I do not understand why default_type is needed in the first place.
> The contexts/users/ file is more specific:
> 
> /etc/selinux/TYPE/contexts/users/joe.user:
> sys.role:login.type:s0 joe.role:joe.type:s0 joe1.role:joe1.type:s0
> sys.role:sshd.type:s0 joe.role:joe_ssh_server.type:s0
> joe1.role:joe1_ssh_server.type:s0
> sys.role:cockpit_session.subj:s0 joe.role:joe_cockpit_bridge.type:s0
> joe1:joe1_cockpit_bridge.type:s0
> 
> ie. its already specified that for example joe1.type is default type
> for joe1.role for local_login and that joe1_ssh_server.type is
> default type for joe1.role for sshd
> 
> So unless i am overlooking something, the default_type file is
> redundant and it actually adds an extra file to configure

IIRC, it was first introduced and used by newrole to obtain a default
type for the role so the user wouldn't have to always specify -t, and
predates the introduction of the default_contexts and users/*
configurations.  Yes, it could likely be replaced with something more
flexible.  I'd like for all of that logic and configuration to get
overhauled and /sys/fs/selinux/user to die.
