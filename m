Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 16:38:47 +0200
Cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204121003010.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204121003010.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412143847.D5446281EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 16:07, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Russell Coker wrote:
> > Although I now think that the correct thing to do is to have a
> > file_auto_trans() rule to do it.
>
> The problem with using a file_type_auto_trans rule to label /ss_policy is
> that you don't want all files created by sysadm_t in the root directory to
> end up with policy_config_t.

In normal operation there is no reason for creating any file other than 
ss_policy in the root directory.

Installing a new kernel creates a new /vmlinux symlink, but I can easily 
write some policy to not do the auto_trans thing for lnk_file objects.

> However, we could relocate /ss_policy into
> a subdirectory of the root directory, and label that subdirectory with
> policy_config_t so that subsequent installs will always pick up that type
> automatically without needing any type transition rules.

So what directory would we use?  /etc/selinux?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
