Subject: RE: Unlabeled files - followup
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Matthew R. Singer" <msinger@itac.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAF6@mailserver.itac.reston>
References: <8A61167D13CED411B3E500B0D079784703AAF6@mailserver.itac.reston>
Content-Type: text/plain
Message-Id: <1050004680.2999.11.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Apr 2003 15:58:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-04-10 at 15:30, Matthew R. Singer wrote:
> So... Running kdm from init level 6, when it goes to get the sid, the
> current is
> System_u:system_r:init_r.  Get_ordered_sid_list() returns a 0 as it
> finds no sid confirmed with  libsecure/test/get_user_sids
> system_u:system_r:init_t root. 
> 
> libsecure/test/get_user_sids system_u:system_r:xdm_t root returns the
> proper sid(as a sanity check)
> 
> So, how do I either get init_t to be able to do a transition or get kdm
> to be xdm_t?

Try adding the following to policy/domains/program/xdm.te and reloading
your policy:
	domain_auto_trans(init_t, xdm_exec_t, xdm_t) 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
