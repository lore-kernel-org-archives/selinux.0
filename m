MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Security Officer and System Administrator Separation of Duties
Date: Thu, 2 Oct 2003 15:42:30 -0700
Message-ID: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com>
From: "Fleischman, Eric" <eric.w.fleischman@boeing.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am a complete newcomer to SELinux but I did not notice any answer to my question on the Mail List Archives (though I didn't look at every entry). 

I hope to be able to configure SELinux so that it would have policies that correspond to the traditional DoD Separation of Duties with Least Privilege practice of establishing different roles/functions for Network Administrators than for Security Officers. Specifically, I'd like the Security Officer to be solely able to establish/modify accounts and passwords, establish group memberships, establish user role memberships, etc. However, the Security Officer must not be able to perform any other traditional sysadm_r:sysadm_t functions. Similarly, I want the sysadm_r:sysadm_t to no longer be able to perform the functionalities that have now become within the sole auspices of the Security Officer. Is this possible to do? If so, how can I do this? 

Thank you for your attention to this request.

--Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
