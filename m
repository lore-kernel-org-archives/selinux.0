Subject: RE: SELinux RPM Version
From: Reino Wallin <reino@oribium.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: 
	<72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
References: 
	<72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
Content-Type: text/plain
Date: 23 Apr 2002 22:25:20 +0200
Message-Id: <1019593521.4289.28.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tis 2002-04-23 klockan 19.44 skrev Westerman, Mark:
> 
> After much discussion on this subject it was decided 
> that the example policy resideds in
> 
> /usr/share/doc/selinux/examples/policy
> 
OK. Would then /usr/share/doc/selinux/examples/policy/firewall and 
/usr/share/doc/selinux/examples/setfiles/firewall be correct paths for
the firewall policy and its file_contexts? 

> Policy maker should not touch 
> /etc/selinux/policy 
> in a package install. My plan is to 
> create a script that the security 
> administrator can run to install 
> a new policy.
As soon as you have something that you are willing to share. I would
like to have a copy of it.

Reino



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
