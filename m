Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CFBuC6030373
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 11:11:57 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CFBGPm015317
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:11:16 GMT
Message-ID: <452E5B37.5020200@hp.com>
Date: Thu, 12 Oct 2006 11:11:51 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] Reference policy: NetLabel policy additions
References: <20061011212958.265773000@hp.com>	 <20061011213229.879958000@hp.com> <1160664579.5980.42.camel@sgc>
In-Reply-To: <1160664579.5980.42.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-10-11 at 17:29 -0400, paul.moore@hp.com wrote:
> 
>>This patch adds basic NetLabel support to the reference policy.
> 
> Merged to the labeled networking branch.  A couple notes, mostly
> nitpicking that I skipped on your RFC email:

Thanks!  I'll grab the version you checked in and give it a quick test just to
make sure.

>>+# allow communication with kernel subsystem
>>+allow netlabel_mgmt_t self:netlink_socket create_socket_perms;
>  
> I'm guessing we don't have time to fix the kernel to make this a
> specified netlink socket, rather than using the fallback generic netlink
> socket?

No, the problem is that it is a much larger problem than just NetLabel, it's the
genetlink mechanism in general.  I heard a rumor that someone was working on
adding proper SELinux genetlink support but I haven't seen anything posted.  If
nothing appears in the next month or two I'll start working on something for
genetlink (I also owe Jamal some comments for his genetlink document).

>>@@ -155,10 +155,12 @@ ifdef(`enable_mls',`
>> 	        logging_read_generic_logs(secadm_t)
>> 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
>> 		userdom_dontaudit_read_sysadm_home_content_files(secadm_t)
>>+		netlabel_run_mgmt(secadm_t,secadm_r, { secadm_tty_device_t secadm_devpts_t })
>> 	',`
>> 		logging_manage_audit_log(sysadm_t)
>> 		logging_manage_audit_config(sysadm_t)
>> 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
>>+		netlabel_run_mgmt(sysadm_t,sysadm_r,admin_terminal)
>> 	')
> 
> 
> I thought that netlabel just had the mls level.  Wouldn't that make it
> useless on a non mls policy (the second addition is for non mls)?

There is an argument that it would still apply for the mcs case as well,
although the quality of that argument is debatable.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
