Message-ID: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Howard Holm
	 <hdholm@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: RE: db conflict ?
Date: Fri, 12 Apr 2002 12:37:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


While we are on the subject.

Could you think about placing the policy sources
into the /usr/local/selinux Directory

(i.e.
	/usr/local/selinux/policy
	/usr/local/selinux/setfiles
	/usr/local/selinux/share/doc/examples/policy
	/usr/local/selinux/share/doc/examples/setfiles


For new version of selinux the install could look and 
see if there is a /usr/local/selinux/policy and setfiles
if the directories are present the install will populate then
with the example policy. If the directories are present just
overwrite the /usr/local/selinux/share/doc/example files.


Mark  

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
