Subject: Virtualization and SELinux
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: sds@epoch.ncsc.mil, nsa <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1098274225.12118.20.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 17:40:25 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

I am have my box up and running with (customized) targeted-selinux
policies ( spl. thanx to Stephen Smalley and Colin Walters ;-)

But, now I am stuck in issues of selinux with virtualization. I need to
virtualize my box to support multiple sites (name and ip-based) e.g

/home/virtual/siteNum/etx/passwd ..
/home/virtual/siteNum/home/USERS .. 

and different sites can have same user name right ... and these users
can easily be looked against multiple passwd for normal authentication.
But how bout SELinux ..  i know even the /usr/sbin/genhomedircon can be
modified to look into different passwd's ... but what bout the
selinux-policy ??? It can obviously not have same user names for
different users right ????

I can also insert dummy users in /etc/passwd which are unique and have
same uid/gid as /home/virtual/siteNum/etc/passwd users. So that the
selinux user name is different from the linux user name.

But will login understand this problem ??? Could anyone explain me the
behavior of login in this context ....


Jaspreet


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
