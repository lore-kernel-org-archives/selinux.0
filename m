Subject: Re: SELinux RPM Version
From: Reino Wallin <reino@oribium.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20020424121737.214CA29B7@lyta.coker.com.au>
References: 
	<72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
	<20020424121737.214CA29B7@lyta.coker.com.au>
Content-Type: text/plain
Date: 25 Apr 2002 00:38:49 +0200
Message-Id: <1019687930.27628.46.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ons 2002-04-24 klockan 14.17 skrev Russell Coker:
> 
> On the 12th of April Howard Holm convinced me to use 
> /usr/share/selinux/policy as the old /usr/share/doc/selinux/examples/policy 
> directory that I (and only I) had been using was inconveniantly long.
> 
My intention is to use the directory Howard Holm suggested, so I'll put the firewall policy 
in /usr/share/selinux/policy/firewall

> > The real policy
> >
> > /etc/selinux/policy
> 
> I currently have /etc/selinux be a symbolic link pointing at 
> /usr/share/selinux/policy/current on my system (haven't yet changed the 
> package to automatically create such a link).  Again this was at Howard's 
> suggestion so that if /usr/share is shared between multiple similar machines 
> then they can share the same security policy.
> 

I like Howards suggestion and ability to share the policy. However, I
thought he suggested /etc/security/policy to link to the real policy, or
even keep the real policy files. I might have missed something here
though. This is not that important to me rigth now anyway.

Reino



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
