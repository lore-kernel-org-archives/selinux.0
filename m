Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil>
References: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>
	 <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil>
	 <12509.1149240105@warthog.cambridge.redhat.com>
	 <12388.1149253325@warthog.cambridge.redhat.com>
	 <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>
	 <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:30:29 -0400
Message-Id: <1149255029.524.444.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-02 at 09:28 -0400, Stephen Smalley wrote:
> Also, to clarify re label(l)ing, each key is labeled based on the
> creating task's security context, which doesn't necessarily have
> anything to do with "belonging" or "possesssion", and the label remains
> invariant for the lifetime of the key (non-tranquility).

Oops, I meant "tranquility" above, naturally.  And "possession".

>   An extended
> interface will be added via subsequent patch to permit keys to be
> created with a specified security context (using the existing model
> of /proc/self/attr) so that the login managers can create keys based on
> the session security context rather than based on their own security
> context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
