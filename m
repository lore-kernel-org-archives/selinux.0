Date: Fri, 3 Oct 2003 02:55:57 +0200
From: Tom <tom@lemuria.org>
To: "Fleischman, Eric" <eric.w.fleischman@boeing.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Security Officer and System Administrator Separation of Duties
Message-ID: <20031003025553.C28424@lemuria.org>
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com>; from eric.w.fleischman@boeing.com on Thu, Oct 02, 2003 at 03:42:30PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 02, 2003 at 03:42:30PM -0700, Fleischman, Eric wrote:
> I hope to be able to configure SELinux so that it would have policies that correspond to the traditional DoD Separation of Duties with Least Privilege practice of establishing different roles/functions for Network Administrators than for Security Officers. Specifically, I'd like the Security Officer to be solely able to establish/modify accounts and passwords, establish group memberships, establish user role memberships, etc. However, the Security Officer must not be able to perform any other traditional sysadm_r:sysadm_t functions. Similarly, I want the sysadm_r:sysadm_t to no longer be able to perform the functionalities that have now become within the sole auspices of the Security Officer. Is this possible to do? If so, how can I do this? 

This should be possible, in theory. In a practical implementation,
there are possibly a lot of holes that might be used to elevate
priviledges.

The most obvious example is, of course, that if the security officer
can modify the policy, he can grant himself additional rights.


What you certainly can do is create a sysadm_r that is limited in the
respect you wish, i.e. can not add/edit users or modify the policy.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
