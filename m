Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94HfpEl024700
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 13:41:51 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94Hed5l003491
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 17:40:40 GMT
Date: Wed, 4 Oct 2006 12:41:49 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Linda Knippers <linda.knippers@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <method@gentoo.org>,
        Joy Latten <latten@austin.ibm.com>, redhat-lspp@redhat.com,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        eparis@parisplace.org, Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Message-ID: <20061004174149.GD10195@w-m-p.com>
References: <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org> <4522D5C2.8060702@hp.com> <4522D667.5030401@mentalrootkit.com> <4522DA79.6080708@hp.com> <4522E6F7.1040207@gentoo.org> <4522EB42.9070502@hp.com> <1159973836.19176.89.camel@moss-spartans.epoch.ncsc.mil> <4523D140.5030103@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4523D140.5030103@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 04, 2006 at 11:20:32AM -0400, Linda Knippers wrote:
> Thanks for the reminder about that thread.
> https://www.redhat.com/archives/redhat-lspp/2006-August/msg00008.html
> 
> I didn't really see a conclusion though.  Dan was waiting to hear from
> Steve.  Steve didn't like it for the reasons I mentioned above.  Were
> the auditallows added to the MLS policy?  Did anyone create a module?

Yes, it's part of the "lspp_policy" module included in the kickstart
config RPM I posted yesterday.

This reminds me - can we assume that the setsocketcreate and
setipccreate attributes will remain unimplemented for RHEL5? If they get
added at the last minute the people who write the tests would get very
unhappy.

-Klaus

policy_module(lspp_policy,1.0)

gen_require(`
        attribute domain;
')

# Audit setting of security relevant process attributes
# These settings are OPTIONAL
auditallow domain self:process setcurrent;
auditallow domain self:process setexec;
auditallow domain self:process setfscreate;
#auditallow domain self:process setsocketcreate; # FIXME
#auditallow domain self:process setipccreate; # FIXME


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
