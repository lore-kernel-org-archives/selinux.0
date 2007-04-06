Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs
	(v2)
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4615EC45.1080408@ak.jp.nec.com>
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
	 <4615EC45.1080408@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 11:07:40 -0400
Message-Id: <1175872060.25329.35.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-06 at 15:44 +0900, KaiGai Kohei wrote:
> James Carter wrote:
> > Make the initial SID contexts accessible to userspace via selinuxfs.
> > An initial use of this support will be to make the unlabeled context
> > available to libselinux for use for invalidated userspace SIDs.
> > 
> > This version fixes the problem with the for loop that Steve pointed out,
> > and changes the flow of security_get_initial_sid_context so that the if
> > clause checks for the error condition and uses unlikely().
> > 
> > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> The attached patch enables to access /selinux/initial_contexts/*
> entries via libselinux.
> It add the following two functions:
>   int getinitsidcon(int init_sid, security_context_t * con);
>   int getinitsidcon_raw(int init_sid, security_context_t * con);
> 
> You have to specify init_sid with one of SECINITSID_* in selinux/flask.h
> 
I have been working on a patch to libselinux that would add the
functions security_get_initial_context(),
security_get_initial_context_raw() and avc_get_initial_sid() functions.
I was just planning on passing a string, like "unlabeled", to the
functions rather than a kernel initial SID, because I wanted to avoid
confusion between kernel's SIDs, which are u32, and userspace SIDs,
which are reference-counted structs.

I know that SEPostgreSQL uses its object id type as the SID.  If
userspace used unsigned integers for SIDs, then only a sid_to_context
function would be needed; it would do the right thing if the SID was in
the range of the kernel initial SIDs.

Do we need to revisit how userspace SIDs are managed?  Are there other
places were it would be better to have the object manager determine the
SID, so that it can be meaningful, rather than the userspace AVC?
What do you think Eamon?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
