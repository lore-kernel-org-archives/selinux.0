Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Reino Wallin'" <reino@oribium.com>
Subject: Re: SELinux RPM Version
Date: Wed, 24 Apr 2002 14:17:36 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020424121737.214CA29B7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 19:44, Westerman, Mark wrote:
> > According to the recent discussions, isn't
> > /usr/share/selinux/policy/default
> > the correct install path for the example policy?

That is the path used by my Debian packages.

> After much discussion on this subject it was decided
> that the example policy resideds in
>
> /usr/share/doc/selinux/examples/policy

On the 12th of April Howard Holm convinced me to use 
/usr/share/selinux/policy as the old /usr/share/doc/selinux/examples/policy 
directory that I (and only I) had been using was inconveniantly long.

I changed my packages that day and don't plan to change them back.

Incidentally my original decision to use 
/usr/share/doc/selinux/examples/policy was made before any discussion of the 
matter (back when people were still trying to convince me that I shold use 
/usr/local for everything).

> The real policy
>
> /etc/selinux/policy

I currently have /etc/selinux be a symbolic link pointing at 
/usr/share/selinux/policy/current on my system (haven't yet changed the 
package to automatically create such a link).  Again this was at Howard's 
suggestion so that if /usr/share is shared between multiple similar machines 
then they can share the same security policy.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
