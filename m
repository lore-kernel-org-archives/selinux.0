Subject: Re: SELinux RPM Version
From: Reino Wallin <reino@oribium.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: 
	<72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
References: 
	<72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
Content-Type: text/plain
Date: 23 Apr 2002 18:39:27 +0200
Message-Id: <1019579967.4289.11.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

fre 2002-04-19 klockan 22.26 skrev Westerman, Mark:
> I expect to release a beta version to sourceforge 
> of an rpm package of SELinux next week.
> 
> Current Configuration.
> 
> /etc/selinux/policy	The main policy directory 
> If the directory does not exist then the rpm 
> packages will create it and install example policy files.
> 
> /etc/selinux/setfiles	Same for the policy directory
> 
> The example policy is installed
> /usr/share/doc/selinux/examples/policy
> 
According to the recent discussions, isn't  
/usr/share/selinux/policy/default
the correct install path for the example policy?

I am considering to install upcoming releases of the firewall policy in
/usr/share/selinux/policy/firewall
Am I wrong here?
-- 
Reino Wallin, Oribium Labs
reino@oribium.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
