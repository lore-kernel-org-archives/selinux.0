Subject: Re: Latest diffs
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41768337.3080303@redhat.com>
References: <41768337.3080303@redhat.com>
Content-Type: text/plain
Date: Wed, 20 Oct 2004 15:18:12 -0400
Message-Id: <1098299892.26380.47.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-20 at 11:24 -0400, Daniel J Walsh wrote:

> +domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)

Hm, this change seems a bit asymmetric; we don't give other userdomains
the ability to directly execute their own scripts
(httpd_staff_script_exec_t), right?  If we're going to allow this, we
should probably do it in apache_macros.te too.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
