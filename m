Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Tom <tom@lemuria.org>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 15:58:58 +0200
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204120840060.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204120840060.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412135859.3D809281EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 15:06, Stephen Smalley wrote:
> > but my "make install" fails:
> >
> > arkham:/etc/selinux# make install
> > install -m 644 -o root -g root policy /ss_policy
> > chsid system_u:object_r:policy_config_t /ss_policy
> > system_u:object_r:policy_config_t: Invalid argument
> > make: *** [install] Error 1
>
> This is harmless (not the cause of your problem), although it differs from
> the upstream SELinux distribution.  Russell appears to have modified the
> policy Makefile to always try to relabel /ss_policy after each install,

Yes.

Although I now think that the correct thing to do is to have a 
file_auto_trans() rule to do it.

> re-installing the modified daemons and utilities on a SELinux kernel.  It
> looks like Russell changed the policy Makefile's relabel target to refer
> to setfiles so that he could unify the policy and setfiles Makefiles.

Correct.  In the next version I'll amend this so that it doesn't abort the 
install.

> The policy.conf file may be fine, but if you are running the wrong version
> of checkpolicy, you'll generate the wrong binary representation.  You need
> to build and install the new version of checkpolicy and then build your
> policy.

Which is surprising.  My package installs it unconditionally in /usr/bin and 
then calls it with a fully qualified path.  So I don't know how this problem 
occurred.

> > maybe it's related. Since this fails, I can't relabel:
> >
> > arkham:/etc/selinux# make relabel
> > /usr/bin/load_policy /ss_policy
> > security_load_policy: Invalid argument
> > make: *** [tmp/load] Error 2
>
> I assume that this is specific to Russell's modified Makefile.  'make
> relabel' for setfiles should work fine on a non-SELinux kernel and
> shouldn't try to run load_policy.

I am changing this to have it run load_policy if it believes that it's 
necessary, but to ignore the return code.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
