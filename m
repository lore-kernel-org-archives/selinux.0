MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Unlabeled files - followup
Date: Thu, 10 Apr 2003 15:30:54 -0400
Message-ID: <8A61167D13CED411B3E500B0D079784703AAF6@mailserver.itac.reston>
From: "Matthew R. Singer" <msinger@itac.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So... Running kdm from init level 6, when it goes to get the sid, the
current is
System_u:system_r:init_r.  Get_ordered_sid_list() returns a 0 as it
finds no sid confirmed with  libsecure/test/get_user_sids
system_u:system_r:init_t root. 

libsecure/test/get_user_sids system_u:system_r:xdm_t root returns the
proper sid(as a sanity check)

So, how do I either get init_t to be able to do a transition or get kdm
to be xdm_t?

  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
