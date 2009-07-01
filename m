Subject: Re: Problem about PAM-selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy <hewanxiang@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <2cd8d8530906302109g57ece921i8a9fcd72261c6f88@mail.gmail.com>
References: <2cd8d8530906302109g57ece921i8a9fcd72261c6f88@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 09:58:52 -0400
Message-Id: <1246456732.13464.153.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 12:09 +0800, Andy wrote:
> Hi, all,
> I have a pam-selinux problem. I know I should post it to pam list, but
> no response from them.
> 
> Things happened like this:
> I want to upgrade my pam in Fedora Core 6,  when I make my
> Linux-PAM-1.1.0, I encountered a error.
> 
> pam_selinux.c: In function `mls_range_allowed':
> pam_selinux.c:239: error: `CONTEXT__CONTAINS' undeclared (first use in
> this function)
> pam_selinux.c:239: error: (Each undeclared identifier is reported only once
> pam_selinux.c:239: error: for each function it appears in.)
> pam_selinux.c:246: error: `SECCLASS_CONTEXT' undeclared (first use in
> this function)
> 
> And I grep "CONTEXT__CONTAINS" in the whole Linux-PAM-1.1.0 source
> code packet, nowhere defines it.
> It seems to be some issues about selinux.
> Anybody can give me a help ?  Thanks.

Fedora Core 6 is ancient and unsupported.  Considered updating to a
shiny new Fedora 11?

Regardless, you'd need a new version of libselinux if you were to build
a newer version of pam_selinux.  And all the rest of the SELinux
userland.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
