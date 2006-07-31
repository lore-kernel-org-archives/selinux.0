Subject: Re: [PATCH 0/2] new and improved range_transition statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1154351236.26550.14.camel@localhost.localdomain>
References: <44CA2919.4010708@trustedcs.com>
	 <1154351236.26550.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 09:56:24 -0400
Message-Id: <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 09:07 -0400, Karl MacMillan wrote:
> My biggest question is how to handle the format change. There are some
> other bug fixes awaiting a module format change (not certain about
> kernel format change) and it would be nice to include those in this
> format bump. Unfortunately there are not patches for those fixes at the
> moment.
> 
> Could we branch the code for a month or so for the other changes can be
> introduced or is the fix more critical? Do you think that this must go
> into RHEL 5 / FC6? Is it possible for the kernel changes to make it in
> time for 2.6.18 and if they don't will this be included in RHEL 5 / FC6?

It doesn't necessarily have to be in 2.6.18 to make RHEL5; consider the
MLSXFRM and NetLabel patches, which are being queued for 2.6.19 but IIUC
will be back ported and included in RHEL5.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
