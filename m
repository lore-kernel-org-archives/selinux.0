Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SeLinux@tycho.nsa.gov
Subject: Re: Policy
Date: Wed, 3 Apr 2002 22:11:44 +0200
Cc: sds@tislabs.com, pal@tycho.nsa.gov
References: <72222DC86846D411ABD300A0C9EB08A10152432B@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152432B@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020403201144.D8FBE3EFF8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Apr 2002 21:38, Westerman, Mark wrote:
> I guess the first step is to standardize the location
> of the policy files.
>
> How about
>
> The Current install of selinux program,lib and information
>
> /usr/local/selinux/
>                    bin
>                    etc
>                    flask
>                    include
>                    info
>                    libexec
>                    man
>                    sbin
>                    share
>                    var
>                    X11R6
> Policy additions
>                    policy
>                    setfiles
>                    share/doc/examples/
>                                       policy
>                                       setfiles
>

How about the following for distributions other than Slackware:
/usr/bin
/usr/sbin
/usr/include/selinux
/usr/lib
/usr/share/man
/etc/policy

> When performing a make quickinstall the make will not overwrite
> /usr/local/selinux/policy
> /usr/local/selinux/setfiles
> if those directories exist. If the directories do not exist
> create them and then populate them with the example policy.
>
> The make will overwrite the example policy files.
> /usr/share/doc/examples/policy
> /usr/share/doc/examples/setfiles

s/doc/doc\/selinux/ for non-Slackware.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
