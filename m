Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Reino Wallin <reino@oribium.com>
Subject: Re: SELinux RPM Version
Date: Thu, 25 Apr 2002 01:45:57 +0200
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux <SELinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com> <20020424121737.214CA29B7@lyta.coker.com.au> <1019687930.27628.46.camel@matilda.oribium.com>
In-Reply-To: <1019687930.27628.46.camel@matilda.oribium.com>
MIME-Version: 1.0
Message-Id: <20020424234557.A28EE7BB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 00:38, Reino Wallin wrote:
> I like Howards suggestion and ability to share the policy. However, I
> thought he suggested /etc/security/policy to link to the real policy, or
> even keep the real policy files. I might have missed something here
> though. This is not that important to me rigth now anyway.

/etc/security/selinux is the new location for the compiled policy files 
loaded by the kernel.

I recall that /etc/selinux/policy was suggested, but I think that's too many 
levels of directories.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
