Message-ID: <4525A0CF.2070800@tresys.com>
Date: Thu, 05 Oct 2006 20:18:23 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] libselinux: always store raw contexts in the avc sidtab
References: <45253C1C.7010803@trustedcs.com>
In-Reply-To: <45253C1C.7010803@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Always store raw contexts in the avc sidtab.  This is accomplished by
> providing functions to deal with raw contexts when converting contexts
> to sids and vice versa.  The security_compute_av is also switch to the raw
> version because the contexts will now all be raw.  When the raw context is
> being converted to a sid, there will be no overhead.  When a translated 
> context
> is converted, there will be a translation to raw for storage.  There 
> conversion
> back from sid to context via avc_context_to_sid() will translate the 
> context,
> while avc_context_to_sid_raw() will not.  These functions make it easy to
> optimize some code paths be removing translations for contexts that will 
> never
> be presented to the user.
> 
> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
> 

Thanks, merged as of libselinux 1.30.30

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
