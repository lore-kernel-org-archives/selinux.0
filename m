Message-ID: <4A39FC54.3080801@ak.jp.nec.com>
Date: Thu, 18 Jun 2009 17:35:32 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com
Subject: Re: type bounds audit messages
References: <1244730288.10762.120.camel@localhost.localdomain>	 <200906161040.52279.sgrubb@redhat.com>	 <1245164133.2848.12.camel@localhost.localdomain>	 <200906161123.52932.sgrubb@redhat.com>	 <1245166869.2848.21.camel@localhost.localdomain>	 <4A38727F.7090705@ak.jp.nec.com> <1245243187.29288.19.camel@localhost.localdomain>
In-Reply-To: <1245243187.29288.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By the way, we can find 8 of AUDIT_SELINUX_ERR messages more than
type_attribute_bounds_av(), such as:

 at selinux/hooks.c:4316

   audit_log(current->audit_context, GFP_KERNEL, AUDIT_SELINUX_ERR,
             "SELinux:  unrecognized netlink message"
             " type=%hu for sclass=%hu\n",
             nlh->nlmsg_type, isec->sclass);

Should it be replaced to <key>=<value> style?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
