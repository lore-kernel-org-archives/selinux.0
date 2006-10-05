Message-ID: <452525C1.7010304@hp.com>
Date: Thu, 05 Oct 2006 11:33:21 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux list <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        James Morris <jmorris@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [RFC] NetLabel: shift to using SECINITSID_UNLABLED as a base
References: <45250AF3.1020304@hp.com>
In-Reply-To: <45250AF3.1020304@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> This patch changes NetLabel from using SECINITSID_NETMSG and the parent socket's
> SID as the for the TE portion of the NetLabel context to now use
> SECINITSID_UNLABELED.  This should address the issues brought up yesterday.
> Please take a look and let me know if this what you had in mind; if it is
> acceptable I'll repost this for inclusion.
> 
> This patch is independent of the secid patches and should be treated as a bugfix
> for 2.6.19.  A similar patch to deal with the secid case will be coming later today.

Testing has shown that this patch is still missing a few pieces.  I'll have an
updated version later.  Sorry about that.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
