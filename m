Subject: Re: type bounds audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com,
        Karl MacMillan <kmacmillan@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A39FC54.3080801@ak.jp.nec.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <200906161040.52279.sgrubb@redhat.com>
	 <1245164133.2848.12.camel@localhost.localdomain>
	 <200906161123.52932.sgrubb@redhat.com>
	 <1245166869.2848.21.camel@localhost.localdomain>
	 <4A38727F.7090705@ak.jp.nec.com>
	 <1245243187.29288.19.camel@localhost.localdomain>
	 <4A39FC54.3080801@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 08:54:28 -0400
Message-Id: <1245329668.3033.94.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-06-18 at 17:35 +0900, KaiGai Kohei wrote:
> By the way, we can find 8 of AUDIT_SELINUX_ERR messages more than
> type_attribute_bounds_av(), such as:
> 
>  at selinux/hooks.c:4316
> 
>    audit_log(current->audit_context, GFP_KERNEL, AUDIT_SELINUX_ERR,
>              "SELinux:  unrecognized netlink message"
>              " type=%hu for sclass=%hu\n",
>              nlh->nlmsg_type, isec->sclass);
> 
> Should it be replaced to <key>=<value> style?

As long as it doesn't break existing userspace, that is fine with me.
Offhand, the only SELINUX_ERR message that is presently parsed by
userspace is the compute_sid one, by audit2allow/sepolgen (in order to
generate role-type statements when they are missing on a domain
transition).  And even that is a fairly rare case and could perhaps be
changed with minimal disruption.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
