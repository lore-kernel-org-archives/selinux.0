Message-ID: <72222DC86846D411ABD300A0C9EB08A10152433E@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: Howard Holm <hdholm@epoch.ncsc.mil>,
        Russell Coker
	 <russell@coker.com.au>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: RE: db conflict ?
Date: Fri, 12 Apr 2002 12:45:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, 12:30 PM Smalley, Stephen wrote:
> 
> On Fri, 12 Apr 2002, Westerman, Mark wrote:
> 
> > Since you must create ...security why on the top
> > of every file system why not put it in there ?
> 
> The per-filesystem ...security directories are for the persistent label
> mappings.  They also have a different type, and should be  distinguished
> from the compiled policy configuration.
> 
> 

The ...security/policy directory would have a type of policy_conf_t and
the program the would install a new policy would only need to have read 
permissions on file_label_t. This directory would only exist on the root
file system and not on the other filesystems. This would keep to a minimum 
differences in the FHS (v2.2).

Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
