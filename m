Date: Fri, 7 Nov 2003 21:23:33 +0000
From: Dale Amon <amon@vnl.com>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Dale Amon <amon@vnl.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Setools 1.0.1 released
Message-ID: <20031107212333.GI22435@vnl.com>
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com> <20031107131519.GF22435@vnl.com> <1068222062.6381.13.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068222062.6381.13.camel@colossus.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 07, 2003 at 11:21:02AM -0500, Karl MacMillan wrote:
> The policy analysis tool apol doesn't require selinux at all and the
> policy editing tool sepcut only needs checkpolicy for full
> functionality. You can simply copy your policy source files and a
> policy.conf file from your server to a desktop machine to edit and
> analyze your policy.

Thanks. That could be very useful. It's the main reason I've not
spent time learning how to use them so far.

> The selinux/linux user management tool seuser can be run from the
> command line. Unfortunately, the current release still links with and
> requires Tcl/TK and therefore requires at least the X libraries to be
> present. Our next release removes this requirement. We are also working
> on some command line policy query tools that allow you to do some of the
> simpler queries from apol. I'm not certain when these will be released,
> but they may be included with our next release in late November or
> December.

I guess I'll have to wait on that one then. There's
just no way X libs are sneaking onto my firewalls! :-)

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
