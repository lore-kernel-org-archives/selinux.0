Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92MW2OI020924
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 18:32:02 -0400
Received: from e36.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n92MVFbx028828
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 22:31:15 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n92MTxrF022045
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:29:59 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n92MVvwJ225826
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:31:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n92MVtUa018746
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:31:56 -0600
Date: Fri, 2 Oct 2009 17:31:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@librato.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] cr: add generic LSM c/r support (v4)
Message-ID: <20091002223154.GA8873@us.ibm.com>
References: <20091002034916.GA16871@us.ibm.com> <4AC6694F.3050509@librato.com> <20091002221349.GC7446@us.ibm.com> <4AC67D5F.2030908@librato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AC67D5F.2030908@librato.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Oren Laadan (orenl@librato.com):
> 
> 
> Serge E. Hallyn wrote:
> > Quoting Oren Laadan (orenl@librato.com):
> >>
> >> Serge E. Hallyn wrote:
> >>> (wasn't versioning the patchsets before, so randomly pick 4 as
> >>> the version for this patchset...)
> >>>
> >>> Documentation/checkpoint/readme.txt begins:
> >>> """
> >>> Application checkpoint/restart is the ability to save the state
> >>> of a running application so that it can later resume its execution
> >>> from the time at which it was checkpointed.
> >>> """
> >>>
> 
> [...]
> 
> >>> +	memset(ctx->lsm_name, 0, SECURITY_NAME_MAX + 1);
> >>> +	strlcpy(ctx->lsm_name, security_get_lsm_name(), SECURITY_NAME_MAX + 1);
> >>> +	ret = ckpt_write_buffer(ctx, ctx->lsm_name, SECURITY_NAME_MAX + 1);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >>> +	ret = security_checkpoint_header(ctx);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >> This is actually a case for a 'container-global' section that would
> >> appear after the header and before the rest of the image. (Would be
> >> useful also for network namespaces).
> > 
> > But LSM's are specifically not containerized, so this is a host
> > property, not a container one.
> 
> Hmmm... does that mean you can't apply one policy to one container
> and another policy to another ?

Yup.

> Anyway, it belongs to a 'global' section, that may have 2 parts:
> host and container. (Putting it between header and arch-header
> seems weird...)

Ok, then I'll add that in the next set.

> The header doesn't hold state, it is a declarative section about
> the properties of the original host (kernel and HW).

Ok, I see.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
