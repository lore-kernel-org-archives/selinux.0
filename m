Subject: Re: [PATCH -v2] SELinux: Convert avc_audit to use lsm_audit.h
From: Eric Paris <eparis@redhat.com>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
In-Reply-To: <1247236264.2226.3.camel@Ares>
References: <1247171811.2276.13.camel@Ares>
	 <1247172234.2927.4.camel@dhcp235-23.rdu.redhat.com>
	 <1247236264.2226.3.camel@Ares>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 16:29:14 -0400
Message-Id: <1247257754.2927.19.camel@dhcp235-23.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-10 at 10:31 -0400, Thomas Liu wrote:
> Convert avc_audit in security/selinux/avc.c to use lsm_audit.h,
> for better maintainability and for less code duplication.
> 
>  - changed selinux to use common_audit_data instead of
>    avc_audit_data
>  - eliminated code in avc.c and used code from lsm_audit.h instead.
> 
> I have tested to make sure that the avcs look the same before and
> after this patch.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>

common_audit_data was a terrible structure name, I should have paid
attention to that when it went into the kernel.  Not your fault.

Acked-by: Eric Paris <eparis@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
