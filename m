Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UIRbDQ019155
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 13:27:37 -0500
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UIQmZZ011184
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 18:26:48 GMT
Date: Mon, 30 Oct 2006 13:27:29 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: jbrindle@tresys.com, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, gcwilson@us.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <000001c6f779$515c8840$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610301237530.7342@d.namei>
References: <000001c6f779$515c8840$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Oct 2006, Venkat Yekkirala wrote:

> > I really don't know at this stage.  It seems like a generally complex 
> > problem which needs a comprehensive solution itself, assuming 
> > it's worth 
> > solving,
> 
> We have needs for forwarding controls now.

I know -- but the forwarding in this case is limited to a specific case, 
and it's not clear how generally useful this is, and what needs to be done 
for the general case.  Its presence also appears to add significant 
complexity which impacts on the common case.

> > and I don't believe we need to wait for that to implement protected 
> > paths for host to host networking.
> 
> Can you please lay out the kind of controls you have in mind
> for "protected paths for host to host networking". I want to
> see what (modified) portions I can present for upstreaming.

Let's start with the common case for non-MLS general use scenarios, then
once we have that nailed down, look at what else is needed to meaningfully
support MLS (and possibly concurrent CIPSO).

What are we currently missing, in terms of being able to label SAs, 
authorize their use, enforce flow policy, and allow applications to 
determine peer labels ?

For flow enforcement, I would like to see this done as simply as possible.  
e.g.:

# Server policy
allow httpd_server_t httpd_client_t:peer { recv send };

# Client policy
allow httpd_client_t httpd_server_t:peer { recv send };




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
