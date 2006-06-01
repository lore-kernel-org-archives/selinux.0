Message-ID: <447F177B.2090406@hp.com>
Date: Thu, 01 Jun 2006 12:36:11 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
 mode
References: <447DD3D7.4050200@trustedcs.com>	 <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>	 <447EF602.5080003@trustedcs.com> <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> If we think it is warranted, we can push up the simple patch now and
> then proceed with the more general fix later.  But I wasn't clear that
> the current behavior is a major problem, as it only affects permissive
> mode operation.   

Since permissive mode is a supported mode and the error is rather
bizarre, I'd like to see it fixed.

-- ljk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
