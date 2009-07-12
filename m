Date: Mon, 13 Jul 2009 07:56:46 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Thomas Liu <tliu@redhat.com>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        eparis@parisplace.org
Subject: Re: [PATCH -v2] SELinux: Convert avc_audit to use lsm_audit.h
In-Reply-To: <1247236264.2226.3.camel@Ares>
Message-ID: <alpine.LRH.2.00.0907130756300.29074@tundra.namei.org>
References: <1247171811.2276.13.camel@Ares>  <1247172234.2927.4.camel@dhcp235-23.rdu.redhat.com> <1247236264.2226.3.camel@Ares>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Jul 2009, Thomas Liu wrote:

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


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
