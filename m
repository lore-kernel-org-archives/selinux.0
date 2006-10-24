Subject: Re: [PATCH 3/4] reference policy support for setransd enhancement
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
In-Reply-To: <4534FE1E.4080502@trustedcs.com>
References: <4534FE1E.4080502@trustedcs.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 10:15:09 -0400
Message-Id: <1161699309.31675.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-17 at 11:00 -0500, Darrel Goeddel wrote:
> This patch is for the fedora policy.  I can "translate" (pun?) this to the
> current CVS policy if necessary.
> 
> Add the flask definitions for the new context class (and add the setsockcreate
> to the process class so the generated headers do not miss things) and the
> corresponding mlsconstraint.
> 
> Add an interface that will allow a domain the ability to override the MLS
> check when translating contexts (mls_context_translate_all_levels).
> 
> Make the setrans daemon run at the highest MLS label and protect the config
> file at the same label (and make this work by adding mls_socket_write_all_levels
> to the setransd policy).
> 
> Allow the translating domain TE access to translate contexts with the setrans_t
> type.  This is the type that the daemon will use when doing the check.  The
> type is from the running setransd process.

This was merged last Friday (Oct 20).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
