Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 23:01:41 +0200
Cc: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux@tycho.nsa.gov
References: <Pine.GSO.4.33.0204121514350.21729-100000@raven> <20020412201148.E8D262870D@lyta.coker.com.au> <20020412162551.C15470@gricklegrass.epoch.ncsc.mil>
In-Reply-To: <20020412162551.C15470@gricklegrass.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020412210141.AD99F3EFE7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 22:25, Howard Holm wrote:
> Bringing up again a proposal of mine from April 3rd, I suggest that we
> put the "example" policy in /usr/share/selinux/policy/default/ and
> compile the policy in automated scripts from
> /usr/share/selinux/policy/current/.  When creating current, it should
> be a link to default.  If the admin changes the link or removes it
> in favor of an actuall local directory then all that happens when an
> automated script installs new default policy language and recompiles
> and installs "current" is that the real current policy is reinstalled
> if it is different than the default.  If it is a link to the default,
> then the updated default policy is compliled and installed.  This
> seems to be a good compromise between not arbitrarily replacing a
> local administrative policy while still allowing the majority of
> people who use the default policy to have it automatically maintained
> and added to when adding new packages.

I like this idea, apart from one issue.

Symbolically linking to default does not work well with packaging systems, so 
I'll use "cp -a" instead.

One benefit of this is that it allows for easily creating several sets of 
sample configurations that could be used.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
