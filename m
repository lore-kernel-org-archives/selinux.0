Message-ID: <72222DC86846D411ABD300A0C9EB08A10152432B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Howard Holm'" <hdholm@epoch.ncsc.mil>,
        Russell Coker
	 <russell@coker.com.au>, SeLinux@tycho.nsa.gov
Cc: sds@tislabs.com, pal@tycho.nsa.gov
Subject: Policy
Date: Wed, 3 Apr 2002 13:38:57 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I guess the first step is to standardize the location
of the policy files. 

How about

The Current install of selinux program,lib and information

/usr/local/selinux/
                   bin
                   etc
                   flask
                   include
                   info
                   libexec
                   man
                   sbin
                   share
                   var
                   X11R6
Policy additions
                   policy
                   setfiles
                   share/doc/examples/
                                      policy
                                      setfiles


When performing a make quickinstall the make will not overwrite
/usr/local/selinux/policy
/usr/local/selinux/setfiles
if those directories exist. If the directories do not exist
create them and then populate them with the example policy.

The make will overwrite the example policy files.
/usr/share/doc/examples/policy
/usr/share/doc/examples/setfiles


Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
