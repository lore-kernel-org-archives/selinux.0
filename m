Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing
	PTYs,	sshd,	and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Antill <jantill@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, Klaus Weidner <klaus@atsec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <459E856B.60800@redhat.com>
References: <20070105033311.GA24315@w-m-p.com>
	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
	 <20070105040119.GB24315@w-m-p.com>
	 <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
	 <459E7BA2.1050109@redhat.com>  <459E856B.60800@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 13:34:54 -0500
Message-Id: <1168022094.18961.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-05 at 12:05 -0500, Daniel J Walsh wrote:
> First libselinux-rhat patch was broken.  Needs to only check the context 
> type.
> 
> more /etc/selinux/mls/contexts/securetty_contexts
> sysadm_tty_device_t
> staff_tty_device_t
> user_tty_device_t

Use getline() instead of fgets() to gain the benefit of automatically
allocated buffers.  See init_selinux_config() for example.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
