Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Stephen Smalley'" <sds@tislabs.com>,
        Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 20:03:44 +0200
Cc: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
References: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020412180344.BC8BF2845B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 19:37, Westerman, Mark wrote:
> Could you think about placing the policy sources
> into the /usr/local/selinux Directory
>
> (i.e.
> 	/usr/local/selinux/policy
> 	/usr/local/selinux/setfiles
> 	/usr/local/selinux/share/doc/examples/policy
> 	/usr/local/selinux/share/doc/examples/setfiles

I don't like any of that.

/usr/local is for the local sysadmin to copy files into, not for packaged 
software.

> For new version of selinux the install could look and
> see if there is a /usr/local/selinux/policy and setfiles
> if the directories are present the install will populate then
> with the example policy. If the directories are present just
> overwrite the /usr/local/selinux/share/doc/example files.

That's mostly what I'm doing with my Debian packages, but with /etc/selinux.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
