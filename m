Subject: Re: [PATCH] Fix set* functions parameter
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, dwalsh@redhat.com,
        Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <200605021304.31517.glommer@br.ibm.com>
References: <200605021304.31517.glommer@br.ibm.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:50:55 -0400
Message-Id: <1147092655.23640.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 13:04 -0300, Glauber de Oliveira Costa wrote:
> In general, functions in the set* family (like setcon and setfilecon) receives 
> a security_context_t as a parameter. This patch includes the correspondent 
> typemap for it, allowing those functions to be sucessfully called.

Thanks, merged as part of Dan's larger libselinux patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
