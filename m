Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3OL4k3x001574
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 17:05:02 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so1297401qeb.5
        for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 14:04:45 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v13 5/9] LSM: Networking component isolation
Date: Wed, 24 Apr 2013 17:04:42 -0400
Message-ID: <1548304.Ec78DztLng@sifl>
In-Reply-To: <51782DFE.3060808@schaufler-ca.com>
References: <5176ABB7.5080300@schaufler-ca.com> <18474523.4Ny9IacvUQ@sifl> <51782DFE.3060808@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, April 24, 2013 12:09:50 PM Casey Schaufler wrote:
> On 4/24/2013 11:51 AM, Paul Moore wrote:
> > On Tuesday, April 23, 2013 09:04:31 AM Casey Schaufler wrote:
> >> Subject: [PATCH v13 5/9] LSM: Networking component isolation
> >> 
> >> The NetLabel, XFRM and secmark networking mechanisms are
> >> limited to providing security information managed by one
> >> LSM. These changes interface the single LSM networking
> >> components with the multiple LSM system. Each of the
> >> networking components will identify the security ops
> >> vector of the LSM that will use it. There are various
> >> wrapper functions provided to make this obvious and
> >> painless.
> >> 
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > 
> > ...
> >
> >> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
> >> index a6f1705..9990b24 100644
> >> --- a/net/netlabel/netlabel_user.h
> >> +++ b/net/netlabel/netlabel_user.h
> >> @@ -41,6 +41,65 @@
> >> 
> >>  /* NetLabel NETLINK helper functions */
> >> 
> >> +extern struct security_operations *netlbl_active_lsm;
> >> +
> >> +/**
> >> + * netlbl_secid_to_secctx - call the registered secid_to_secctx LSM hook
> >> + * @secid - The secid to convert
> >> + * @secdata - Where to put the result
> >> + * @seclen - Where to put the length of the result
> >> + *
> >> + * Returns: the result of calling the hook.
> >> + */
> >> +static inline int netlbl_secid_to_secctx(u32 secid, char **secdata, u32
> >> *seclen) +{
> >> +	if (netlbl_active_lsm == NULL)
> >> +		return -EINVAL;
> >> +	return netlbl_active_lsm->secid_to_secctx(secid, secdata, seclen);
> >> +}
> >> +
> >> +/**
> >> + * netlbl_release_secctx - call the registered release_secctx LSM hook
> >> + * @secdata - The security context to release
> >> + * @seclen - The size of the context to release
> >> + *
> >> + */
> >> +static inline void netlbl_release_secctx(char *secdata, u32 seclen)
> >> +{
> >> +	if (netlbl_active_lsm != NULL)
> >> +		netlbl_active_lsm->release_secctx(secdata, seclen);
> >> +}
> >> +
> >> +/**
> >> + * netlbl_secctx_to_secid - call the registered seccts_to_secid LSM hook
> >> + * @secdata - The security context
> >> + * @seclen - The size of the security context
> >> + * @secid - Where to put the result
> >> + *
> >> + * Returns: the result of calling the hook
> >> + */
> >> +static inline int netlbl_secctx_to_secid(const char *secdata, u32
> >> seclen,
> >> +					 u32 *secid)
> >> +{
> >> +	if (netlbl_active_lsm == NULL) {
> >> +		*secid = 0;
> >> +		return -EINVAL;
> >> +	}
> >> +	return netlbl_active_lsm->secctx_to_secid(secdata, seclen, secid);
> >> +}
> >> +
> >> +/**
> >> + * netlbl_task_getsecid - call the registered task_getsecid LSM hook
> >> + * @p - The task
> >> + * @secid - Where to put the secid
> >> + *
> >> + */
> >> +static inline void netlbl_task_getsecid(struct task_struct *p, u32
> >> *secid)
> >> +{
> >> +	if (netlbl_active_lsm)
> >> +		netlbl_active_lsm->task_getsecid(p, secid);
> >> +}
> > 
> > Any particular reason you put all these functions in 'netlabel_user.h'?  I
> > ask because this header is related to the NetLabel netlink interface,
> > with some minor audit stuff tossed in for good measure; it really has
> > nothing to do with the LSM secctx/secid stuff.  I'd probably prefer these
> > functions end up in their own header file for the sake of better
> > organization, maybe
> > 'netlabel_secid.h'?
> 
> I can put it anywhere you like. I'd prefer netlabel_lsm.h to
> netlabel_secid.h, but if you have a strong preference I'll defer to your
> conventions.

That's fine too.

Thanks.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
