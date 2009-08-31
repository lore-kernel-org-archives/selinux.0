Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VCgi55000520
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 08:42:44 -0400
Subject: Re: [PATCH 3/5] cr: add generic LSM c/r support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
        Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <4A9ACD0A.9050004@schaufler-ca.com>
References: <20090828210041.GA27878@us.ibm.com>
	 <20090828210417.GC28048@us.ibm.com> <4A98AEDE.1000105@schaufler-ca.com>
	 <20090829224147.GA12549@hallyn.com> <4A99BC58.9040205@schaufler-ca.com>
	 <20090830135800.GC14699@hallyn.com>  <4A9ACD0A.9050004@schaufler-ca.com>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 08:45:50 -0400
Message-Id: <1251722750.16143.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-08-30 at 12:03 -0700, Casey Schaufler wrote:
> Serge E. Hallyn wrote:
> > Quoting Casey Schaufler (casey@schaufler-ca.com):
> >   
> >> Serge E. Hallyn wrote:
> >>     
> >>> Quoting Casey Schaufler (casey@schaufler-ca.com):
> >>>       
> >>>> But each can be expressed as a context, can't it?
> >>>>     
> >>>>         
> >>> A set of contexts (root_u:root_r:root_t:::system_u:system_r\
> >>> :system_t::...).
> >>>
> >>> There would be a problem if it were stored as a more
> >>> structured type, and if the ->restore handler wanted to
> >>> re-create an actual task_security_struct, ipc_security_struct,
> >>> etc.  So the last paragraph in the patch intro was just trying to
> >>> explain why the intermediate layer, storing a generic string on
> >>> the c/r object hash, needs to be there.  The thing that is
> >>> not possible is to place the actual void *security or a struct
> >>> task_security_struct on the objhash.
> >>>   
> >>>       
> >> Right. Now why do you need a set of contexts?
> >>     
> >
> > Because for SELinux, for instance, when checkpointing a security
> > context for a task, we want to checkpoint the actual context,
> > the fscreate context, the sockcreate context, keycreate context,
> > and the task create (exec_create) context.
> >   
> 
> My. That is quite a lot of contexts to keep track of.

Doesn't Smack also have at least one case where it supports multiple
distinct contexts for different purposes on a single object (e.g.
sockets)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
