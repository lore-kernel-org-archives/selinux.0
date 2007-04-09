Message-ID: <4619AF88.9020801@ak.jp.nec.com>
Date: Mon, 09 Apr 2007 12:14:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs	(v2)
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>	 <4615EC45.1080408@ak.jp.nec.com> <1175872060.25329.35.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1175872060.25329.35.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I have been working on a patch to libselinux that would add the
> functions security_get_initial_context(),
> security_get_initial_context_raw() and avc_get_initial_sid() functions.
> I was just planning on passing a string, like "unlabeled", to the
> functions rather than a kernel initial SID, because I wanted to avoid
> confusion between kernel's SIDs, which are u32, and userspace SIDs,
> which are reference-counted structs.

I don't have any claim about the type of argument variables, and it seems
to me fair enough. :)
SE-PostgreSQL will be able to handle the initial SID context in either way.

> I know that SEPostgreSQL uses its object id type as the SID.  If
> userspace used unsigned integers for SIDs, then only a sid_to_context
> function would be needed; it would do the right thing if the SID was in
> the range of the kernel initial SIDs.

SE-PostgreSQL will call your new API only when a security context
associated with a persistent SID is invalid, to obtain "unlabeled"
context.
It has completely separated mapping between kernel initial SIDs and
persistent SIDs of SE-PostgreSQL, so there is no reason to restrict
the type of its arguments.

Thanks,

> Do we need to revisit how userspace SIDs are managed?  Are there other
> places were it would be better to have the object manager determine the
> SID, so that it can be meaningful, rather than the userspace AVC?
> What do you think Eamon?

-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
