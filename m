Subject: Re: Security Officer and System Administrator Separation of Duties
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Fleischman, Eric" <eric.w.fleischman@boeing.com>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Tom <tom@lemuria.org>
In-Reply-To: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com>
References: 
	 <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com>
Content-Type: text/plain
Message-Id: <1065184865.4080.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Oct 2003 08:41:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-02 at 18:42, Fleischman, Eric wrote:
> I am a complete newcomer to SELinux but I did not notice any answer 
> to my question on the Mail List Archives (though I didn't look at every entry). 
> 
> I hope to be able to configure SELinux so that it would have policies 
> that correspond to the traditional DoD Separation of Duties with Least
>  Privilege practice of establishing different roles/functions for Network 
> Administrators than for Security Officers. Specifically, I'd like the Security
>  Officer to be solely able to establish/modify accounts and passwords, 
> establish group memberships, establish user role memberships, etc. However, 
> the Security Officer must not be able to perform any other traditional 
> sysadm_r:sysadm_t functions. Similarly, I want the sysadm_r:sysadm_t to no 
> longer be able to perform the functionalities that have now become within the 
> sole auspices of the Security Officer. Is this possible to do? If so, how can 
> I do this? 

This has come up several times in the past on the mailing list, e.g. see
http://marc.theaimsgroup.com/?l=selinux&m=105457887918050&w=2
http://marc.theaimsgroup.com/?l=selinux&m=101965643900447&w=2
http://marc.theaimsgroup.com/?l=selinux&m=100799744813965&w=2

It is possible to do, but you need to give it some careful thought to
provide any real security benefit (see the discussions referenced
above).  However, I do think that this would be worthwhile to do.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
