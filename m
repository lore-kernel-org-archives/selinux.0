Message-ID: <72222DC86846D411ABD300A0C9EB08A10152435C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Reino Wallin'" <reino@oribium.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
Date: Tue, 23 Apr 2002 12:44:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tuesday, April 23, 2002 11:39 AM, Reino Wallin wrote:
> > 
> > Current Configuration.
> > 
> > /etc/selinux/policy	The main policy directory 
> > If the directory does not exist then the rpm 
> > packages will create it and install example policy files.
> > 
> > /etc/selinux/setfiles	Same for the policy directory
> > 
> > The example policy is installed
> > /usr/share/doc/selinux/examples/policy
> > 
> According to the recent discussions, isn't  
> /usr/share/selinux/policy/default
> the correct install path for the example policy?

After much discussion on this subject it was decided 
that the example policy resideds in

/usr/share/doc/selinux/examples/policy

The real policy

/etc/selinux/policy

The rpm verions will create and populate 
/etc/selinux/policy 
if it does not exist.

Policy maker should not touch 
/etc/selinux/policy 
in a package install. My plan is to 
create a script that the security 
administrator can run to install 
a new policy.

Mark 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
