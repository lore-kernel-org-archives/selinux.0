Subject: Re: Setools 1.0.1 released
From: Karl MacMillan <kmacmillan@tresys.com>
To: Dale Amon <amon@vnl.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20031107131519.GF22435@vnl.com>
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
	 <20031107131519.GF22435@vnl.com>
Content-Type: text/plain
Message-Id: <1068222062.6381.13.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 07 Nov 2003 11:21:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-07 at 08:15, Dale Amon wrote:
> On Mon, Nov 03, 2003 at 03:16:22PM -0500, Karl MacMillan wrote:
> > We have just released version 1.0.1 of setools. This is a minor update

> Do your tools allow study of policy files on the
> non-selinux build system? Or are there command line
> tools useable directly on the target system?

The policy analysis tool apol doesn't require selinux at all and the
policy editing tool sepcut only needs checkpolicy for full
functionality. You can simply copy your policy source files and a
policy.conf file from your server to a desktop machine to edit and
analyze your policy.

The selinux/linux user management tool seuser can be run from the
command line. Unfortunately, the current release still links with and
requires Tcl/TK and therefore requires at least the X libraries to be
present. Our next release removes this requirement. We are also working
on some command line policy query tools that allow you to do some of the
simpler queries from apol. I'm not certain when these will be released,
but they may be included with our next release in late November or
December.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
